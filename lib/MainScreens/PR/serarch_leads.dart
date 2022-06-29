import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';


class SearchLeads extends StatefulWidget {
  const SearchLeads({Key? key}) : super(key: key);

  @override
  State<SearchLeads> createState() => _SearchLeadsState();
}

class _SearchLeadsState extends State<SearchLeads> {
  final _auth = FirebaseDatabase.instance.reference().child("cust");
  final user = FirebaseAuth.instance.currentUser;

  final formKey = GlobalKey<FormState>();
  TextEditingController numberField = TextEditingController();

  bool isPressed = true;

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
                              final isValid =
                              formKey.currentState?.validate();
                              if (isValid!) {
                                viewLeads();
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 1),
                            width: width * 0.2,
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
                ))
          ],
        ),
      ),
    );
  }

  Widget buildGridView(double width, double height) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: phoneNumber.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
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
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                leadDetails("Name", "${name[index]}"),
                leadDetails("Phone", "${phoneNumber[index]}"),
                leadDetails("Location", "${location[index]}"),
                leadDetails("Enquiry", "${enquiry[index]}"),
                leadDetails("Email", "${email[index]}"),
                leadDetails("createdDate", "${createdDate[index]}"),
                leadDetails("inquired_for", "${enquiry[index]}"),
                leadDetails("Data Fetched From", "${fetched[index]}"),
                leadDetails('Status', '${status[index]}'),
                leadDetails("Rating", "${rating[index]}"),
              ],
            ),
          );
        });
  }

  leadDetails(String title, String address) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.04,
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                fontFamily: 'Avenir',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
        trailing: SizedBox(
          // width: 180,
          // height: 80,
          child: SingleChildScrollView(
            child: Text(address,
                style: const TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
