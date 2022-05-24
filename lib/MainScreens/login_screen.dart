import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    await auth.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    );
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: height * 0.01,
            bottom: height * 0.01,
            right: width * 0.01,
            left: width * 0.01,
            child: Container(
              height: height * 1.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //   colors: [Color(0xff00004d), Color(0xff00004d),],
                  //   end: Alignment.bottomLeft,
                  //   begin: Alignment.topRight,
                  // )
                  ),
              child: Lottie.asset(
                "assets/93539-background.json",
                fit: BoxFit.fill,
              ),
            ),
            //
          ),
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
                      "LogIn",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: "Nexa",
                          fontSize: height * 0.03,
                          color: Color(0xffFBF8FF)),
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
                    height: height * 0.04,
                  ),
                  Container(
                    height: height * 0.45,
                    width: width * 0.8,
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.07, horizontal: width * 0.04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(8, 9),
                          blurRadius: 20,
                          spreadRadius: 7,
                        )
                      ],
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Color(0xffFBF8FF), fontFamily: ""),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue.shade100),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "E-mail",
                            prefixIcon: Icon(
                              Icons.mail_rounded,
                              size: height * 0.03,
                              color: Color(0xffFBF8FF),
                            ),
                            hintStyle: TextStyle(
                                color: Color(0xffFBF8FF),
                                fontFamily: 'Nexa',
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        TextField(
                          controller: password,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                              color: Color(0xffFBF8FF), fontFamily: ""),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              size: height * 0.03,
                              color: Color(0xffFBF8FF),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.blue.shade100),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color(0xffFBF8FF),
                                fontFamily: 'Nexa',
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              login();
                            });
                          },
                          child: Container(
                            width: width * 0.4,
                            height: height * 0.05,
                            decoration: BoxDecoration(
                                color: Color(0xffFBF8FF),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(9, 10),
                                    blurRadius: 20,
                                    spreadRadius: 1,
                                  )
                                ]),
                            child: Center(
                              child: Text(
                                "LogIn",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Nexa",
                                    fontSize: height * 0.02,
                                    color: Colors.black.withOpacity(0.2)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
