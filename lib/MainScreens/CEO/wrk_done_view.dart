// import 'dart:ui';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
//
// class ViewWrkDone extends StatefulWidget {
//   const ViewWrkDone({Key? key}) : super(key: key);
//
//   @override
//   State<ViewWrkDone> createState() => _ViewWrkDoneState();
// }
//
// class _ViewWrkDoneState extends State<ViewWrkDone> {
//   final database = FirebaseDatabase.instance.reference().child("staff");
//
//   DateTime now = DateTime.now();
//   var formatterDate = DateFormat('yyyy-MM-dd');
//   String? selectedDate;
//   var fbData;
//
//   bool isLoading = true;
//
//   List name = [];
//   List from = [];
//   List to = [];
//   List workDone = [];
//   List workPercentage = [];
//   List totalTime = [];
//
//   DatePicker() async {
//     selectedDate = formatterDate.format(now);
//     DateTime? newDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2015),
//       lastDate: DateTime(2050),
//     );
//     if (newDate == null) return;
//     setState(() {
//       selectedDate = formatterDate.format(newDate);
//       if (selectedDate != null) {
//         loadData();
//       }
//     });
//   }
//
//   loadData() {
//     name.clear();
//     from.clear();
//     to.clear();
//     workDone.clear();
//     workPercentage.clear();
//
//     database.once().then((value) {
//       for (var element in value.snapshot.children) {
//         for (var element1 in element.children) {
//           for (var element2 in element1.children) {
//             for (var element3 in element2.children) {
//               if (element3.key == selectedDate) {
//                 for (var element4 in element3.children) {
//                   fbData = element4.value;
//                   setState(() {
//                     name.add(fbData['name']);
//                     to.add(fbData['to']);
//                     from.add(fbData['from']);
//                     workDone.add(fbData['workDone']);
//                     workPercentage.add(fbData['workPercentage']);
//                     totalTime.add(fbData["time_in_hours"]);
//                   });
//                 }
//               }
//             }
//           }
//         }
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.black38,
//       body: Stack(
//         children: [
//           Positioned(
//             top: height * 0.01,
//             bottom: height * 0.01,
//             right: width * 0.01,
//             left: width * 0.01,
//             child: Container(
//               decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                 colors: [Colors.black, Colors.black],
//                 end: Alignment.bottomLeft,
//                 begin: Alignment.topRight,
//               )),
//             ),
//           ),
//           Positioned(
//               top: height * 0.01,
//               left: width * 0.0,
//               right: width * 0.0,
//               child: Lottie.asset("assets/84668-background-animation.json")),
//           Positioned(
//               top: height * 0.7,
//               left: width * 0.0,
//               right: width * 0.0,
//               child: Lottie.asset("assets/84669-background-animation.json")),
//           Positioned(
//             top: height * 0.07,
//             left: 1,
//             right: 1,
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: width * 0.25,
//                         ),
//                         Text(
//                           "Works History",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w900,
//                               fontFamily: "Nexa",
//                               fontSize: height * 0.03,
//                               color: const Color(0xffFBF8FF)),
//                         ),
//                         SizedBox(
//                           width: width * 0.06,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               DatePicker();
//                               isLoading = false;
//                             });
//                           },
//                           child: Icon(Icons.calendar_month,
//                               color: Colors.white, size: height * 0.04),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: height * 0.01,
//                   ),
//                   const Divider(
//                     thickness: 3,
//                     indent: 30,
//                     endIndent: 30,
//                     height: 4,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: height * 0.15,
//             left: width * 0.02,
//             right: width * 0.02,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       top: height * 0.01,
//                       left: width * 0.01,
//                       right: width * 0.01,
//                       bottom: height * 0.02),
//                   height: height * 0.80,
//                   width: width * 0.99,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.white10,
//                           offset: Offset(0.0, 0.0),
//                           spreadRadius: 0,
//                           blurRadius: 3),
//                     ],
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         isLoading
//                             ? const Text("Select Date",
//                                 style: TextStyle(
//                                     fontFamily: 'Nexa',
//                                     fontSize: 20,
//                                     color: Color(0xffFBF8FF)))
//                             : buildGridView(height, width)
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   GridView buildGridView(double height, double width) {
//     return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 1,
//             childAspectRatio: 3 / 2,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 50),
//         itemCount: name.length,
//         itemBuilder: (BuildContext ctx, index) {
//           return Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Colors.white12.withOpacity(0.1)),
//                 width: width * 0.5,
//                 height: height * 0.3,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     WrkDetails("Name", "${name[index]}"),
//                     WrkDetails("From", "${from[index]}"),
//                     WrkDetails("To", "${to[index]}"),
//                     WrkDetails("Percent", "${workPercentage[index]}"),
//                     WrkDetails('Total Hours', "${totalTime[index]}")
//                   ],
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     color: Colors.white12.withOpacity(0.1)),
//                 width: width * 0.43,
//                 child: Column(
//                   children: [
//                     Text(
//                       '${workDone[index]}',
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 15,
//                           color: Colors.white),
//                     )
//                   ],
//                 ),
//                 padding: EdgeInsets.symmetric(
//                     vertical: height * 0.03, horizontal: width * 0.02),
//               ),
//             ],
//           );
//         });
//   }
//
//   WrkDetails(String title, String details) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return SizedBox(
//       height: height * 0.05,
//       child: ListTile(
//         title: Text(title,
//             style: const TextStyle(
//                 fontFamily: 'Nexa', fontSize: 13, color: Color(0xffFBF8FF))),
//         trailing: SingleChildScrollView(
//           child: Text(
//             details,
//             style: const TextStyle(
//               fontSize: 13,
//               color: Color(0xffFBF8FF),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/cupertino.dart';
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
  final database = FirebaseDatabase.instance.ref().child("staff");

  DateTime now = DateTime.now();
  var formatterDate = DateFormat('yyyy-MM-dd');
  String? selectedDate;

  var fbData;

  List allData = [];
  List nameData = [];
  List name = [];
  List from = [];
  List to = [];
  List workDone = [];
  List workPercentage = [];
  List totalTime = [];

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

  loadData() {
    name.clear();
    from.clear();
    to.clear();
    workDone.clear();
    workPercentage.clear();

    database.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.value);
        fbData = element.value;
        for (var element1 in element.children) {
          for (var element2 in element1.children) {
            for (var element3 in element2.children) {
              if (element3.key == selectedDate) {
                for (var element4 in element3.children) {
                  // print(element4.value);

                  fbData = element4.value;

                  setState(() {
                    allData.add(fbData);
                    // print("allData......${allData}");
                    nameData.add(fbData['name']);
                    nameData = nameData.toSet().toList();
                    // print('data2 ..................${nameData}');
                    name.add(fbData['name']);
                    to.add(fbData['to']);
                    from.add(fbData['from']);
                    workDone.add(fbData['workDone']);
                    workPercentage.add(fbData['workPercentage']);
                    totalTime.add(fbData["time_in_hours"]);
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
    selectedDate = formatterDate.format(now);
    print(selectedDate);
    loadData();
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
          // Positioned(
          //   top: height * 0.01,
          //   bottom: height * 0.01,
          //   right: width * 0.01,
          //   left: width * 0.01,
          //   child: Container(
          //     decoration: const BoxDecoration(
          //         gradient: LinearGradient(
          //       colors: [Colors.black, Colors.black],
          //       end: Alignment.bottomLeft,
          //       begin: Alignment.topRight,
          //     )),
          //   ),
          // ),
          Positioned(
            top: height * 0.00,
            left: width * 0.0,
            right: width * 0.0,
            child: Lottie.asset("assets/84668-background-animation.json"),
          ),
          // Positioned(
          //   top: height * 0.7,
          //   left: width * 0.0,
          //   right: width * 0.0,
          //   child: Lottie.asset("assets/84669-background-animation.json"),
          // ),
          Positioned(
            top: height * 0.07,
            left: 1,
            right: 1,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
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
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: width * 0.06,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              DatePicker();
                              allData.clear();
                              nameData.clear();
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
                  const Divider(
                    thickness: 3,
                    indent: 30,
                    endIndent: 30,
                    height: 4,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.15,
            left: width * 0.02,
            right: width * 0.02,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: height * 0.01,
                      left: width * 0.01,
                      right: width * 0.01,
                      bottom: height * 0.02),
                  height: height * 0.80,
                  width: width * 0.99,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        nameData.length == 0
                            ? Text("${nameData == 0 ? 'Load Data': 'No Data'}")
                        // const Text("",
                        //         style: TextStyle(
                        //             fontFamily: 'Nexa',
                        //             fontSize: 20,
                        //             color: Colors.black))
                            : buildGridView(height, width)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridView(double height, double width) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 1,
        //   // childAspectRatio: 3 / 1.9,
        //   // crossAxisSpacing: 0,
        //   // mainAxisSpacing: 20,
        // ),
        itemCount: nameData.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(

            margin: EdgeInsets.all(10),
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
                    offset: Offset(-10.0, -10.0),
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(
                vertical: height * 0.005, horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${nameData[index]}",
                  style: const TextStyle(
                    fontFamily: 'Nexa',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Container(
                  // color: Colors.blue,
                  height: height * 0.20,
                  child: SingleChildScrollView(
                    child: nameData.length == 0
                        ? const Text("Select Date",
                            style: TextStyle(
                                fontFamily: 'Nexa',
                                fontSize: 20,
                                color: Colors.black))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allData.length,
                            itemBuilder: (BuildContext context, int ind) {
                              return allData[ind]['name']
                                      .contains(nameData[index])
                                  ? Container(
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
                                              subTitle(
                                                  '[ ${allData[ind]['from']}'),
                                              subTitle("To"),
                                              subTitle(
                                                  ' ${allData[ind]['to']} ]'),
                                              subTitle(
                                                  '${allData[ind]['time_in_hours']} '),
                                              subTitle(
                                                  '${allData[ind]['workPercentage']}'),
                                            ],
                                          ),
                                          Divider(
                                            endIndent: 5,
                                            indent: 5,
                                            thickness: 2,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            '${allData[ind]['workDone']}',
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
                                    )
                                  : Container();
                            },
                          ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
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
