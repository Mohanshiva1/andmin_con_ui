import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CreateLeeds extends StatefulWidget {
  const CreateLeeds({Key? key}) : super(key: key);

  @override
  State<CreateLeeds> createState() => _CreateLeedsState();
}

class _CreateLeedsState extends State<CreateLeeds> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController loc = TextEditingController();
  TextEditingController enq = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController databy = TextEditingController();
  TextEditingController fetch = TextEditingController();
  TextEditingController rating = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Stack(
        children: [
          Positioned(
            top: height * 0.20,
            // bottom: height * 0.01,
            right: width * 0.01,
            left: width * 0.01,
            child: Lottie.asset(
              "assets/104390-to-do-list.json",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: height * 0.7,
              left: width * 0.0,
              right: width * 0.0,
              child: Lottie.asset("assets/84669-background-animation.json")),
          Positioned(
            top: height * 0.1,
            left: width * 0.03,
            right: width * 0.03,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 300, sigmaY: 300),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.03, horizontal: width * 0.01),
                width: width * 0.3,
                height: height * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white12,
                      boxShadow: [
                    BoxShadow(
                        color: Colors.white12,
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 0)),
                  ]
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Create Data",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Nexa', fontSize: 35, color: Color(0xffFBF8FF)),
                      ),
                      dividers(),
                      buildListView("Name", name),
                      buildListView("Phone", phone),
                      buildListView("Location", loc),
                      buildListView("Enquiry", enq),
                      buildListView("Email", email),
                      buildListView("Data By", databy),
                      buildListView("Data Fetched By", fetch),
                      buildListView("Rating", rating),
                      SizedBox(
                        height: height * 0.02,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: height * 0.85,
              left: width * 0.20,
              right: width * 0.20,
              child: GestureDetector(
                child: Container(
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      color: Color(0xffFBF8FF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(8,8),
                          blurRadius: 30,
                          spreadRadius: 5
                        )
                      ],
                      borderRadius: BorderRadius.circular(30)),

                  child: const Center(
                    child: Text("Submit",style: TextStyle(
                        color: Colors.black, fontFamily: "Nexa", fontSize: 18,fontWeight: FontWeight.w800)),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget buildListView(String name, TextEditingController) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        SizedBox(
          height: height * 0.05,
          child: ListTile(
              trailing: SizedBox(
                width: width * 0.5,
                child: TextField(
                  controller: TextEditingController,
                  style:
                      TextStyle(color: Color(0xffFBF8FF), fontFamily: "Nexa"),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(width: 1,color: Colors.teal.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // hintText: hint,
                    hintStyle: TextStyle(
                        color: Color(0xffFBF8FF),
                        fontFamily: 'Nexa',
                        fontSize: 13),
                  ),
                ),
              ),
              leading: Text(
                name,
                style: TextStyle(
                    color: Color(0xffFBF8FF), fontFamily: "Nexa", fontSize: 15),
              )),
        ),
      ],
    );
  }

  Divider dividers() {
    return Divider(
      height: 1,
      color: Color(0xffFBF8FF),
      indent: 30,
      endIndent: 30,
      thickness: 1,
    );
  }
}
