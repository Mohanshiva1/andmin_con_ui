import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AbsentAndPresent extends StatefulWidget {
  const AbsentAndPresent({Key? key}) : super(key: key);

  @override
  State<AbsentAndPresent> createState() => _AbsentAndPresentState();
}

class _AbsentAndPresentState extends State<AbsentAndPresent> {
  final database = FirebaseDatabase.instance.ref().child("staff");

  DateTime now = DateTime.now();
  var formatterDate = DateFormat('yyyy-MM-dd');
  String? selectedDate;

  var fbData;
  List notEntry = [];

  List allData = [];
  List nameData = [];

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
    });
  }

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

  loadData() {
    database.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.value);
        fbData = element.value;

        setState(() {
          notEntry.add(fbData['name']);
          notEntry = notEntry.toSet().toList();
          if (fbData['department'] == "ADMIN") {
            setState(() {
              notEntry.remove(fbData['name']);
            });
          }
          // print(notEntry);
        });
        for (var element1 in element.children) {
          if (element1.key == "workManager") {
            for (var element2 in element1.children) {
              // print(element2.key);
              for (var element3 in element2.children) {
                if (element3.key == formattedYear) {
                  for (var element4 in element3.children) {
                    if (element4.key == formattedMonth) {
                      for (var element5 in element4.children) {
                        if (element5.key == selectedDate) {
                          for (var element6 in element5.children) {
                            fbData = element6.value;
                            // print(fbData);

                            if (fbData['name'] != notEntry) {
                              setState(() {
                                notEntry.remove(fbData['name']);
                                print("..................${notEntry}..............................");
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
    });
  }

  // loadData() {
  //   database.once().then((value) {
  //     for (var element in value.snapshot.children) {
  //       // print(element.value);
  //       fbData = element.value;
  //
  //       setState(() {
  //         notEntry.add(fbData['name']);
  //         // notEntry = notEntry.toSet().toList();
  //         if (fbData['department'] == "admin") {
  //           setState(() {
  //             notEntry.remove(fbData['name']);
  //           });
  //         }
  //         // print(notEntry);
  //       });
  //       for (var element1 in element.children) {
  //         for (var element2 in element1.children) {
  //           for (var element3 in element2.children) {
  //             if (element3.key == selectedDate) {
  //               for (var element4 in element3.children) {
  //                 // print(element4.value);
  //                 fbData = element4.value;
  //                 if (fbData['name'] != notEntry) {
  //                   setState(() {
  //                     notEntry.remove(fbData['name']);
  //                     // print(
  //                     //     "..................${notEntry}..............................");
  //                   });
  //                 }
  //                 setState(() {
  //                   allData.add(fbData);
  //                   // print("allData......${allData}");
  //                   nameData.add(fbData['name']);
  //                   nameData = nameData.toSet().toList();
  //                   // print('data2 ..................${nameData}');
  //                 });
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    selectedDate = formatterDate.format(now);
    print(selectedDate);
    loadData();
    todayDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F9FC),
      body: Stack(
        children: [
          Positioned(
            top: height * 0.0,
            left: width * 0.0,
            right: width * 0.0,
            child: Lottie.asset("assets/84668-background-animation.json"),
          ),
          Positioned(
            top: height * 0.75,
            left: width * 0.0,
            right: width * 0.0,
            child: Lottie.asset("assets/84669-background-animation.json"),
          ),
          Positioned(
            top: height * 0.05,
            left: 1,
            right: 1,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: height * 0.05,
                      left: width * 0.04,
                      right: width * 0.04),
                  height: height * 0.07,
                  decoration: BoxDecoration(
                    color: Color(0xffF7F9FC),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        offset: Offset(9.0, 9.0),
                        blurRadius: 9,
                      ),
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(-10.0, -10.0),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Staff Absents Details ",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: "Avenir",
                          fontSize: height * 0.018,
                        ),
                      ),
                      // SizedBox(
                      //   width: width * 0.06,
                      // ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                        indent: 15,
                        endIndent: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            DatePicker();
                            notEntry.clear();
                          });
                        },
                        child: Icon(Icons.calendar_month,
                            color: Colors.orange, size: height * 0.04),
                      ),
                    ],
                  ),
                ),
             Text('$selectedDate',style: TextStyle(
                fontFamily: 'Nexa',
                fontSize: 15,
                color: Colors.black)),


                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(
                      top: height * 0.05,
                      left: width * 0.04,
                      right: width * 0.04),
                  height: height * 0.5,
                  width: width * 09,
                  decoration: BoxDecoration(
                      color: Color(0xffF7F9FC),
                      borderRadius: BorderRadius.circular(30),
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
                      ]),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        notEntry.length == 0
                            ? Text(
                            "${notEntry.length == 0 ? 'No Data' : 'Load Data'}")
                        // const Text("Select Date to View Details",
                        //         style: TextStyle(
                        //             fontFamily: 'Nexa',
                        //             fontSize: 20,
                        //             color: Colors.black))
                            : ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: notEntry.length,
                          itemBuilder: (BuildContext context, int ind) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xffF7F9FC),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(9),
                              // height: height*0.0,
                              width: width * 0.9,
                              child: Column(
                                children: [
                                  notEntry != 0
                                      ? Text("${notEntry[ind]}",
                                      style: TextStyle(
                                          fontFamily: 'Nexa',
                                          fontSize: 18,
                                          color: Colors.black))
                                      : Text("No Absents in This Date")
                                ],
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        //  Column(
        //   children: [
        //     Container(
        //       margin: EdgeInsets.only(
        //           top: height * 0.05, left: width * 0.04, right: width * 0.04),
        //       height: height * 0.07,
        //       decoration: BoxDecoration(
        //           color: Color(0xffF7F9FC),
        //           borderRadius: BorderRadius.circular(30),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.white.withOpacity(0.2),
        //               offset: Offset(9.0, 9.0),
        //               blurRadius: 9,
        //             ),
        //             BoxShadow(
        //               color: Colors.black26,
        //               offset: Offset(-10.0, -10.0),
        //               blurRadius: 10,
        //             ),
        //           ],
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             "Staff Absents Details ",
        //             style: TextStyle(
        //               fontWeight: FontWeight.w900,
        //               fontFamily: "Avenir",
        //               fontSize: height * 0.018,
        //             ),
        //           ),
        //           // SizedBox(
        //           //   width: width * 0.06,
        //           // ),
        //           VerticalDivider(
        //             color: Colors.black,
        //             thickness: 2,
        //             indent: 15,
        //             endIndent: 15,
        //           ),
        //           GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 DatePicker();
        //                 notEntry.clear();
        //               });
        //             },
        //             child: Icon(Icons.calendar_month,
        //                 color: Colors.orange, size: height * 0.04),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.all(20),
        //       margin: EdgeInsets.only(
        //           top: height * 0.05, left: width * 0.04, right: width * 0.04),
        //       height: height * 0.5,
        //       width: width * 09,
        //       decoration: BoxDecoration(
        //           color:Color(0xffF7F9FC),
        //           borderRadius: BorderRadius.circular(30),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black26,
        //               offset: Offset(9.0, 9.0),
        //               blurRadius: 9,
        //             ),
        //             BoxShadow(
        //               color: Colors.white,
        //               offset: Offset(-10.0, -10.0),
        //               blurRadius: 10,
        //             ),
        //           ]),
        //       child: SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             notEntry.length == 0
        //                 ? Text("${notEntry.length == 0 ? 'No Data': 'Load Data'}")
        //             // const Text("Select Date to View Details",
        //             //         style: TextStyle(
        //             //             fontFamily: 'Nexa',
        //             //             fontSize: 20,
        //             //             color: Colors.black))
        //                 : ListView.builder(
        //                     scrollDirection: Axis.vertical,
        //                     physics: NeverScrollableScrollPhysics(),
        //                     shrinkWrap: true,
        //                     itemCount: notEntry.length,
        //                     itemBuilder: (BuildContext context, int ind) {
        //                       return Container(
        //                         decoration: BoxDecoration(
        //                           color: Color(0xffF7F9FC),
        //                           borderRadius: BorderRadius.circular(20),
        //                         ),
        //                         margin: EdgeInsets.all(5),
        //                         padding: EdgeInsets.all(9),
        //                         // height: height*0.0,
        //                         width: width * 0.9,
        //                         child: Column(
        //                           children: [
        //                           notEntry != 0 ?Text("${notEntry[ind]}",
        //                                 style: TextStyle(
        //                                     fontFamily: 'Nexa',
        //                                     fontSize: 18,
        //                                     color: Colors.black)):Text("No Absents in This Date")
        //                           ],
        //                           crossAxisAlignment: CrossAxisAlignment.center,
        //                         ),
        //                       );
        //                     },
        //                   ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
