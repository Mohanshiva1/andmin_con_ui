import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WorkEntry extends StatefulWidget {
  const WorkEntry({Key? key}) : super(key: key);

  @override
  State<WorkEntry> createState() => _WorkEntryState();
}

class _WorkEntryState extends State<WorkEntry> {
  final _auth = FirebaseDatabase.instance.reference().child("staff");
  final user = FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();

  Timer? _timer;

  TextEditingController fromfield = TextEditingController();
  TextEditingController tofield = TextEditingController();
  TextEditingController wrkdonefield = TextEditingController();
  TextEditingController percentfield = TextEditingController();

  var upLoadTime1;
  var upLoadTime2;
  String? formattedTime;
  var formattedDate;
  var formattedMonth;
  var formattedYear;

  todayDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyy-MM-dd');
    var formatterYear = DateFormat('yyy');
    var formatterMonth = DateFormat('MM');
    formattedTime = DateFormat('kk:mm:a').format(now);
    formattedDate = formatterDate.format(now);
    formattedYear = formatterYear.format(now);
    formattedMonth = formatterMonth.format(now);
  }

  //....view Works.............................
  String? CurrerntUser;
  var fbData;
  var fbdata1;
  var totalTime;
  List nameView = [];
  List fromView = [];
  List toView = [];
  List workDoneView = [];
  List workPercentageView = [];
  List ttlWrk = [];
  List dayTotalWrk = [];

  //............View Firebase Data.............................

  viewData() {

    nameView.clear();
    toView.clear();
    fromfield.clear();
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
                              if(fbdata1['to'] != null){
                                nameView.remove(fbdata1['to']);
                                setState(() {
                                  fromView.add(fbdata1['from']);
                                  toView.add(fbdata1['to']);
                                  workPercentageView.add(fbdata1['workPercentage']);
                                  workDoneView.add(fbdata1['workDone']);
                                  ttlWrk.add(fbdata1['from']);
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




  String? from;
  String? to;
  var wrkDone;

  createWrkDone() {

    _auth.once().then((value) =>
    {
      for (var element in value.snapshot.children)
        {
          fbData = element.value,
          if (fbData["email"] == user?.email)
            {
              wrkDone = element.key,
              _auth
                  .child(wrkDone)
                  .child(
                  "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/'${upLoadTime1.toString().trim()} to ${upLoadTime2.toString().trim()}'")
                  .set({
                "from": from,
                "to": to,
                "workDone": wrkdonefield.text.trim(),
                "workPercentage": '${percentfield.text.trim()}%',
                'name': fbData['name'],
                'time_in_hours': totalTime.toString().trim()
              }).then((value) {
                fromfield.clear();
                tofield.clear();
                wrkdonefield.clear();
                percentfield.clear();
                viewData();
                // dayWrkTime();
              }),
            }
        }
    });
  }




  // dayWrkTime() {
  //
  //   // _auth.once().then((value) =>
  //   // {
  //   //   for (var element in value.snapshot.children)
  //   //     {
  //   //       fbData = element.value,
  //   //       if (fbData["email"] == user?.email)
  //   //         {
  //   //           wrkDone = element.key,
  //   //           _auth
  //   //               .child(wrkDone)
  //   //               .child(
  //   //               "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/totalWorkingTime")
  //   //               .set({'day': 'time'})
  //   //         }
  //   //     }
  //   // });
  // }

  // Get Current Location........................................
  String location = 'Get';
  String lat = '';
  String long = '';

  var latVal;
  var logVal;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placeMark =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placeMark[0];
    lat = "${position.latitude.toDouble()}";
    long = " ${position.longitude.toDouble()}";
    // setState(() {
    latVal = double.parse(lat);
    logVal = double.parse(long);
    // });
  }

  getLocation() async {
    Position position = await _determinePosition();
    // print(position.latitude);
    // print(position.longitude);
    getAddressFromLatLong(position);
    location = 'Lat: ${position.latitude}   long: ${position.longitude}';
  }

  createLocation() {
    _auth.once().then((value) =>
    {
      for (var element in value.snapshot.children)
        {
          fbData = element.value,
          // print(fbData),
          // print(
          //   User?.email,
          // ),
          // print(Email["email"] == User?.email),
          // print(CurrerntUser),
          if (fbData["email"] == CurrerntUser)
            {
              wrkDone = element.key,
              _auth
                  .child(wrkDone)
                  .child(
                  "Location_history/${formattedDate.toString()
                      .trim()}/Loc : ${formattedTime.toString().trim()}/")
                  .set({
                'Lat': latVal,
                "Log": logVal,
              }),
            }
        }
    });
  }

  @override
  void initState() {
    todayDate();
    getLocation();
    _determinePosition();
    createLocation();
    viewData();
    setState(() {
      CurrerntUser = user?.email;
      Timer.periodic(const Duration(minutes: 15), (timer) {
        todayDate();
        getLocation();
        _determinePosition();
        createLocation();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    // TODO: implement dispose
    getLocation();
    _determinePosition();

    super.dispose();
  }

  bool button = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Color(0xffF7F9FC),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width * 0.3,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF7F9FC),
                              // Colors.white.withOpacity(0.3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(9.0, 9.0),
                                  blurRadius: 9,
                                ),
                              ],
                            ),
                            child: Center(
                              child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.black, fontFamily: "Nexa"),
                                  controller: fromfield,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Nexa', fontSize: 13),
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: '    From',
                                    filled: true,
                                    fillColor: const Color(0xffFBF8FF),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value
                                        .toString()
                                        .isEmpty) {
                                      return 'Enter value';
                                    } else {
                                      return null;
                                    }
                                  },
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                    await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      DateTime parsedTime = DateFormat.jm()
                                          .parse(pickedTime
                                          .format(context)
                                          .toString());
                                      String formattedTime = DateFormat('h:m a')
                                          .format(parsedTime);

                                      //DateFormat('HH:mm a // a for AM PM').format(parsedTime);

                                      String formattedUploadTime = DateFormat('HH:mm')
                                          .format(parsedTime);

                                      setState(() {
                                        fromfield.text = formattedTime;
                                        upLoadTime1 = formattedUploadTime;

                                      });
                                    }
                                  }),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 1),
                            width: width * 0.3,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF7F9FC),
                              // Colors.white.withOpacity(0.3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(9.0, 9.0),
                                  blurRadius: 9,
                                ),
                              ],
                            ),
                            child: Center(
                              child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.black, fontFamily: "Nexa"),
                                  controller: tofield,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Nexa', fontSize: 15),
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: '       To',
                                    filled: true,
                                    fillColor: const Color(0xffFBF8FF),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value
                                        .toString()
                                        .isEmpty) {
                                      return 'Enter value';
                                    } else {
                                      return null;
                                    }
                                  },
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                    await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      DateTime parsedTime = DateFormat.jm()
                                          .parse(pickedTime
                                          .format(context)
                                          .toString());
                                      String formattedTime = DateFormat('h:m a')
                                          .format(parsedTime);
                                      String formattedUploadTime = DateFormat('HH:mm')
                                          .format(parsedTime);

                                      setState(() {
                                        tofield.text = formattedTime;
                                        upLoadTime2 = formattedUploadTime;

                                      });
                                    }
                                  }),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 1),
                            width: width * 0.3,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffF7F9FC),
                              // Colors.white.withOpacity(0.3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(9.0, 9.0),
                                  blurRadius: 9,
                                ),
                              ],
                            ),
                            child: Center(
                              child: TextFormField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                style: const TextStyle(
                                    color: Colors.black, fontFamily: "Nexa"),
                                controller: percentfield,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                      fontFamily: 'Nexa', fontSize: 15),
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText: '   Percent',
                                  filled: true,
                                  fillColor: const Color(0xffFBF8FF),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
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
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.black,
                        indent: 30,
                        endIndent: 30,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 1),
                        height: height * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
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
                                color: Colors.black, fontFamily: "Nexa"),
                            controller: wrkdonefield,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              fillColor: Color(0xffFBF8FF),
                              hintStyle: const TextStyle(
                                  fontFamily: 'Nexa',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  color: Colors.black54
                                // (0xffFBF8FF)
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              hintText:
                              '                                  Enter your Work',
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
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
                        height: height * 0.02,
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.black,
                        indent: 30,
                        endIndent: 30,
                        thickness: 2,
                      ),

                      SizedBox(
                        height: height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            // from to upload value
                            from = fromfield.text
                                .trim()
                                .replaceAll(RegExp(r'[^0-9^:]'), ' ');
                            to = tofield.text
                                .trim()
                                .replaceAll(RegExp(r'[^0-9^:]'), ' ');
                            //................//

                            String st = upLoadTime1
                                .trim()
                                .replaceAll(RegExp(r'[^0-9]'), ':');
                            String so = upLoadTime2
                                .trim()
                                .replaceAll(RegExp(r'[^0-9]'), ':');

                            String start_time = st.toString(); // or if '24:00'
                            String end_time = so.toString(); // or if '12:00

                            var format = DateFormat("HH:mm");
                            var start = format.parse(start_time);
                            var end = format.parse(end_time);

                            if (end.isAfter(start)) {
                              totalTime = end.difference(start);
                              totalTime = totalTime.toString().substring(0, 4);
                            }

                            final isValid = formKey.currentState?.validate();
                            if (isValid!) {
                              createWrkDone();
                            }
                          });
                        },
                        child: Container(
                          height: height * 0.05,
                          width: width * 0.3,
                          decoration: BoxDecoration(
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
                                  offset: Offset(-10.0, -1.0),
                                  blurRadius: 10,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                            child: Text("Submit",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Nexa",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                          ),
                        ),
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
        ),
      ),
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

  Text subTitle(String name) =>
      Text(
        name,
        style: const TextStyle(
            fontFamily: 'Avenir',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.black),
      );
}






// int dtt = 0;
// int dtt2 = 0;
// int dtm = 0;
// int dtm2 = 0;
// dayWrkTime() {
//
//   List t1 = ttlWrk;
//   print(t1);
//   for(var time in t1){
//
//     var format = time;
//
//     var hours = format.substring(0,2);
//     var minutes  = format.substring(3,5);
//     var tt = DateFormat("HH:mm");
//     var startime = tt.parse(format);
//
//     dtt = int.parse(hours);
//     var timeValue = dtt2 + dtt;
//     print(timeValue);
//     dtt2 = timeValue;
//
//     var ttttt = dtt2 * 60;
//
//     dtm = int.parse(minutes);
//     var mintVAlue = dtm2 + dtm;
//     dtm2 = mintVAlue;
//     startime.add(Duration(hours: int.parse(hours),minutes: int.parse(minutes)));
//
//     var fin = ttttt + dtm2;
//     print(fin);
//     String durationToString(int minutes) {
//       var d = Duration(minutes:minutes);
//       List<String> parts = d.toString().split(':');
//       return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
//     }
//     // print(durationToString(fin));
//     setState(() {
//       dayWrkTiming = durationToString(fin);
//       print(dayWrkTiming);
//
//     });
//
//   }
//   _auth.once().then((value) =>
//   {
//     for (var element in value.snapshot.children)
//       {
//         fbData = element.value,
//         if (fbData["email"] == user?.email)
//           {
//             wrkDone = element.key,
//             _auth
//                 .child(wrkDone)
//                 .child(
//                 "workManager/timeSheet/$formattedYear/$formattedMonth/$formattedDate/totalWorkingTime")
//                 .set({'day': dayWrkTiming.toString().trim()})
//           }
//       }
//   });
// }