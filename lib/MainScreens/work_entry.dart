import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_to_act/slide_to_act.dart';

class NewWorkEntry extends StatefulWidget {
  const NewWorkEntry({Key? key}) : super(key: key);

  @override
  State<NewWorkEntry> createState() => _NewWorkEntryState();
}

class _NewWorkEntryState extends State<NewWorkEntry> {
  final _auth = FirebaseDatabase.instance.reference().child("staff");
  final user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();

  TextEditingController wrkdonefield = TextEditingController();
  TextEditingController percentfield = TextEditingController();

  bool isStarted = true;
  bool isSubmit = false;
  var timeDiffrence;

  var getFbTime;
  var startTime;
  var endTime;
  String? formattedTime;
  var formattedDate;
  var formattedMonth;
  var formattedYear;

  todayDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyy-MM-dd');
    var formatterYear = DateFormat('yyy');
    var formatterMonth = DateFormat('MM');
    formattedTime = DateFormat('HH:mm').format(now);
    formattedDate = formatterDate.format(now);
    formattedYear = formatterYear.format(now);
    formattedMonth = formatterMonth.format(now);
    print(formattedTime);
    print(formattedDate);
  }

  var fbData;
  String? from;
  String? to;
  var wrkDone;

  createWrkDone() {
    _auth.once().then((value) => {
      for (var element in value.snapshot.children)
        {
          fbData = element.value,
          if (fbData["email"] == user?.email)
            {
              wrkDone = element.key,
              _auth
                  .child(wrkDone)
                  .child(
                  "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/${getFbTime.toString().trim()} to ${endTime.toString().trim()}")
                  .set({
                "from": getFbTime.toString().trim(),
                "to": endTime.toString().trim(),
                "workDone": tempWrk[0],
                "workPercentage": '${percentfield.text.trim()}%',
                'name': fbData['name'],
                'time_in_hours': timeDiffrence.toString().trim()
              }).then((value) {
                deletependingWrks();
                temFromTime.clear();
                endTime = '';
                tempWrk.clear();
                wrkdonefield.clear();
                percentfield.clear();
                viewData();

              })
            }
        }
    }).then((value)  {
      getDayWrkTime();
      getMonthWrkTime();});
  }

  String? CurrerntUser;
  var fbdata1;
  var totalTime;
  List nameView = [];
  List fromView = [];
  List toView = [];
  List workDoneView = [];
  List workPercentageView = [];
  List ttlWrk = [];
  List dayTotalWrk = [];

  viewData() {
    nameView.clear();
    toView.clear();
    fromView.clear();
    workPercentageView.clear();
    workDoneView.clear();
    _auth.once().then((value) {
      for (var step1 in value.snapshot.children) {
        fbData = step1.value;
        if (fbData['email'] == CurrerntUser) {
          for (var step2 in step1.children) {
            if (step2.key == "workManager") {
              for (var step3 in step2.children) {
                for (var step4 in step3.children) {
                  if (step4.key == formattedYear) {
                    for (var step5 in step4.children) {
                      if (step5.key == formattedMonth) {
                        for (var step6 in step5.children) {
                          if (step6.key == formattedDate) {
                            for (var step7 in step6.children) {
                              fbdata1 = step7.value;
                              // print(fbdata1);
                              if (fbdata1['to'] != null) {
                                nameView.remove(fbdata1['to']);
                                setState(() {
                                  fromView.add(fbdata1['from']);
                                  toView.add(fbdata1['to']);
                                  workPercentageView
                                      .add(fbdata1['workPercentage']);
                                  workDoneView.add(fbdata1['workDone']);
                                  ttlWrk.add(fbdata1['time_in_hours']);
                                  nameView.add(fbdata1['name']);
                                  print(nameView);
                                });
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    });
  }

  pendingWrks() {
    _auth.once().then((value) => {
      for (var element in value.snapshot.children)
        {
          fbData = element.value,
          if (fbData["email"] == user?.email)
            {
              wrkDone = element.key,
              _auth
                  .child(wrkDone)
                  .child(
                  "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/pendingWorks/${startTime.toString().trim()}")
                  .set({
                "from": startTime.toString().trim(),
                "workDone": wrkdonefield.text.trim(),
                'name': fbData['name'],
              }).then((value) => viewPendingWrk())
            }
        }
    });
  }

  deletependingWrks() {
    _auth
        .once()
        .then((value) => {
      for (var element in value.snapshot.children)
        {
          fbData = element.value,
          if (fbData["email"] == user?.email)
            {
              wrkDone = element.key,
              _auth
                  .child(wrkDone)
                  .child(
                  "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/pendingWorks/")
                  .remove(),
            }
        }
    }).then((value) => {viewPendingWrk()});
  }

  bool pendingWrkStatus = false;

  List temFromTime = [];
  List tempWrk = [];

  viewPendingWrk() {
    tempWrk.clear();
    _auth.once().then((value) {
      for (var step1 in value.snapshot.children) {
        fbData = step1.value;
        if (fbData['email'] == CurrerntUser) {
          for (var step2 in step1.children) {
            if (step2.key == "workManager") {
              for (var step3 in step2.children) {
                for (var step4 in step3.children) {
                  if (step4.key == formattedYear) {
                    for (var step5 in step4.children) {
                      if (step5.key == formattedMonth) {
                        for (var step6 in step5.children) {
                          if (step6.key == formattedDate) {
                            for (var step7 in step6.children) {
                              if (step7.key == 'pendingWorks') {
                                print(step7.value);
                                for (var step8 in step7.children) {
                                  var pwrk;
                                  pwrk = step8.value;
                                  setState(() {
                                    pendingWrkStatus = true;
                                    temFromTime.add(pwrk['from']);
                                    tempWrk.add(pwrk['workDone']);
                                  });
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    });
  }

  var fbDataDayList;
  List dayWrkTimingList = [];

  getDayWrkTime() {
    _auth.once().then((value) {
      for (var step1 in value.snapshot.children) {
        fbData = step1.value;
        if (fbData['email'] == CurrerntUser) {
          for (var step2 in step1.children) {
            if (step2.key == "workManager") {
              for (var step3 in step2.children) {
                for (var step4 in step3.children) {
                  if (step4.key == formattedYear) {
                    for (var step5 in step4.children) {
                      if (step5.key == formattedMonth) {
                        for (var step6 in step5.children) {
                          if (step6.key == formattedDate) {
                            for (var mwt in step6.children) {
                              if (mwt.key != 'totalWorkingTime') {
                                fbDataDayList = mwt.value;
                                setState(() {
                                  dayWrkTimingList.add(fbDataDayList['time_in_hours']);
                                  print("${dayWrkTimingList}...............getmonth");
                                });


                              }
                            }
                          }
                        }

                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }).then((value) => {uploadDayTotalWorkTiming(),dayWrkTimingList.clear()});
  }

  int testingHours = 0;
  int finalTestingHours = 0;

  int testingMinutes = 0;
  int finalTestingMinutes = 0;
  var finalDayWrkTime;

  uploadDayTotalWorkTiming() {
    List daytimeList = dayWrkTimingList;

    for (var time in daytimeList) {

      var format = time;

      if(format != null){
        var timeFormat = DateFormat("HH:mm");
        var starTime = timeFormat.parse(format).toString().substring(10, 19);

        var hours = starTime.substring(0, 3);

        var minutes = starTime.substring(4, 6);

        testingHours = int.parse(hours);

        var addTime = finalTestingHours + testingHours;
        finalTestingHours = addTime;

        testingMinutes = int.parse(minutes);
        var addMinutes = finalTestingMinutes + testingMinutes;
        finalTestingMinutes = addMinutes;

        var today = DateTime.utc(0);
        finalDayWrkTime = today
            .add(Duration(hours: finalTestingHours, minutes: finalTestingMinutes))
            .toString()
            .substring(10, 19);

        _auth.once().then((value) => {
          for (var element in value.snapshot.children)
            {
              fbData = element.value,
              if (fbData["email"] == user?.email)
                {
                  wrkDone = element.key,
                  _auth
                      .child(wrkDone)
                      .child(
                      "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/totalWorkingTime")
                      .set({'day': finalDayWrkTime}).then((value) => {
                    finalTestingHours = 0,
                    finalTestingMinutes = 0,
                    dayWrkTimingList.clear(),
                    daytimeList.clear(),
                  })
                }
            }
        });
      }



    }

  }

//...............................month,..............................
  var fbDataMonthList;
  List monthWrkTiminglist = [];

  getMonthWrkTime() {
    _auth.once().then((value) {
      for (var step1 in value.snapshot.children) {
        fbData = step1.value;
        if (fbData['email'] == CurrerntUser) {
          for (var step2 in step1.children) {
            if (step2.key == "workManager") {
              for (var step3 in step2.children) {
                for (var step4 in step3.children) {
                  if (step4.key == formattedYear) {
                    for (var step5 in step4.children) {
                      if (step5.key == formattedMonth) {
                        for (var mwt in step5.children) {
                          if (mwt.key != 'totalWorkingTime') {
                            for (var mwt2 in mwt.children) {
                              if (mwt2.key != 'totalWorkingTime') {
                                fbDataMonthList = mwt2.value;
                                setState(() {
                                  monthWrkTiminglist.add(fbDataMonthList['time_in_hours']);
                                  print("${monthWrkTiminglist}...............getmonthwork time");
                                });
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }).then((value) => {uploadMonthWorkingTime(),});
  }

  int monthHours = 0;
  int finalMonthHours = 0;

  int monthMinutes = 0;
  int finalMonthMinutes = 0;
  var finalmothTotalWorkingTime;

  uploadMonthWorkingTime() {
    print("${monthWrkTiminglist}month work time list");
    List monthTimeList = monthWrkTiminglist;

    for (var time in monthTimeList) {

      var format = time;
      print("${format}..............format in time");

      if(format != null){
        var timeFormat = DateFormat("HH:mm");
        var starTime = timeFormat.parse(format).toString().substring(10, 19);

        var hours = starTime.substring(0, 3);

        var minutes = starTime.substring(4, 6);

        monthHours = int.parse(hours);

        var addTime = finalMonthHours + monthHours;
        finalMonthHours = addTime;

        monthMinutes = int.parse(minutes);
        var addMinutes = finalMonthMinutes + monthMinutes;
        finalMonthMinutes = addMinutes;
        // print(finalTestingMinutes);

        var today = DateTime.utc(0);
        // print(today);
        finalmothTotalWorkingTime = today
            .add(Duration(hours: finalMonthHours, minutes: finalMonthMinutes))
            .toString()
            .substring(8, 19);

        _auth.once().then((value) => {
          for (var element in value.snapshot.children)
            {
              fbData = element.value,
              if (fbData["email"] == user?.email)
                {
                  wrkDone = element.key,
                  _auth
                      .child(wrkDone)
                      .child(
                      "workManager/timeSheet/$formattedYear/$formattedMonth/totalWorkingTime")
                      .set({'month': finalmothTotalWorkingTime})
                }
            }
        }).then((value) {
          finalMonthHours = 0;
          finalMonthMinutes = 0;

          monthWrkTiminglist.clear();
          monthTimeList.clear();
        });
      }

    }


  }

  @override
  void initState() {
    todayDate();
    setState(() {
      viewPendingWrk();
      CurrerntUser = user?.email;
      viewData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final GlobalKey<SlideActionState> _key = GlobalKey();
    return Scaffold(
      body: Form(
          key: formKey,
          child: Stack(
            children: [
              Positioned(
                top: height * 0.0,
                left: width * 0.0,
                right: width * 0.0,
                child: Container(
                  child: Lottie.asset("assets/84668-background-animation.json"),
                ),
              ),
              Positioned(
                top: height * 0.75,
                left: width * 0.0,
                right: width * 0.0,
                child: Lottie.asset("assets/84669-background-animation.json"),
              ),
              Positioned(
                top: height * 0.06,
                right: width * 0.0,
                left: width * 0.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  // height: height * 0.85,
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            pendingWrkStatus == false
                                ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: height * 0.15,
                                  width: width*0.9,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(30),
                                    color: Color(0xffF7F9FC),
                                    // Colors.white.withOpacity(0.3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(9.0, 9.0),
                                        blurRadius: 9,
                                      ),
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-20.0, -1.0),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Avenir"),
                                      controller: wrkdonefield,
                                      keyboardType:
                                      TextInputType.multiline,
                                      maxLines: 5,
                                      textInputAction:
                                      TextInputAction.done,
                                      decoration: InputDecoration(
                                        fillColor: Color(0xffFBF8FF),
                                        hintStyle: const TextStyle(
                                          // fontFamily: 'Avenir',
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16,
                                            color: Colors.black54
                                          // (0xffFBF8FF)
                                        ),
                                        contentPadding:
                                        const EdgeInsets.all(20),
                                        hintText: 'Enter your Work',
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(40),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Enter value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height*0.02,
                                ),
                                SizedBox(
                                  height: height * 0.07,
                                  width: width * 0.7,
                                  child: SlideAction(
                                    sliderButtonIcon: Icon(Icons.start),
                                    key: _key,
                                    child: const Text("Slide to Start",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Nexa",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800)),
                                    innerColor: Colors.orangeAccent,
                                    outerColor: Color(0xffF7F9FC),
                                    animationDuration:
                                    Duration(milliseconds: 800),
                                    submittedIcon: Icon(
                                      Icons.done_all,
                                      color: Colors.blue,
                                    ),
                                    onSubmit: () {
                                      setState(() {
                                        var start = DateTime.now();
                                        startTime = DateFormat('HH:mm')
                                            .format(start);
                                        // isStarted = !isStarted;
                                        final isValid = formKey
                                            .currentState
                                            ?.validate();
                                        if (isValid!) {
                                          pendingWrks();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                                : Container(
                              child: pendingWrkStatus == true
                                  ? Container(
                                height: height * 0.40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(40),
                                  color: const Color(0xffF7F9FC),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(9.0, 9.0),
                                      blurRadius: 9,
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-1.0, -8.0),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: tempWrk.length,
                                  itemBuilder:
                                      (BuildContext context,
                                      int index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "pendingWorks Details",
                                          style: const TextStyle(
                                              fontFamily: 'Avenir',
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),

                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: height * 0.05,
                                                  width: width * 0.35,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    color: const Color(0xffF7F9FC),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black26,
                                                        offset: Offset(9.0, 9.0),
                                                        blurRadius: 9,
                                                      ),
                                                      BoxShadow(
                                                        color: Colors.white,
                                                        offset: Offset(-1.0, -8.0),
                                                        blurRadius: 10,
                                                      ),
                                                    ],
                                                  ),child: Row(
                                                  children: [
                                                    Text(
                                                      'Start from : ',
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'Nexa',
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          fontSize: 13,
                                                          color: Colors
                                                              .black),
                                                    ),
                                                    Text(
                                                      '${temFromTime[index]}',
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'Avenir',
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          fontSize: 12,
                                                          color: Colors
                                                              .black),
                                                    ),
                                                  ],
                                                ),
                                                )

                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              height: height * 0.11,
                                              width: width * 0.5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: const Color(0xffF7F9FC),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(9.0, 9.0),
                                                    blurRadius: 9,
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(-1.0, -8.0),
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                              ),

                                              child:
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text('working On,',
                                                        style: TextStyle(
                                                            fontFamily: 'Nexa',
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 13,
                                                            color: Colors.black)),


                                                    Text(
                                                        '${tempWrk[index]}',
                                                        style: TextStyle(
                                                            fontFamily: 'Avenir',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13,
                                                            color: Colors.black),
                                                        maxLines: 5,
                                                        overflow:
                                                        TextOverflow.ellipsis),
                                                  ],
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        Container(
                                          width: width * 0.3,
                                          height: height * 0.06,
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                20),
                                            color: Color(
                                                0xffF7F9FC),
                                            // Colors.white.withOpacity(0.3),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors
                                                    .black26,
                                                offset: Offset(
                                                    9.0, 9.0),
                                                blurRadius: 9,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child:
                                            TextFormField(
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    3),
                                              ],
                                              style: const TextStyle(
                                                  color: Colors
                                                      .black,
                                                  fontFamily:
                                                  "Nexa"),
                                              controller:
                                              percentfield,
                                              textInputAction:
                                              TextInputAction
                                                  .done,
                                              keyboardType:
                                              TextInputType
                                                  .number,
                                              decoration:
                                              InputDecoration(
                                                hintStyle: const TextStyle(
                                                    fontFamily:
                                                    'Nexa',
                                                    fontSize:
                                                    15),
                                                contentPadding:
                                                const EdgeInsets
                                                    .all(20),
                                                hintText:
                                                '   Percent',
                                                filled: true,
                                                fillColor:
                                                const Color(
                                                    0xffFBF8FF),
                                                border:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      40),
                                                  borderSide:
                                                  BorderSide
                                                      .none,
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  var end =
                                                  DateTime
                                                      .now();
                                                  endTime = DateFormat(
                                                      'HH:mm')
                                                      .format(
                                                      end);
                                                  isStarted =
                                                  !isStarted;
                                                  isSubmit =
                                                  true;
                                                  // print("End Time Pressed..............${endTime}");
                                                });
                                              },
                                              validator:
                                                  (value) {
                                                if (value
                                                    .toString()
                                                    .isEmpty) {
                                                  return 'Enter value';
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        isSubmit == true
                                            ? SizedBox(
                                          height: height * 0.07,
                                          width: width * 0.7,
                                          child: SlideAction(
                                            key: _key,
                                            child: Text("Slide to Submit",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "Nexa",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            innerColor: Colors.orangeAccent,
                                            outerColor: Color(0xffF7F9FC),
                                            animationDuration: Duration(milliseconds: 500),
                                            onSubmit: () {
                                              setState(() {
                                                // print(temFromTime);
                                                getFbTime = temFromTime[0];
                                                // print(getFbTime);

                                                String st = getFbTime.trim().replaceAll(RegExp(r'[^0-9]'), ':');
                                                String so = endTime.trim().replaceAll(RegExp(r'[^0-9]'), ':');

                                                String start_time = st.toString(); // or if '24:00'
                                                String end_time = so.toString(); // or if '12:00

                                                var format = DateFormat("HH:mm");
                                                var start = format.parse(start_time);
                                                var end = format.parse(end_time);

                                                if (end.isAfter(start)) {
                                                  timeDiffrence = end.difference(start);
                                                  timeDiffrence = timeDiffrence.toString().substring(0, 7);
                                                }
                                                // print(timeDiffrence);

                                                // pendingWrks();
                                                final isValid = formKey.currentState?.validate();
                                                if (isValid!) {
                                                  createWrkDone();
                                                  pendingWrkStatus = false;
                                                  isSubmit = false;
                                                }

                                                // print('hey I am Working');
                                              });
                                            },
                                          ),
                                        ) : Text('')
                                      ],
                                    );
                                  },
                                ),
                              )
                                  : Text("Start Work"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: height * 0.05),
                          // width: width * 0.8,
                          height: height * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Color(0xffF7F9FC),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(9.0, 9.0),
                                blurRadius: 9,
                              ),
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(-1.0, -8.0),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Work History",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Nexa",
                                      fontSize: height * 0.02,
                                      color: Colors.black87),
                                ),
                              ),
                              const Divider(
                                thickness: 3,
                                indent: 100,
                                endIndent: 100,
                                height: 4,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: height * 0.3,
                                // color: Colors.grey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      nameView.length == 0
                                          ? const Text(
                                        "Enter Your Works",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Nexa",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                          : buildGridView(height, width),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget buildGridView(double height, double width) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 1.3,
        ),
        itemCount: nameView.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            padding: EdgeInsets.only(right: width * 0.03, left: width * 0.03),
            child: Column(
              children: [
                Divider(
                  endIndent: 5,
                  indent: 5,
                  thickness: 2,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    subTitle("[ ${fromView[index]}"),
                    subTitle("To"),
                    subTitle("${toView[index]}]"),
                    subTitle("${workPercentageView[index]}"),
                  ],
                ),
                Divider(
                  endIndent: 5,
                  indent: 5,
                  thickness: 2,
                  color: Colors.black,
                ),
                Text(
                  '${workDoneView[index]}',
                  style: TextStyle(
                      fontFamily: 'Avenir',
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.black),
                ),
                // SizedBox(
                //   height: height * 0.05,
                // )
              ],
            ),
          );
        });
  }

  Text subTitle(String name) => Text(
    name,
    style: const TextStyle(
        fontFamily: 'Avenir',
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: Colors.black),
  );
}


