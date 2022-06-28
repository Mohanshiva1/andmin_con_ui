import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final auth = FirebaseAuth.instance;

  bool _showPassword = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {
    await auth
        .signInWithEmailAndPassword(
      email: email.text.trim(),
      password: password.text.trim(),
    )
        .catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Wrong Email or Password"),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
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
        backgroundColor: Color(0xff00a3cc),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: height * 0.13,
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
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                              fontSize: height * 0.05,
                              color: Color(0xffF7F9FC),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(10.0, 10.0),
                                  blurRadius: 8.0,
                                  color: Colors.black45,
                                ),
                              ],
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nexa"),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.09,
                      ),
                      Container(
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
                                  color: Colors.black26,
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
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Center(
                                child: TextFormField(
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Please Enter Email");
                                    }
                                    // if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                    //   return ('Please Enter Valid Email');
                                    // }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    email.text = value!;
                                  },
                                  style: const TextStyle(
                                      color: Color(0xffFBF8FF), fontFamily: ""),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
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
                        width: width * 0.83,
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
                                  color: Colors.black26,
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
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: password,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  obscureText: !_showPassword,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ('Password required');
                                    }
                                  },
                                  onSaved: (value) {
                                    password.text = value!;
                                  },

                                  style: const TextStyle(
                                      color: Color(0xffFBF8FF), fontFamily: ""),
                                  decoration:  InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
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
                                    color: Colors.black26,
                                    offset: Offset(10, 13),
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
        ));
  }

}
