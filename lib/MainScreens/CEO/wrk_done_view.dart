import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ViewWrkDone extends StatefulWidget {
  const ViewWrkDone({Key? key}) : super(key: key);

  @override
  State<ViewWrkDone> createState() => _ViewWrkDoneState();
}

class _ViewWrkDoneState extends State<ViewWrkDone> {
  final database = FirebaseDatabase.instance.reference().child("Staff");

  DateTime now = DateTime.now();
  var formatterDate = DateFormat('yyyy-MM-dd');
  String? selectedDate;
  var fbData;

  List name = [];
  List from = [];
  List to = [];
  List workDone = [];
  List workPercentage = [];

  DatePicker() async {
    selectedDate = formatterDate.format(now);
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (newDate == null) return;
    setState(() {
      selectedDate = formatterDate.format(newDate);
      if (selectedDate != null) {
        loadData();
      }
      print(selectedDate);
    });
  }



  loadData() {
    print(".........................");
    name.clear();
    from.clear();
    to.clear();
    workDone.clear();
    workPercentage.clear();

    database.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.key);
        for (var element1 in element.children) {
          for (var element2 in element1.children) {
            for (var element3 in element2.children) {
              // print(element3.key);
              if (element3.key == selectedDate) {
                // print(element3.key);
                for (var element4 in element3.children) {
                  // print(element4.key);
                  fbData = element4.value;
                  // print(fbData);
                  setState(() {
                    name.add(fbData['name']);
                    to.add(fbData['To']);
                    from.add(fbData['From']);
                    workDone.add(fbData['WrkDone']);
                    workPercentage.add(fbData['Percentage']);
                    print(name);
                    print(from);
                    print(to);

                  });
                }
              }
            }
          }
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // loadData();
    // print(formatterDate);
    super.initState();
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
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.black, Colors.black],
                end: Alignment.bottomLeft,
                begin: Alignment.topRight,
              )),
              child: Lottie.asset(
                "assets/88132-management-1.json",
                fit: BoxFit.scaleDown,
              ),
            ),
            //
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
            top: height * 0.07,
            left: 1,
            right: 1,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.25,
                        ),
                        Text(
                          "Works History",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Nexa",
                              fontSize: height * 0.03,
                              color: Color(0xffFBF8FF)),
                        ),
                        SizedBox(
                          width: width * 0.06,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              DatePicker();
                            });
                          },
                          child: Icon(Icons.calendar_month,
                              color: Colors.white, size: height * 0.04),
                        )
                      ],
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
            ),
          ),
          Positioned(
            top: height * 0.15,
            // bottom: height * 0.30,
            left: width * 0.02,
            right: width * 0.02,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: height * 0.01,
                    left: width * 0.01,
                    right: width * 0.01,
                  ),
                  height: height * 0.80,
                  width: width * 0.99,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white10,
                          offset: Offset(0.0, 0.0),
                          spreadRadius: 0,
                          blurRadius: 3),
                    ],
                  ),
                  child: Column(
                    children: [
                      selectedDate != null
                          ? buildGridView(height, width)
                          : Text("Select Date",
                              style: TextStyle(
                                  fontFamily: 'Nexa',
                                  fontSize: 20,
                                  color: Color(0xffFBF8FF)))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  GridView buildGridView(double height, double width) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: 1,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            height: height * 0.04,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  width: width * 0.5,
                  height: height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WrkDetails("Name", "${name[index]}"),
                      WrkDetails("From", "${from[index]}"),
                      WrkDetails("To", "${to[index]}"),
                      WrkDetails("Percent", "${workPercentage[index]}"),
                    ],
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  color: Color(0xffFBF8FF),
                  indent: 25,
                  endIndent: 25,
                  thickness: 3,
                ),
                Container(
                  decoration: BoxDecoration(
// color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  width: width * 0.43,
                  child: Column(
                    children: [
                      Text(
                        '${workDone[index]}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: "nexa",
                            color: Colors.white),
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.03, horizontal: width * 0.02),
                ),
              ],
            ),
          );
        });
  }

  WrkDetails(String title, String details) {
    return SizedBox(
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                fontFamily: 'Nexa', fontSize: 13, color: Color(0xffFBF8FF))),
        trailing: Container(
          decoration: BoxDecoration(
              // color: Colors.black
              ),
          child: SingleChildScrollView(
            child: Text(details,
                style: TextStyle(
                    fontFamily: 'Nexa',
                    fontSize: 13,
                    color: Color(0xffFBF8FF))),
          ),
        ),
      ),
    );
  }
}
