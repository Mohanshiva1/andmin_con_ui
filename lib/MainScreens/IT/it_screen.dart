import 'dart:ui';

import 'package:andmin_con_ui/MainScreens/IT/task.dart';
import 'package:andmin_con_ui/MainScreens/wrk_done.dart';
import 'package:andmin_con_ui/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ITScreen extends StatefulWidget {
  const ITScreen({Key? key}) : super(key: key);

  @override
  State<ITScreen> createState() => _ITScreenState();
}

class _ITScreenState extends State<ITScreen> {
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
                  setState(() {
                    userName = fbData['name'];
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
                    child: Text(
                      "Choose your Destination",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: "Nexa",
                          fontSize: height * 0.025,
                          color: const Color(0xffFBF8FF)),
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                    indent: 30,
                    endIndent: 30,
                    height: 4,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    width: width*0.75,
                    child: Center(
                      child: Text(
                        "Welcome ${userName.toString().trim()} Update your Daily Works",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nexa',
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.017),
                      ),
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()));
                  });
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                iconSize: 25,
              )),
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
                      mainAxisSpacing: 20),
                  children: [
                    Container(
                      child: Buttons(
                          "New Task",
                          const TaskScreen(),
                          Icon(
                            Icons.add_task_sharp,
                            size: height * 0.05,
                            color: Colors.amber,
                          )),
                    ),
                    Container(
                      child: Buttons(
                          "Work Manager",
                          const WRkDONE(),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
