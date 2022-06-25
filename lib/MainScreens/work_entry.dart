import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool isloading = false;

  Timer? _timer;

  TextEditingController fromfield = TextEditingController();
  TextEditingController tofield = TextEditingController();
  TextEditingController wrkdonefield = TextEditingController();
  TextEditingController percentfield = TextEditingController();

  final formKey = GlobalKey<FormState>();

  //....view Works.............................
  String? CurrerntUser;
  var fbData;
  var totalTime;
  List nameView = [];
  List fromView = [];
  List toView = [];
  List workDoneView = [];
  List workPercentageView = [];

  @override
  void initState() {
    todayDate();
    setState(() {
      CurrerntUser = user?.email;
      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
        loadData();
      });
    });

    super.initState();
  }

  // var cutomData;

  loadData() {
    nameView.clear();
    fromView.clear();
    toView.clear();
    workDoneView.clear();
    workPercentageView.clear();
    _auth.once().then((value) => {
      for (var element in value.snapshot.children)
        {
          fbData = element.value,
          if (fbData["email"] == CurrerntUser)
            {
              for (var element1 in element.children)
                {
                  for (var element2 in element1.children)
                    {
                      for (var element3 in element2.children)
                        {
                          if (element3.key == "$formattedDate")
                            {
                              print(element3.key),
                              for (var element4 in element3.children)
                                {
                                  // print(element4.value),
                                  fbData = element4.value,
                                  setState(() {
                                    nameView.add(fbData['name']);
                                    toView.add(fbData['to']);
                                    fromView.add(fbData['from']);
                                    workDoneView.add(fbData['workDone']);
                                    workPercentageView.add(fbData['workPercentage']);

                                  }),
                                },
                            }
                        },
                    },
                },
            }
        }
    });
  }

  //..........Create Work don.........................
  String? from;
  String? to;

  var formattedDate;
  var wrkdone;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyy-MM-dd');
    // String formattedTime = DateFormat('kk:mm:a').format(now);
    formattedDate = formatter.format(now);
  }

  CreateWrkDone() {
    _auth.once().then((value) => {
      for (var element in value.snapshot.children)
        {
          fbData = element.value,
          if (fbData["email"] == user?.email)
            {
              wrkdone = element.key,
              _auth
                  .child(wrkdone)
                  .child(
                  "workManager/timeSheet/$formattedDate/'${fromfield.text.trim()} to ${tofield.text.trim()}'/")
                  .set({
                "from": from,
                "to": to,
                "workDone": wrkdonefield.text.trim(),
                "workPercentage": '${percentfield.text.trim()}%',
                'name': fbData['name'],
                'time_in_hours': totalTime.toString().trim()
              }),
            }
        }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                top: height * 0.67,
                left: width * 0.0,
                right: width * 0.0,
                child:
                Lottie.asset("assets/84669-background-animation.json"),
            ),
            Positioned(
              top: height * 0.08,
              right: width * 0.03,
              left: width * 0.03,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                height: height * 0.85,
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
                            margin: const EdgeInsets.only(top: 1),
                            width: width * 0.3,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
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
                                  offset: Offset(-10.0, -10.0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nexa"),
                                    controller: fromfield,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Nexa', fontSize: 15),
                                      contentPadding:
                                      const EdgeInsets.all(20),
                                      hintText: '    From',
                                      filled: true,
                                      fillColor: const Color(0xffFBF8FF),
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
                                    readOnly: true,
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                      await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );

                                      if (pickedTime != null) {
                                        DateTime parsedTime =
                                        DateFormat.jm().parse(pickedTime
                                            .format(context)
                                            .toString());
                                        String formattedTime =
                                        DateFormat('HH:mm a')
                                            .format(parsedTime);

                                        setState(() {
                                          fromfield.text = formattedTime;
                                        });
                                      }
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 1),
                            width: width * 0.3,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
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
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nexa"),
                                    controller: tofield,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Nexa', fontSize: 15),
                                      contentPadding:
                                      const EdgeInsets.all(20),
                                      hintText: '       To',
                                      filled: true,
                                      fillColor: const Color(0xffFBF8FF),
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
                                    readOnly: true,
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                      await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );

                                      if (pickedTime != null) {
                                        DateTime parsedTime =
                                        DateFormat.jm().parse(pickedTime
                                            .format(context)
                                            .toString());
                                        String formattedTime =
                                        DateFormat('HH:mm a')
                                            .format(parsedTime);

                                        setState(() {
                                          tofield.text = formattedTime;
                                        });
                                      }
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 1),
                            width: width * 0.3,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xffF7F9FC),
                              // Colors.white.withOpacity(0.3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(9.0, 9.0),
                                  blurRadius: 9,
                                ),
                                BoxShadow(
                                  color: Colors.white70,
                                  offset: Offset(-0.0, -1.0),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontFamily: "Nexa"),
                                  controller: percentfield,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Nexa', fontSize: 15),
                                    contentPadding:
                                    const EdgeInsets.all(20),
                                    hintText: '   Percent',
                                    filled: true,
                                    fillColor: const Color(0xffFBF8FF),
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
                              ],
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

                          borderRadius: BorderRadius.circular(40),
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
                              offset: Offset(-10.0, -10.0),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Nexa"),
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
                                '                           Enter your Work',
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
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
                          ],
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
                            isloading = false;

                            from = fromfield.text
                                .trim()
                                .replaceAll(RegExp(r'[^0-9^:]'), ' ');
                            to = tofield.text
                                .trim()
                                .replaceAll(RegExp(r'[^0-9^:]'), ' ');

                            String st = fromfield.text
                                .trim()
                                .replaceAll(RegExp(r'[^0-9]'), ':');
                            String so = tofield.text
                                .trim()
                                .replaceAll(RegExp(r'[^0-9]'), ':');

                            String start_time =
                            st.toString(); // or if '24:00'
                            String end_time = so.toString(); // or if '12:00

                            var format = DateFormat("HH:mm");
                            var start = format.parse(start_time);
                            var end = format.parse(end_time);

                            if (end.isAfter(start)) {
                              totalTime = end.difference(start);
                              totalTime =
                                  totalTime.toString().substring(0, 4);
                            }

                            final isValid =
                            formKey.currentState?.validate();
                            if (isValid!) {
                              CreateWrkDone();
                              _timer = Timer.periodic(Duration(seconds: 1),
                                      (timer) {
                                    fromfield.clear();
                                    tofield.clear();
                                    wrkdonefield.clear();
                                    percentfield.clear();
                                    print(".........................clear");
                                    _timer?.cancel();
                                  });
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
                        padding: EdgeInsets.only(
                          top: height * 0.03,
                        ),
                        margin: EdgeInsets.only(top: height * 0.05),
                        // width: width * 0.8,
                        height: height * 0.4,
                        decoration: BoxDecoration(


                          borderRadius: BorderRadius.circular(40),
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
                              offset: Offset(-10.0, -10.0),
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
                                "Works History",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Nexa",
                                    fontSize: height * 0.02,
                                    color:  Colors.black87),
                              ),
                            ),

                            const Divider(
                              thickness: 3,
                              indent: 150,
                              endIndent: 150,
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
                                          color: Colors.white,
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
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            ),
        itemCount: nameView.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            padding: EdgeInsets.only(
                right: width * 0.03,
                left: width * 0.03),
            child: Column(
              children: [
                Divider(
                  endIndent: 5,
                  indent: 5,
                  thickness: 2,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
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
                SizedBox(
                  height: height * 0.05,
                )
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
