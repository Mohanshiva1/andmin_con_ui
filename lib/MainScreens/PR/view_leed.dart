import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ViewLeeds extends StatefulWidget {
  const ViewLeeds({Key? key}) : super(key: key);

  @override
  State<ViewLeeds> createState() => _ViewLeedsState();
}

class _ViewLeedsState extends State<ViewLeeds> {
  final _auth = FirebaseDatabase.instance.reference().child("cust");
  final user = FirebaseAuth.instance.currentUser;

  List name = [];
  List number = [];
  List location = [];
  List email = [];
  List rating = [];
  List createdDate = [];
  List enquiry = [];
  List state = [];
  var fbData;

  viewLeads() {
    _auth.once().then((value) {
      for (var element in value.snapshot.children) {
        fbData = element.value;
        setState(() {
          number.add(fbData['phone_number']);
          name.add(fbData['name']);
          location.add(fbData['city']);
          state.add(fbData['customer_state']);
          createdDate.add(fbData['created_date']);
          rating.add(fbData['rating']);
          enquiry.add(fbData['inquired_for']);
          email.add(fbData['email_id']);
          print(number);
        });
      }
    });
  }

  @override
  void initState() {
    setState(() {
      viewLeads();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F9FC),
      body: Stack(
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
                const Text("Lead Information",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Nexa',
                        fontSize: 35,
                        color: Colors.black)),
                const Divider(
                  height: 1,
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                  thickness: 1,
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       setState(() {
                //         viewLeads();
                //       });
                //     },
                //     child: Text("get")),
                Container(
                  height: height * 0.85,
                  // padding: EdgeInsets.all(1),
                  // color: Colors.black,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        number.length == 0
                            ? Lottie.asset("assets/81778-loading.json",repeat: true,)
                            : buildGridView(width, height),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridView(double width, double height) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: number.length,
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
                  // BoxShadow(
                  //   color: Colors.white,
                  //   offset: Offset(-10.0, -10.0),
                  //   blurRadius: 10,
                  // ),
                ],
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                leadDetails("Name", "${name[index]}"),
                leadDetails("Phone", "${number[index]}"),
                leadDetails("Location", "${location[index]}"),
                leadDetails("Enquiry", "${enquiry[index]}"),
                leadDetails("Email",
                    "${email.length == 0 ? Text("No Data") : email[index]}"),
                leadDetails("createdDate", "${createdDate[index]}"),
                leadDetails("inquired_for", "${enquiry[index]}"),
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
                fontFamily: 'Nexa', fontSize: 18, color: Colors.black)),
        trailing: SizedBox(
          // width: 180,
          // height: 80,
          child: SingleChildScrollView(
            child: Text(address,
                style: const TextStyle(
                    fontFamily: 'Nexa', fontSize: 18, color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
