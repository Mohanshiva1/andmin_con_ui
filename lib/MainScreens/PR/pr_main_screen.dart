import 'dart:ui';

import 'package:andmin_con_ui/MainScreens/PR/create_leed.dart';
import 'package:andmin_con_ui/MainScreens/PR/view_leed.dart';
import 'package:andmin_con_ui/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


import '../work_entry.dart';
import '../wrk_done.dart';

class PRScreen extends StatefulWidget {
  const PRScreen({Key? key}) : super(key: key);

  @override
  State<PRScreen> createState() => _PRScreenState();
}

class _PRScreenState extends State<PRScreen> {
  final _auth = FirebaseDatabase.instance.reference().child("staff");
  final user = FirebaseAuth.instance.currentUser;

  String? CurrerntUser;
  var fbData;
  var userName;

  loadData() {
    _auth.once().then((value) => {
      for (var element in value.snapshot.children)
        {
          fbData = element.value,
          if (fbData["email"] == CurrerntUser)
            {
              // print(fbData),
              setState(() {
                userName = fbData['name'];
                print(userName);
              }),
            }
        }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    CurrerntUser = user?.email;
    super.initState();
    loadData();
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
              top: height * 0.0,
              left: width * 0.0,
              right: width * 0.0,
              child: Lottie.asset("assets/84668-background-animation.json")),
          Positioned(
              top: height * 0.7,
              left: width * 0.0,
              right: width * 0.0,
              child: Lottie.asset("assets/84669-background-animation.json")),
          Positioned(
            top: height * 0.15,
            left: 1,
            right: 1,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Choose your Destination",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: "Nexa",
                          fontSize: height * 0.025,
                          color: Colors.black),
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                    indent: 30,
                    endIndent: 30,
                    height: 4,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Center(
                    child: Text(
                      "Welcome Back ${userName.toString().trim()}",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Nexa',
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.017),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: height * 0.03,
              left: width * 0.9,
              right: width * 0.0,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) =>  const MainPage()));

                  });
                },
                icon: Icon(Icons.logout,color: Colors.white,),
                iconSize: 25,
              )),
          Positioned(
            top: height * 0.25,
            bottom: height * 0.0,
            left: width * 0.05,
            right: width * 0.05,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    
                      ),
                  children: [
                    Container(
                      child: Buttons(
                          "New Leads",
                          const CreateLeeds(),
                          Icon(
                            Icons.create_rounded,
                            size: height * 0.05,
                            color: Colors.amber,
                          )),
                    ),
                    Container(
                      child: Buttons(
                          "View Leads",
                          const ViewLeeds(),
                          Icon(
                            Icons.view_day,
                            size: height * 0.05,
                            color: Colors.amber,
                          )),
                    ),
                    Container(
                      child: Buttons(
                          "Work Manager",
                          WorkEntry(),
                          Icon(
                            Icons.work_outline_rounded,
                            size: height * 0.05,
                            color: Colors.amber,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector Buttons(String name, Widget pageName, Icon icon) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => pageName));
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(20),
        height: height * 0.15,
        width: width * 0.4,

        duration:  Duration(milliseconds: 100),
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
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nexa',
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
