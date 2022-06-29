import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class CreateLeeds extends StatefulWidget {
  const CreateLeeds({Key? key}) : super(key: key);

  @override
  State<CreateLeeds> createState() => _CreateLeedsState();
}

class _CreateLeedsState extends State<CreateLeeds> {
  final _auth = FirebaseDatabase.instance.reference().child("cust");
  final user = FirebaseAuth.instance.currentUser;

  String? userEmail;


  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController loc = TextEditingController();
  TextEditingController enq = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fetch = TextEditingController();
  TextEditingController rating = TextEditingController();

  String? formattedTime;
  var formattedDate;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyy-MM-dd');

    setState(() {
      formattedTime = DateFormat('kk:mm:a').format(now);
      formattedDate = formatter.format(now);
    });
    print(formattedDate);
    print(formattedTime);
  }

  var fbData;

  createLeads() {
    _auth.once().then((value) => {
          setState(() {
            _auth.child("${phone.text.trim()}").set({
              'city': loc.text.trim(),
              'created_by': userEmail.toString().trim(),
              'created_date': formattedDate,
              'created_time': formattedTime,
              'customer_state': 'following up',
              'data_fetched_by': fetch.text.trim(),
              'inquired_for': enq.text.trim(),
              'name': name.text.trim(),
              'phone_number': phone.text.trim(),
              'rating': '0',
            }).then((value) {
              name.clear();
              phone.clear();
              loc.clear();
              enq.clear();
              email.clear();
              fetch.clear();
            });
          }),
        });
  }

  @override
  void initState() {
    setState(() {
      todayDate();
      userEmail = user?.email;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F9FC),
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Positioned(
              top: height * 0.0,
              left: width * 0.0,
              right: width * 0.0,
              child: Container(
                child: Lottie.asset("assets/84668-background-animation.json"),
              ),
            ),
            Positioned(
                top: height * 0.75,
                left: width * 0.0,
                right: width * 0.0,
                child: Lottie.asset("assets/84669-background-animation.json")),
            Positioned(
              top: height * 0.1,
              left: width * 0.03,
              right: width * 0.03,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.03, horizontal: width * 0.01),
                width: width * 0.3,
                height: height * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xffF7F9FC),
                  // Colors.white.withOpacity(0.3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(9.0, 9.0),
                      blurRadius: 10,
                    ),
                    // BoxShadow(
                    //   color: Colors.white,
                    //   offset: Offset(-1.0, -0.0),
                    //   blurRadius: 10,
                    // ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "Create Lead",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Nexa',
                            fontSize: 35,
                            color: Colors.black),
                      ),
                      dividers(),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            buildListView("Name", name, TextInputType.name,
                                'Enter the name'),
                            buildListView("Phone", phone, TextInputType.number,
                                'Enter the Phone Number'),
                            buildListView("Location", loc, TextInputType.name,
                                'Enter the Location'),
                            buildListView("Enquiry For", enq,
                                TextInputType.name, 'Enter the name'),
                            buildListView("Email", email,
                                TextInputType.emailAddress, 'Enter the Email'),
                            buildListView("Data Fetched By", fetch,
                                TextInputType.name, 'Enter Data Fetched By'),
                            SizedBox(
                              height: height * 0.09,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  final isValid =
                                      formKey.currentState?.validate();
                                  if (isValid!) {
                                    createLeads();
                                  }
                                  // print(formattedTime);
                                  // print(formattedDate);
                                });
                              },
                              child: Container(
                                height: height * 0.05,
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.3),
                                decoration: BoxDecoration(
                                    color: Color(0xffF7F9FC),
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
                                child: const Center(
                                  child: Text("Submit",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nexa",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800)),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListView(String name, TextEditingController,
      TextInputType textInputType, String val) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        SizedBox(
          height: height * 0.05,
          child: ListTile(
              trailing: SizedBox(
                width: width * 0.5,
                child: TextFormField(
                  controller: TextEditingController,
                  keyboardType: textInputType,
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return val;
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(color: Colors.black, fontFamily: "Avenir"),
                  decoration: InputDecoration(
                    hintText: name,
                    helperStyle: TextStyle(color: Colors.black12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black54),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // hintText: hint,
                    hintStyle: const TextStyle(
                        color: Colors.black26,
                        fontFamily: 'Nexa',
                        fontSize: 13),
                  ),
                ),
              ),
              leading: Text(
                name,
                style: const TextStyle(
                    color: Colors.black, fontFamily: "Nexa", fontSize: 15),
              )),
        ),
      ],
    );
  }

  Divider dividers() {
    return const Divider(
      height: 1,
      color: Colors.black,
      indent: 30,
      endIndent: 30,
      thickness: 1,
    );
  }
}
