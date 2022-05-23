import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WRkDONE extends StatefulWidget {
  const WRkDONE({Key? key}) : super(key: key);

  @override
  State<WRkDONE> createState() => _WRkDONEState();
}

class _WRkDONEState extends State<WRkDONE> {
  final _auth = FirebaseDatabase.instance.reference().child("Staff");
  final user = FirebaseAuth.instance.currentUser;


  var fbData;

  List name = [];
  List from = [];
  List to = [];
  List workDone = [];
  List workPercentage = [];

  var formattedDate;


  TextEditingController fromfield = TextEditingController();
  TextEditingController tofield = TextEditingController();
  TextEditingController wrkdonefield = TextEditingController();
  TextEditingController percentfield = TextEditingController();


  loadData() {
    print(".........................");
    name.clear();
    from.clear();
    to.clear();
    workDone.clear();
    workPercentage.clear();

    _auth.once().then((value) {
      for (var element in value.snapshot.children) {
        print(element.key);
        for (var element1 in element.children) {
          for (var element2 in element1.children) {
            for (var element3 in element2.children) {
              // print(element3.key);
              // if (element3.key == selectedDate) {
              //   // print(element3.key);
              //   for (var element4 in element3.children) {
              //     // print(element4.key);
              //     fbData = element4.value;
              //     // print(fbData);
              //     setState(() {
              //       name.add(fbData['name']);
              //       to.add(fbData['To']);
              //       from.add(fbData['From']);
              //       workDone.add(fbData['WrkDone']);
              //       workPercentage.add(fbData['Percentage']);
              //       print(name);
              //       print(from);
              //       print(to);
              //
              //     });
              //   }
              // }
            }
          }
        }
      }
    });
  }

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyy-MM-dd');
    // String formattedTime = DateFormat('kk:mm:a').format(now);
    formattedDate = formatter.format(now);
    // print(formattedTime);
    // print(formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Stack(
        children: [
          Positioned(
            top: height * 0.01,
            bottom: height * 0.01,
            right: width * 0.01,
            left: width * 0.01,
            child: Lottie.asset(
              "assets/96479-student-girl-academy.json",
            ),
          ),
          Positioned(
              top: height * 0.01,
              left: width * 0.0,
              right: width * 0.0,
              child: Lottie.asset("assets/84668-background-animation.json")),
          Positioned(
              top: height * 0.7,
              left: width * 0.0,
              right: width * 0.0,
              child: Lottie.asset("assets/84669-background-animation.json")),
          Positioned(
            top: height * 0.05,
            right: width * 0.03,
            left: width * 0.03,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: height * 0.8,
              decoration: BoxDecoration(
                  // color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30)),
              child: SingleChildScrollView(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 1),
                            width: width * 0.3,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(5.9, -5.9),
                                    spreadRadius: 1,
                                    blurRadius: 10)
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nexa"),
                                    controller: fromfield,
                                    textInputAction: TextInputAction.next,
                                    // keyboardType: TextInputType.n,
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          fontFamily: 'Nexa', fontSize: 15),
                                      contentPadding: const EdgeInsets.all(20),
                                      hintText: '    From',
                                      filled: true,
                                      fillColor: const Color(0xffFBF8FF),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );

                                      if (pickedTime != null) {
                                        // print(pickedTime.format(context)); //output 10:51 PM
                                        DateTime parsedTime = DateFormat.jm()
                                            .parse(pickedTime
                                                .format(context)
                                                .toString());
                                        //converting to DateTime so that we can further format on different pattern.
                                        // print(parsedTime); //output 1970-01-01 22:53:00.000
                                        String formattedTime =
                                            DateFormat('HH:mm a')
                                                .format(parsedTime);
                                        // print(formattedTime); //output 14:59:00
                                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                                        setState(() {
                                          fromfield.text =
                                              formattedTime; //set the value of text field.
                                        });
                                      } else {
                                        print("Time is not selected");
                                      }
                                    }),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: width * 0.1,
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 1),
                            width: width * 0.3,
                            height: height * 0.08,
                            // margin: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(5.9, -5.9),
                                    spreadRadius: 1,
                                    blurRadius: 10),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Nexa"),
                                    controller: tofield,
                                    textInputAction: TextInputAction.next,
                                    // keyboardType: TextInputType.n,
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
                                    readOnly: true,
                                    onTap: () async {
                                      await datePicker();}
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 1),
                            width: width * 0.3,
                            height: height * 0.08,
                            // margin: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(5.9, -5.9),
                                    spreadRadius: 1,
                                    blurRadius: 10),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: "Nexa"),
                                  controller: percentfield,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontFamily: 'Nexa', fontSize: 15),
                                    contentPadding: EdgeInsets.all(20),
                                    hintText: '   Percent',
                                    filled: true,
                                    fillColor: Color(0xffFBF8FF),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Divider(
                        height: 1,
                        color: Color(0xffFBF8FF),
                        indent: 30,
                        endIndent: 30,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1),
                        // width: width * 0.8,
                        height: height * 0.3,
                        // margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          // Color(0xffFBF8FF),

                          borderRadius: BorderRadius.circular(40),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2.0, 4.0),
                                spreadRadius: 3,
                                blurRadius: 9),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              style: TextStyle(
                                  color: Color(0xffFBF8FF), fontFamily: "Nexa"),
                              controller: wrkdonefield,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontFamily: 'Nexa',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: Color(0xffFBF8FF)
                                    // (0xffFBF8FF)
                                    ),
                                contentPadding: const EdgeInsets.all(20),
                                hintText:
                                    '                           Enter your Work',
                                filled: true,
                                // fillColor: Colors.white24,
                                // Color(0xffFBF8FF),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Divider(
                        height: 1,
                        color: Color(0xffFBF8FF),
                        indent: 30,
                        endIndent: 30,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                          height: height * 0.05,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                              color: Color(0xffFBF8FF),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(8, 8),
                                    blurRadius: 30,
                                    spreadRadius: 5)
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                top: height * 0.03,
              ),
              margin: EdgeInsets.only(top: height * 0.6),
              // width: width * 0.8,
              height: height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white12,
                // Color(0xffFBF8FF),

                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2.0, 4.0),
                      spreadRadius: 3,
                      blurRadius: 9),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                   child:

                        Text(
                          "Works History",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Nexa",
                              fontSize: height * 0.02,
                              color: Color(0xffFBF8FF)),
                        ),


                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Divider(
                    thickness: 3,
                    indent: 30,
                    endIndent: 30,
                    height: 4,
                    color: Colors.white,
                  ),
                ],
              ),
              ))
        ],
      ),
    );
  }

  Widget datePicker(){
    return GestureDetector(onTap: ()async{
      TimeOfDay? pickedTime =
          await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );

      if (pickedTime != null) {
        print(pickedTime
            .format(context)); //output 10:51 PM
        DateTime parsedTime = DateFormat.jm()
            .parse(pickedTime
            .format(context)
            .toString());
        //converting to DateTime so that we can further format on different pattern.
        // print(parsedTime); //output 1970-01-01 22:53:00.000
        String formattedTime =
        DateFormat('HH:mm a')
            .format(parsedTime);
        // print(formattedTime); //output 14:59:00
        //DateFormat() is from intl package, you can format the time on any pattern you need.

        setState(() {
          tofield.text =
              formattedTime; //set the value of text field.
        });
      } else {
        print("Time is not selected");
      }
    },);
  }

  Text titleName(String name) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Text(
      name,
      style: TextStyle(fontSize: height * 0.02),
    );
  }

  WrkDetails(String title, String address) {
    return SizedBox(
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                fontFamily: 'Nexa', fontSize: 18, color: Color(0xffFBF8FF))),
        trailing: SizedBox(
          // width: 180,
          // height: 80,
          child: SingleChildScrollView(
            child: Text(address,
                style: TextStyle(
                    fontFamily: 'Nexa',
                    fontSize: 18,
                    color: Color(0xffFBF8FF))),
          ),
        ),
      ),
    );
  }
}
