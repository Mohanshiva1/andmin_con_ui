import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Drawer.dart';

class Refreshment extends StatefulWidget {
  const Refreshment({Key? key}) : super(key: key);

  @override
  State<Refreshment> createState() => _RefreshmentState();
}

class _RefreshmentState extends State<Refreshment> {
  final staff = FirebaseDatabase.instance.ref().child("staff");
  final user = FirebaseAuth.instance.currentUser;
  final refreshments =
      FirebaseDatabase.instance.ref().child('refreshments');

  String? NowUser;
  var formattedTime;
  var formattedDate;
  var formattedMonth;
  var formattedYear;
  var timeZone;

  var staffName;
  var fbData;
  List userEmail = [];

  readName() {
    staff.once().then((value) {
      for (var element in value.snapshot.children) {
        // // print(element.value);
        fbData = element.value;
        // setState(() {
        //   userEmail.add(fbData['email']);
        // //   // print(user?.email);
        // });
        if (user?.email == fbData['email']) {
          setState(() {
            fbData.toString();
            staffName = fbData['name'];
            // // print(staffName);
          });
        }
      }
    });
  }

  todayDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyy-MM-dd');
    var formatterYear = DateFormat('yyy');
    var formatterMonth = DateFormat('MM');
    formattedTime = DateFormat('HH:MM:a').format(now);
    formattedDate = formatterDate.format(now);
    formattedYear = formatterYear.format(now);
    formattedMonth = formatterMonth.format(now);

    var s = formattedTime.toString().substring(6, 8);
    // print(s);
    if (s == 'AM') {
      setState(() {
        timeZone = 'FN';
      });

      // // print(timeZone);
    } else {
      setState(() {
        timeZone = 'AN';
      });

      // // print(timeZone);
    }
    // print(timeZone);
    // print(formattedTime);
  }

  var teaCount;
  // var dummyTeaCount;
  var teaList;
  List listOfTea = [];

  loadTea() {
    listOfTea.clear();
    // print(listOfTea);
    refreshments.once().then((value) {
      for (var e1 in value.snapshot.children) {
        // // print(e1.key);
        if (e1.key == formattedDate) {
          for (var e2 in e1.children) {
            // print(timeZone);
            if (timeZone == "FN") {
              // print(timeZone);
              if (e2.key == 'FN') {
                // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'tea') {
                    // print(e3.value);
                    for(var e4 in e3.children){
                      // // print(e4.value);
                      var t = e4.value;
                      // print(t);
                      setState(() {
                        listOfTea.add(t);
                        // print(listOfTea.length);
                        teaList = listOfTea.length;
                        // // print("teaList");
                        // // print("load  ${teaList}");
                      });
                    }

                  }
                }
              }
            } else {
              if (e2.key == 'AN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'tea') {
                    // // print(e3.value);
                    for(var e4 in e3.children){
                      // // print(e4.value);
                      var t = e4.value;
                      // // print(t);
                      setState(() {
                        listOfTea.add(t);
                        // // print(listOfTea.length);
                        teaList = listOfTea.length;
                        // print("teaList");
                        // // print("load  ${teaList}");
                      });
                    }

                  }
                }
              }
            }
          }
        }
      }
    }).then((value){
      setState(() {

        teaList == null
            ? teaList = 1
            : teaList++;

        drinkCountTeaDetails();
      });
    });
  }

  drinkCountTeaDetails() {
    // print(' drink count${teaList}');
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}/tea')
        .update({
      'name${teaList}': staffName.toString().trim(),
    }).then((value) => {
      updateTeaCount(),
      // loadTea(),
      listOfTea.clear()
    });
  }

  updateTeaCount() {
    refreshments.child('${formattedDate.toString().trim()}/${timeZone}').update({
      'tea_count': teaList,
    }).then((value) {
      final snackBar = SnackBar(content: Text("Successfully Submitted Tea"));
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
      Navigator.pop(context);
    });
  }

  var coffeeCount;
  var dummyCoffeeCount;
  var coffeeList;
  List listOfCoffee = [];

  loadCoffee() {
    listOfCoffee.clear();
    // // print(listOfCoffee);
    refreshments.once().then((value) {
      for (var e1 in value.snapshot.children) {
        // // print(e1.key);
        if (e1.key == formattedDate) {
          for (var e2 in e1.children) {
            if (timeZone == "FN") {
              if (e2.key == 'FN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'coffee') {
                    // // print(e3.value);
                    for(var e4 in e3.children){
                      // // print(e4.value);
                      var c = e4.value;
                      // // print(t);
                      setState(() {
                        listOfCoffee.add(c);
                        // // print(listOfTea.length);
                        coffeeList = listOfCoffee.length;
                        // // print("load  ${teaList}");
                      });
                    }

                  }
                }
              }
            } else {
              if (e2.key == 'AN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'coffee') {
                    // // print(e3.value);
                    for(var e4 in e3.children){
                      // // print(e4.value);
                      var t = e4.value;
                      // // print(t);
                      setState(() {
                        listOfCoffee.add(t);
                        // // print(listOfTea.length);
                        coffeeList = listOfCoffee.length;

                        // // print("load  ${teaList}");
                      });
                    }

                  }
                }
              }
            }
          }
        }
      }
    }).then((value) {
      setState(() {
        coffeeList == null
            ? coffeeList = 1
            : coffeeList++;
        drinkCountCoffee();
      });
    });
  }

  drinkCountCoffee() {
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}/coffee')
        .update({
      'name$coffeeList': staffName.toString().trim(),
    }).then((value) => {
      updateCoffeeCount(),
      listOfCoffee.clear()
    });
  }

  updateCoffeeCount() {
    refreshments.child('${formattedDate.toString().trim()}/${timeZone}').update({
      'coffee_count': coffeeList,
    }).then((value) {
      final snackBar = SnackBar(content: Text("Successfully Submitted Coffee"));
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
      Navigator.pop(context);
    });
  }

  var nothingCount;
  var dummyNothingCount;
  var nothingList;
  List listOfNothing = [];

  loadNothing() {
    listOfNothing.clear();
    // print(listOfNothing);
    refreshments.once().then((value) {
      for (var e1 in value.snapshot.children) {
        // // print(e1.key);
        if (e1.key == formattedDate) {
          for (var e2 in e1.children) {
            if (timeZone == "FN") {
              if (e2.key == 'FN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'nothing') {
                    // // print(e3.value);
                    for(var e4 in e3.children){
                      // // print(e4.value);
                      var t = e4.value;
                      // // print(t);
                      setState(() {
                        listOfNothing.add(t);
                        // // print(listOfTea.length);
                        nothingList = listOfNothing.length;
                      });
                    }

                  }
                }
              }
            } else {
              if (e2.key == 'AN') {
                // // print(e2.value);
                for (var e3 in e2.children) {
                  if (e3.key == 'nothing') {
                    // // print(e3.value);
                    for(var e4 in e3.children){
                      // // print(e4.value);
                      var n = e4.value;
                      // // print(t);
                      setState(() {
                        listOfNothing.add(n);
                        nothingList = listOfNothing.length;

                      });
                    }

                  }
                }
              }
            }
          }
        }
      }
    }).then((value) {
      setState(() {
        nothingList == null
            ? nothingList = 1
            : nothingList++;
        // // print("${nothingList}////////////////////////");
        drinkCountNothing();
      });
    });
  }

  drinkCountNothing() {
    refreshments
        .child('${formattedDate.toString().trim()}/${timeZone}/nothing')
        .update({
      'name$nothingList': staffName.toString().trim(),
    }).then((value) => {
      updateNothingCount(),

      listOfNothing.clear()
    });
  }

  updateNothingCount() {
    refreshments.child('${formattedDate.toString().trim()}/${timeZone}').update({
      'nothing_count': nothingList,
    }).then((value) {
      final snackBar = SnackBar(content: Text("Successfully Submitted "));
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showSnackBar(snackBar);
      Navigator.pop(context);
    });
  }


  @override
  void initState() {
    todayDate();
    readName();
    NowUser = user?.email;

    // loadCoffee();
    // loadTea();
    // loadNothing();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
        child: Drawer(
          child: NavigationDrawer(),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                // color: Colors.orange.shade400,
                gradient: LinearGradient(
                  colors: [
                    Color(0xff1A2980),
                    Color(0xff26D0CE),
                    // Color(0xff21409D),
                    // Color(0xff050851),
                  ],
                  // stops: [
                  //   0.0,
                  //   11.0,
                  // ],
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  // tileMode: TileMode.repeated,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: height * 0.05,
                    right: width * 0.0,
                    // left: width*0.3,
                    child: Image.asset(
                      'assets/business-team-doing-creative-brainstorming.png',
                      scale: 13.0,
                    ),
                  ),
                  Positioned(
                    top: height*0.03,
                    left: width*0.0,
                    // right: 30,
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          _scaffoldKey.currentState?.openDrawer();
                        });
                      },
                      iconSize: height * 0.04,
                      icon: Icon(Icons.menu),
                    ),
                  ),
                  Positioned(
                    top: height * 0.18,
                    // right: 0,
                    left: width * 0.04,
                    child: Center(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Choose your drink...',
                              style: TextStyle(
                                  fontSize: height * 0.03,
                                  color: Color(0xffffffff).withOpacity(1.0),
                                  fontFamily: "Nexa",
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.25,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffF7F9FC),
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(
                    'assets/outdoor.png',
                  ),
                  fit: BoxFit.scaleDown,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {

                              loadTea();
                              // // print(".....................${teaList.runtimeType}");
                              // teaList == null
                              //     ? teaList = 1
                              //     : teaList++;
                              // // print("${teaList}////////////////////////");
                              // drinkCountTeaDetails();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(40),
                            height: height * 0.15,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(-10, 10),
                                    blurRadius: 15,
                                    spreadRadius: 9),
                                BoxShadow(
                                  color: Colors.white12,
                                  offset: Offset(4, 4),
                                  blurRadius: 10,
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff26D0CE),
                                    Color(0xff1A2980),
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,
                                  tileMode: TileMode.repeated),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.coffee),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  'Tea',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Nexa',
                                    fontSize: height * 0.02,
                                    color: Color(0xffF7F9FC),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              loadCoffee();
                              // // print(".....................${coffeeList.runtimeType}");
                              // coffeeList == null
                              //     ? coffeeList = 1
                              //     : coffeeList++;
                              // // // print("${coffeeList}////////////////////////");
                              // drinkCountCoffee();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(40),
                            height: height * 0.15,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(-10, 10),
                                    blurRadius: 15,
                                    spreadRadius: 9),
                                BoxShadow(
                                  color: Colors.white12,
                                  offset: Offset(4, 4),
                                  blurRadius: 10,
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff26D0CE),
                                    Color(0xff1A2980),
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,
                                  tileMode: TileMode.repeated),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.coffee),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  'Coffee',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Avenir',
                                    fontSize: height * 0.02,
                                    color: Color(0xffF7F9FC),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              loadNothing();
                              // // print(".....................${nothingList.runtimeType}");
                              // nothingList == null
                              //     ? nothingList = 1
                              //     : nothingList++;
                              // // // print("${nothingList}////////////////////////");
                              // drinkCountNothing();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(40),
                            height: height * 0.15,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(-10, 10),
                                    blurRadius: 15,
                                    spreadRadius: 9),
                                BoxShadow(
                                  color: Colors.white12,
                                  offset: Offset(4, 4),
                                  blurRadius: 10,
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff26D0CE),
                                    Color(0xff1A2980),
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,
                                  tileMode: TileMode.repeated),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.no_drinks),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  'Nothing',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Avenir',
                                    fontSize: height * 0.02,
                                    color: Color(0xffF7F9FC),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
