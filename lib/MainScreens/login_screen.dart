import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xff34455B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: height * 0.15,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.09,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Container(
                      width: width * 0.81,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff7AF3FC),
                              Color(0xff3865FA),
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xff233045),
                                offset: Offset(20, 21),
                                blurRadius: 9,
                                spreadRadius: 1)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          const Icon(Icons.account_circle),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Container(
                            height: height * 0.06,
                            width: width * 0.70,
                            padding: EdgeInsets.only(left: width * 0.02),
                            decoration: const BoxDecoration(
                                color: Color(0xff202B3E),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Center(
                              child: TextField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                    color: Color(0xffFBF8FF), fontFamily: ""),
                                decoration: const InputDecoration.collapsed(
                                  hintText: "   Email",
                                  hintStyle: TextStyle(
                                      color: Color(0xffFBF8FF),
                                      fontFamily: 'Nexa',
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //////Password...........................
                    Container(
                      margin: EdgeInsets.only(
                        top: height * 0.05,
                      ),
                      width: width * 0.82,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff7AF3FC),
                              Color(0xff3865FA),
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xff233045),
                                offset: Offset(20, 21),
                                blurRadius: 9,
                                spreadRadius: 1)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          const Icon(Icons.password),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Container(
                            height: height * 0.06,
                            width: width * 0.70,
                            padding: EdgeInsets.only(left: width * 0.02),
                            decoration: const BoxDecoration(
                              color: Color(0xff202B3E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: TextField(
                                controller: password,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                style: const TextStyle(
                                    color: Color(0xffFBF8FF), fontFamily: ""),
                                decoration: const InputDecoration.collapsed(
                                  hintText: "   Password",
                                  hintStyle: TextStyle(
                                      color: Color(0xffFBF8FF),
                                      fontFamily: 'Nexa',
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          login();
                        });
                      },
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.3,
                        margin: EdgeInsets.only(
                            top: height * 0.05,
                            left: width * 0.20,
                            right: width * 0.20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xff7AF3FC),
                                Color(0xff3865FA),
                              ],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xff233045),
                                  offset: Offset(15, 16),
                                  blurRadius: 9,
                                  spreadRadius: 1)
                            ]),
                        child: Center(
                          child: Text(
                            "LogIn",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: "Nexa",
                                fontSize: height * 0.02,
                                color: const Color(0xffFBF8FF)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
