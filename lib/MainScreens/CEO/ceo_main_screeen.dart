import 'dart:ui';

import 'package:andmin_con_ui/MainScreens/CEO/management.dart';
import 'package:andmin_con_ui/MainScreens/CEO/wrk_done_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../PR/view_leed.dart';
import '../login_screen.dart';

class CEOScreen extends StatefulWidget {
  const CEOScreen({Key? key}) : super(key: key);

  @override
  State<CEOScreen> createState() => _CEOScreenState();
}

class _CEOScreenState extends State<CEOScreen> {
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
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.black, Colors.black],
                end: Alignment.bottomLeft,
                begin: Alignment.topRight,
              )),
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
                    child: Row(
                      children: [
                        Text(
                          "Choose your Destination",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Nexa",
                              fontSize: height * 0.03,
                              color: const Color(0xffFBF8FF)),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
                                  (Route<dynamic> route) => true);
                            });
                          },
                          icon: Icon(Icons.logout),
                          iconSize: 35,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  const Divider(
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
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                  ),
                  children: [
                    Container(
                      child: buttons(
                          "Management",
                          const CeoManagement(),
                          Icon(
                            Icons.manage_accounts_outlined,
                            size: height * 0.05,
                            color: Colors.amber,
                          )),
                    ),
                    Container(
                      child: buttons(
                          "View Leads",
                          const ViewLeeds(),
                          Icon(
                            Icons.view_day,
                            size: height * 0.05,
                            color: Colors.amber,
                          )),
                    ),
                    Container(
                      child: buttons(
                          "View Works",
                          const ViewWrkDone(),
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

  GestureDetector buttons(String name, Widget pageName, Icon icon) {
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
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
