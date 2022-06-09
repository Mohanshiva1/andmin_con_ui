import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class WRkDONE extends StatefulWidget {
  const WRkDONE({Key? key}) : super(key: key);

  @override
  State<WRkDONE> createState() => _WRkDONEState();
}

class _WRkDONEState extends State<WRkDONE> {
  final _auth = FirebaseDatabase.instance.reference().child("Staff");
  final user = FirebaseAuth.instance.currentUser;

  bool isloading = true;

  Timer? _timer;

  TextEditingController fromfield = TextEditingController();
  TextEditingController tofield = TextEditingController();
  TextEditingController wrkdonefield = TextEditingController();
  TextEditingController percentfield = TextEditingController();

  final formKey = GlobalKey<FormState>();

  //....view Works.............................
  String? CurrerntUser;
  var fbData;
  var totaltime;
  List nameView = [];
  List fromView = [];
  List toView = [];
  List workDoneView = [];
  List workPercentageView = [];

  @override
  void initState() {
    todayDate();
    setState(() {
      CurrerntUser = user?.email;
      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
        loadData();
      });
    });

    super.initState();
  }

  var cutomData;

  loadData() {
    nameView.clear();
    fromView.clear();
    toView.clear();
    workDoneView.clear();
    workPercentageView.clear();
    _auth.once().then((value) => {
          for (var element in value.snapshot.children)
            {
              fbData = element.value,
              if (fbData["email"] == CurrerntUser)
                {
                  for (var element1 in element.children)
                    {
                      for (var element2 in element1.children)
                        {
                          for (var element3 in element2.children)
                            {
                              if (element3.key == "$formattedDate")
                                {
                                  print(element3.key),
                                  for (var element4 in element3.children)
                                    {
                                      // print(element4.value),
                                      fbData = element4.value,
                                      setState(() {
                                        nameView.add(fbData['name']);
                                        toView.add(fbData['To']);
                                        fromView.add(fbData['From']);
                                        workDoneView.add(fbData['WrkDone']);
                                        workPercentageView
                                            .add(fbData['Percentage']);
                                      }),
                                    },
                                }
                            },
                        },
                    },
                }
            }
        });
  }

  //..........Create Work don.........................
  String? from;
  String? to;

  var formattedDate;
  var wrkdone;

  todayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyy-MM-dd');
    // String formattedTime = DateFormat('kk:mm:a').format(now);
    formattedDate = formatter.format(now);
  }

  CreateWrkDone() {
    _auth.once().then((value) => {
          for (var element in value.snapshot.children)
            {
              fbData = element.value,
              if (fbData["email"] == user?.email)
                {
                  wrkdone = element.key,
                  _auth
                      .child(wrkdone)
                      .child(
                          "WorkDone/timesheet/$formattedDate/'${fromfield.text.trim()} to ${tofield.text.trim()}'/")
                      .set({
                    "From": from,
                    "To": to,
                    "WrkDone": wrkdonefield.text.trim(),
                    "Percentage": '${percentfield.text.trim()}%',
                    'name': fbData['name'],
                    'Total Working': totaltime.toString().trim()
                  }),
                }
            }
        });
  }

  @override
  void dispose() {
    _timer?.cancel();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: height * 0.01,
                bottom: height * 0.01,
                right: width * 0.01,
                left: width * 0.01,
                child: Lottie.asset(
                  "assets/96479-student-girl-academy.json",
                ),
              ),
              Positioned(
                  top: height * 0.01,
                  left: width * 0.0,
                  right: width * 0.0,
                  child:
                      Lottie.asset("assets/84668-background-animation.json")),
              Positioned(
                  top: height * 0.7,
                  left: width * 0.0,
                  right: width * 0.0,
                  child:
                      Lottie.asset("assets/84669-background-animation.json")),
              Positioned(
                top: height * 0.05,
                right: width * 0.03,
                left: width * 0.03,
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: height * 0.8,
                  decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 1),
                                width: width * 0.3,
                                height: height * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(5.9, -5.9),
                                        spreadRadius: 1,
                                        blurRadius: 10)
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    TextFormField(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Nexa"),
                                        controller: fromfield,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(
                                              fontFamily: 'Nexa', fontSize: 15),
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          hintText: '    From',
                                          filled: true,
                                          fillColor: const Color(0xffFBF8FF),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.toString().isEmpty) {
                                            return 'Enter value';
                                          } else {
                                            return null;
                                          }
                                        },
                                        readOnly: true,
                                        onTap: () async {
                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if (pickedTime != null) {
                                            DateTime parsedTime =
                                                DateFormat.jm().parse(pickedTime
                                                    .format(context)
                                                    .toString());
                                            String formattedTime =
                                                DateFormat('HH:mm a')
                                                    .format(parsedTime);

                                            setState(() {
                                              fromfield.text = formattedTime;
                                            });
                                          }
                                        }),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 1),
                                width: width * 0.3,
                                height: height * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5.9, -5.9),
                                        spreadRadius: 1,
                                        blurRadius: 10),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    TextFormField(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Nexa"),
                                        controller: tofield,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(
                                              fontFamily: 'Nexa', fontSize: 15),
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          hintText: '       To',
                                          filled: true,
                                          fillColor: const Color(0xffFBF8FF),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value.toString().isEmpty) {
                                            return 'Enter value';
                                          } else {
                                            return null;
                                          }
                                        },
                                        readOnly: true,
                                        onTap: () async {
                                          TimeOfDay? pickedTime =
                                              await showTimePicker(
                                            initialTime: TimeOfDay.now(),
                                            context: context,
                                          );

                                          if (pickedTime != null) {
                                            DateTime parsedTime =
                                                DateFormat.jm().parse(pickedTime
                                                    .format(context)
                                                    .toString());
                                            String formattedTime =
                                                DateFormat('HH:mm a')
                                                    .format(parsedTime);

                                            setState(() {
                                              tofield.text = formattedTime;
                                            });
                                          }
                                        }),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 1),
                                width: width * 0.3,
                                height: height * 0.08,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5.9, -5.9),
                                        spreadRadius: 1,
                                        blurRadius: 10),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nexa"),
                                      controller: percentfield,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintStyle: const TextStyle(
                                            fontFamily: 'Nexa', fontSize: 15),
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        hintText: '   Percent',
                                        filled: true,
                                        fillColor: const Color(0xffFBF8FF),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Enter value';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xffFBF8FF),
                            indent: 30,
                            endIndent: 30,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 1),
                            height: height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(2.0, 4.0),
                                    spreadRadius: 3,
                                    blurRadius: 9),
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: const TextStyle(
                                      color: Color(0xffFBF8FF),
                                      fontFamily: "Nexa"),
                                  controller: wrkdonefield,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Nexa',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: Color(0xffFBF8FF)
                                        // (0xffFBF8FF)
                                        ),
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText:
                                        '                           Enter your Work',
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.toString().isEmpty) {
                                      return 'Enter value';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xffFBF8FF),
                            indent: 30,
                            endIndent: 30,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isloading = false;

                                from = fromfield.text
                                    .trim()
                                    .replaceAll(RegExp(r'[^0-9^:]'), ' ');
                                to = tofield.text
                                    .trim()
                                    .replaceAll(RegExp(r'[^0-9^:]'), ' ');

                                String st = fromfield.text
                                    .trim()
                                    .replaceAll(RegExp(r'[^0-9]'), ':');
                                String so = tofield.text
                                    .trim()
                                    .replaceAll(RegExp(r'[^0-9]'), ':');

                                String start_time =
                                    st.toString(); // or if '24:00'
                                String end_time = so.toString(); // or if '12:00

                                var format = DateFormat("HH:mm");
                                var start = format.parse(start_time);
                                var end = format.parse(end_time);

                                if (end.isAfter(start)) {
                                  totaltime = end.difference(start);
                                  totaltime =
                                      totaltime.toString().substring(0, 4);
                                }

                                final isValid =
                                    formKey.currentState?.validate();
                                if (isValid!) {
                                  CreateWrkDone();
                                  // loadData();
                                }
                              });
                            },
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFBF8FF),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(8, 8),
                                        blurRadius: 30,
                                        spreadRadius: 5)
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                    top: height * 0.03,
                  ),
                  margin: EdgeInsets.only(top: height * 0.6),
                  // width: width * 0.8,
                  height: height * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    // Color(0xffFBF8FF),

                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(2.0, 4.0),
                          spreadRadius: 3,
                          blurRadius: 9),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Works History",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Nexa",
                              fontSize: height * 0.02,
                              color: const Color(0xffFBF8FF)),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      const Divider(
                        thickness: 3,
                        indent: 30,
                        endIndent: 30,
                        height: 4,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: height * 0.3,
                        // color: Colors.grey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              isloading
                                  ? const Text("Enter Your Works")
                                  : buildGridView(height, width),
                            ],
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGridView(double height, double width) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: nameView.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            height: height * 0.0,
            alignment: Alignment.center,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)),
                  width: width * 0.5,
                  height: height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wrkDetails("From", "${fromView[index]}"),
                      wrkDetails("To", "${toView[index]}"),
                      wrkDetails(
                        "Percent",
                        "${workPercentageView[index]}",
                      )
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                  color: Color(0xffFBF8FF),
                  indent: 25,
                  endIndent: 25,
                  thickness: 3,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)),
                  width: width * 0.43,
                  child: Column(
                    children: [
                      Text(
                        "${workDoneView[index]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontFamily: "",
                            color: Colors.white),
                      )
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.03,
                    horizontal: width * 0.02,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Text titleName(String name) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Text(
      name,
      style: TextStyle(fontSize: height * 0.02),
    );
  }

  wrkDetails(String title, String address) {
    return SizedBox(
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
                    fontFamily: '', fontSize: 18, color: Color(0xffFBF8FF))),
          ),
        ),
      ),
    );
  }
}
