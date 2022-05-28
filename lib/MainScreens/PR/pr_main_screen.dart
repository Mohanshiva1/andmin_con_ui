import 'dart:ui';

import 'package:andmin_con_ui/MainScreens/PR/create_leed.dart';
import 'package:andmin_con_ui/MainScreens/PR/view_leed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../wrk_done.dart';

class PRScreen extends StatefulWidget {
  const PRScreen({Key? key}) : super(key: key);

  @override
  State<PRScreen> createState() => _PRScreenState();
}

class _PRScreenState extends State<PRScreen> {
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
            top: height * 0.15,
            left: 1,
            right: 1,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Choose Your Destination",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: "Nexa",
                          fontSize: height * 0.03,
                          color: Color(0xffFBF8FF)),
                    ),
                  ),
                  Divider(
                    thickness: 3,
                    indent: 30,
                    endIndent: 30,
                    height: 4,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.25,
            bottom: height * 0.30,
            left: width * 0.05,
            right: width * 0.05,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GridView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  children: [
                    Container(
                      child: Buttons(
                          "New Leads",
                          CreateLeeds(),
                          Icon(
                            Icons.create_rounded,
                            size: height * 0.05,
                            color: Colors.amber,
                          )),
                    ),
                    Container(
                      child: Buttons(
                          "View Leads",
                          ViewLeeds(),
                          Icon(
                            Icons.view_day,
                            size: height * 0.05,
                            color: Colors.amber,
                          )),
                    ),
                    Container(
                      child: Buttons(
                          "Work Manager",
                          WRkDONE(),
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
        height: height * 0.15,
        width: width * 0.4,
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
          //     boxShadow: [
          //   BoxShadow(
          //   blurRadius: 5.0,
          //   offset: Offset(8, 8),
          //   color: Colors.black12,
          //
          // ),
          //   BoxShadow(
          //       blurRadius: 5.0,
          //       offset: Offset(8, 9),
          //       color: Color(0xff1a1a1a)
          //     // Color(0xffA7A9AF),
          //     // inset: isPressed,
          //     // inset: true,
          //   ),
          //   ]
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
                style: TextStyle(
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
