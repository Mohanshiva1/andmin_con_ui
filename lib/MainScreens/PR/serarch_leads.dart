import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'notes_add.dart';

class SearchLeads extends StatefulWidget {
  const SearchLeads({Key? key}) : super(key: key);

  @override
  State<SearchLeads> createState() => _SearchLeadsState();
}

class _SearchLeadsState extends State<SearchLeads> {
  final _auth = FirebaseDatabase.instance.reference().child("customer");
  final user = FirebaseAuth.instance.currentUser;

  final formKey = GlobalKey<FormState>();
  TextEditingController numberField = TextEditingController();

  bool isPressed = false;

  List name = [];
  List phoneNumber = [];
  List location = [];
  List email = [];
  List rating = [];
  List createdDate = [];
  List enquiry = [];
  List status = [];
  List fetched = [];
  var fbData;

  viewLeads() {
    name.clear();
    phoneNumber.clear();
    location.clear();
    email.clear();
    rating.clear();
    createdDate.clear();
    enquiry.clear();
    status.clear();
    fetched.clear();

    _auth.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.key);
        if (element.key == numberField.text) {
          // print(element.value);
          fbData = element.value;
          // print(fbData);
          setState(() {
            phoneNumber.add(fbData['phone_number']);
            name.add(fbData['name']);
            location.add(fbData['city']);
            status.add(fbData['customer_state']);
            createdDate.add(fbData['created_date']);
            rating.add(fbData['rating']);
            enquiry.add(fbData['inquired_for']);
            email.add(fbData['email_id']);
            fetched.add(fbData['data_fetched_by']);
            print(phoneNumber);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Offset distance = isPressed ? Offset(5, 5) : Offset(10, 10);
    double blur = isPressed ? 5.0 : 25;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Positioned(
                top: height * 0.0,
                left: width * 0.0,
                right: width * 0.0,
                child: Lottie.asset("assets/84668-background-animation.json")),
            Positioned(
                top: height * 0.75,
                left: width * 0.0,
                right: width * 0.0,
                child: Lottie.asset("assets/84669-background-animation.json")),
            Positioned(
              top: height * 0.1,
              left: width * 0.0,
              right: width * 0.0,
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'Search Lead Information',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: "Nexa",
                          fontSize: height * 0.025,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 1),
                        width: width * 0.5,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffF7F9FC),
                          // Colors.white.withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(28, 28),
                              blurRadius: 30,
                            ),
                          ],
                        ),
                        child: Center(
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: const TextStyle(
                                color: Colors.black, fontFamily: "Nexa"),
                            controller: numberField,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  fontFamily: 'Nexa', fontSize: 15),
                              contentPadding: const EdgeInsets.all(20),
                              hintText: 'Entre Number',
                              filled: true,
                              fillColor: const Color(0xffFBF8FF),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Enter The Number';
                              } else if (value?.length != 10) {
                                return "Enter The Correct Number";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            final isValid = formKey.currentState?.validate();
                            if (isValid!) {
                              viewLeads();
                            }
                            isPressed = !isPressed;
                          });
                        },
                        child: Listener(
                          onPointerUp: (_) => setState(() {
                            isPressed = true;
                          }),
                          onPointerDown: (_) => setState(() {
                            isPressed = true;
                          }),
                          child: AnimatedContainer(
                            margin: const EdgeInsets.only(top: 1),
                            width: width * 0.2,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffF7F9FC),
                              // Colors.white.withOpacity(0.3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: distance,
                                  blurRadius: blur,
                                  inset: isPressed,
                                ),
                                BoxShadow(
                                  color: Colors.white12,
                                  offset: -distance,
                                  blurRadius: blur,
                                  inset: isPressed,
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 100),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Icon(Icons.search_rounded,size: height*0.02,color: Colors.blueGrey,),
                                  Text(
                                    'Search',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Nexa",
                                        fontSize: height * 0.013,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Divider(
                    endIndent: width * 0.1,
                    indent: width * 0.1,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Column(
                    children: [
                      phoneNumber.length == 0
                          ? Text(
                        "Enter Number",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Nexa',
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.015),
                      )
                          : buildGridView(width, height),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(double width, double height) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: phoneNumber.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddNotes(txt: numberField.text)));
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              decoration: BoxDecoration(
                  color: Color(0xffF7F9FC),
                  // status[index] == "Following Up"
                  //     ? Colors.green
                  //     : status[index] == "Delayed"
                  //         ? Colors.orange
                  //         : status[index] == "Rejected from management side"
                  //             ? Colors.red
                  //             : status[index] == "Rejected from Customer end"
                  //                 ? Colors.red
                  //                 : Color(0xffF7F9FC),
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
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  leadDetails("Name", "${name[index]}", Colors.black),
                  leadDetails("Phone", "${phoneNumber[index]}", Colors.black),
                  leadDetails("Location", "${location[index]}", Colors.black),
                  leadDetails("Enquiry", "${enquiry[index]}", Colors.black),
                  leadDetails("Email", "${email[index]}", Colors.black),
                  leadDetails("createdDate", "${createdDate[index]}", Colors.black),
                  leadDetails("Data Fetched From", "${[index]}", Colors.black),
                  leadDetails('Status', '${status[index]}',
                    status[index] == "Following Up"
                        ? Colors.green
                        : status[index] == "Delayed"
                        ? Colors.orange.shade800
                        : status[index] == "Rejected from management side"
                        ? Colors.red
                        : status[index] ==
                        "Rejected from Customer end"
                        ? Colors.red
                        : Color(0xffF7F9FC),
                  ),
                  leadDetails("Rating", "${rating[index]}", Colors.black),
                ],
              ),
            ),
          );
        });
  }

  leadDetails(String title, String address, color) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.04,
      child: ListTile(
        title: Text(title,
            style:  TextStyle(
                fontFamily: 'Avenir',
                fontSize: height*0.013,
                color: Colors.black,
                fontWeight: FontWeight.w800)),
        trailing: SizedBox(
          // width: 180,
          // height: 80,
          child: SingleChildScrollView(
            child: Text(address,
                style: TextStyle(
                    fontFamily: 'Avenir', fontSize: height*0.013, color: color,fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
