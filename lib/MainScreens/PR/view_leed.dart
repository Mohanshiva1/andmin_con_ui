import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ViewLeeds extends StatefulWidget {
  const ViewLeeds({Key? key}) : super(key: key);

  @override
  State<ViewLeeds> createState() => _ViewLeedsState();
}

class _ViewLeedsState extends State<ViewLeeds> {
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
            top: height * 0.1,
            left: width * 0.05,

            right: width * 0.05,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Column(

                children: [
                  const Text("Lead Information",style: TextStyle(
                    fontWeight: FontWeight.w900,
                      fontFamily: 'Nexa', fontSize: 35, color: Color(0xffFBF8FF))),
                const Divider(
                  height: 1,
                  color: Color(0xffFBF8FF),
                  indent: 30,
                  endIndent: 30,
                  thickness: 1,
                ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // color: Colors.white.withOpacity(0.1),
                    ),
                    height: height * 0.80,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemCount: 3,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
                                        leadDetails("Name", "Customer Name"),
                                        leadDetails("Phone", "1234567890"),
                                        leadDetails("Location", "Customer Location"),
                                        leadDetails("Enquiry", "null"),
                                        leadDetails("Email", "customer@gmail.com"),
                                        leadDetails("Data by", "Staff Name"),
                                        leadDetails("Fetched by", "Staff Name"),
                                        leadDetails("Rating", "5"),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  leadDetails(String title, String address) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.04,
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                fontFamily: 'Nexa', fontSize: 18, color: Color(0xffFBF8FF))),
        trailing: SizedBox(
          // width: 180,
          // height: 80,
          child: SingleChildScrollView(
            child: Text(address,
                style: const TextStyle(
                    fontFamily: 'Nexa',
                    fontSize: 18,
                    color: Color(0xffFBF8FF))),
          ),
        ),
      ),
    );
  }
}
