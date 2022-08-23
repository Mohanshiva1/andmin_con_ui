import 'dart:async';
import 'package:andmin_con_ui/MainScreens/CEO/announcement_screen.dart';
import 'package:andmin_con_ui/MainScreens/PR/search_leads.dart';
import 'package:andmin_con_ui/MainScreens/PR/view_leads.dart';
import 'package:andmin_con_ui/MainScreens/refreshment.dart';
import 'package:andmin_con_ui/MainScreens/work_entry.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'CEO/wrk_done_view.dart';
import 'CEO/wrk_not_entry.dart';
import 'Drawer.dart';
import 'PR/invoice/Screens/splash_screen.dart';

class TeamMainPage extends StatefulWidget {
  const TeamMainPage({Key? key}) : super(key: key);

  @override
  State<TeamMainPage> createState() => _TeamMainPageState();
}

class _TeamMainPageState extends State<TeamMainPage> {
  final staff = FirebaseDatabase.instance.ref().child("staff");
  final fingerPrint = FirebaseDatabase.instance.ref().child("fingerPrint");
  final user = FirebaseAuth.instance.currentUser;

  // String? formattedTime;
  // var formattedDate;
  // var formattedMonth;
  // var formattedYear;

  // todayDate() {
  //   var now = DateTime.now();
  //   var formatterDate = DateFormat('yyy-MM-dd');
  //   // var formatterYear = DateFormat('yyy');
  //   // var formatterMonth = DateFormat('MM');
  //   // formattedTime = DateFormat('HH:mm').format(now);
  //   formattedDate = formatterDate.format(now);
  //   // formattedYear = formatterYear.format(now);
  //   // formattedMonth = formatterMonth.format(now);
  //   // // print(formattedTime);
  //   // print(formattedDate);
  // }

  String? nowUser;
  var fbData;
  var userName;
  var dep;
  bool fingerPrintStatus = false;

  // getFingerPrint() {
  //   fingerPrint.child(user!.uid).once().then((value) => {
  //         // print(value.snapshot.value),
  //         for (var f1 in value.snapshot.children)
  //           {
  //             // print(f1.key),
  //             if (f1.key == formattedDate)
  //               {
  //                 setState(() {
  //                   fingerPrintStatus = true;
  //                   // print(fingerPrintStatus);
  //                 }),
  //               }
  //           }
  //       }).then((value) => loadData());
  // }
  //
  loadData() {
    staff.child(user!.uid).once().then((value) => {
          // print(value.snapshot.value),
          fbData = value.snapshot.value,
          if (fbData["email"] == nowUser)
            {
              // print(fbData),
              setState(() {
                userName = fbData['name'];
                dep = fbData['department'];
                // print(userName);
                // print(dep);
              }),
            }
        });
  }

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  @override
  void initState() {
    getConnectivity();
    nowUser = user?.email;
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: NavigationDrawer(),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: height * 0.0,
              decoration: BoxDecoration(
                // color: Colors.orange.shade400,
                gradient: LinearGradient(
                  colors: [
                    Color(0xff1A2980),
                    Color(0xff26D0CE),
                    // Color(0xff21409D),
                    // Color(0xff050851),
                  ],
                  // stops: [
                  //   0.0,
                  //   11.0,
                  // ],
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  // tileMode: TileMode.repeated,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: height * 0.05,
                    right: width * 0.0,
                    // left: width*0.3,
                    child: Image.asset(
                      'assets/business-team-doing-creative-brainstorming.png',
                      scale: 13.0,
                    ),
                  ),
                  Positioned(
                    top: height * 0.03,
                    left: width * 0.0,
                    // right: 30,
                    child: IconButton(
                      color: Colors.orange.shade800,
                      onPressed: () {
                        setState(() {
                          _scaffoldKey.currentState?.openDrawer();
                        });
                      },
                      iconSize: height * 0.04,
                      icon: Container(child: Image.asset('assets/menu.png')),
                    ),
                  ),
                  Positioned(
                    top: height * 0.13,
                    // right: 0,
                    left: width * 0.04,
                    child: Center(
                      child: Text(
                        'Hi...  \n${userName}',
                        style: TextStyle(
                          fontSize: height * 0.03,
                          color: Color(0xffffffff).withOpacity(1.0),
                          fontFamily: "Nexa",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.26,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.black.withOpacity(0.9),
                color: Color(0xffF7F9FC),
                image: DecorationImage(
                  alignment: Alignment.bottomCenter,
                  image: AssetImage(
                    'assets/outdoor.png',
                  ),
                  fit: BoxFit.scaleDown,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dep == 'PR'
                        ? GridView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            children: [
                              //...........REFRESHMENT....................
                              Container(
                                child: Buttons(
                                  "Refreshment",
                                  const Refreshment(),
                                  Icon(
                                    Icons.refresh,
                                    size: height * 0.05,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              //...........VIEW LEADS....................
                              Container(
                                child: Buttons(
                                  "View Leads",
                                  const ViewLeads(),
                                  Icon(
                                    Icons.view_day,
                                    size: height * 0.05,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              //...........INVOICE....................
                              Container(
                                child: Buttons(
                                  "Create invoice",
                                  SplashScreenPage(),
                                  Icon(
                                    Icons.price_change_rounded,
                                    size: height * 0.05,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              //...........WORK MANAGER....................
                              Container(
                                child: Buttons(
                                  "Work Manager",
                                  WorkEntry(),
                                  Icon(
                                    Icons.work_outline_rounded,
                                    size: height * 0.05,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              //...........SEARCH LEADS....................
                              Container(
                                child: Buttons(
                                  "Search Leads",
                                  SearchLeads(),
                                  Icon(
                                    Icons.view_day,
                                    size: height * 0.05,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : dep == 'ADMIN'
                            ? Container(
                                height: height * 0.8,
                                child: GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  children: [
                                    //...........ANNOUNCEMENT....................
                                    Container(
                                      child: Buttons(
                                        "Announcement",
                                        const Announcement(),
                                        Icon(
                                          Icons.announcement_outlined,
                                          size: height * 0.05,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    //...........REFRESHMENT....................
                                    Container(
                                      child: Buttons(
                                        "Refreshment",
                                        const Refreshment(),
                                        Icon(
                                          Icons.refresh,
                                          size: height * 0.05,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    //...........WORK HISTORY....................
                                    Container(
                                      child: Buttons(
                                        "Work Done",
                                        const ViewWrkDone(),
                                        Icon(
                                          Icons.work_outline_rounded,
                                          size: height * 0.05,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    //...........ABSENT DETAILS....................
                                    Container(
                                      child: Buttons(
                                        "Absent Details",
                                        const AbsentAndPresent(),
                                        Icon(
                                          Icons.work_off_outlined,
                                          size: height * 0.05,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   child: buttons(
                                    //       "New User",
                                    //       NewUser(),
                                    //       Icon(
                                    //         Icons.manage_accounts_outlined,
                                    //         size: height * 0.05,
                                    //         color: Colors.amber,
                                    //       )),
                                    // ),
                                    // Container(
                                    //   child: buttons(
                                    //       "View Leads",
                                    //       const ViewLeeds(),
                                    //       Icon(
                                    //         Icons.view_day,
                                    //         size: height * 0.05,
                                    //         color: Colors.amber,
                                    //       )),
                                    // ),
                                  ],
                                ),
                              )
                            : dep == 'APP'
                                ? GridView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      // childAspectRatio: 3 / 2,
                                      // crossAxisSpacing: 20,
                                      // mainAxisSpacing: 20,
                                    ),
                                    children: [
                                      //...........REFRESHMENT....................
                                      Container(
                                        child: Buttons(
                                          "Refreshment",
                                          const Refreshment(),
                                          Icon(
                                            Icons.refresh,
                                            size: height * 0.05,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                      //...........WORK MANAGER....................
                                      Container(
                                        child: Buttons(
                                          "Work Manager",
                                          WorkEntry(),
                                          Icon(
                                            Icons.work_outline_rounded,
                                            size: height * 0.05,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : dep == 'WEB'
                                    ? GridView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          // childAspectRatio: 3 / 2,
                                          // crossAxisSpacing: 20,
                                          // mainAxisSpacing: 20,
                                        ),
                                        children: [
                                          Container(
                                            child: Buttons(
                                              "Refreshment",
                                              const Refreshment(),
                                              Icon(
                                                Icons.refresh,
                                                size: height * 0.05,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ),
                                          //...........WORK MANAGER....................
                                          Container(
                                            child: Buttons(
                                              "Work Manager",
                                              WorkEntry(),
                                              Icon(
                                                Icons.work_outline_rounded,
                                                size: height * 0.05,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : dep == 'RND'
                                        ? GridView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              // childAspectRatio: 3 / 2,
                                              // crossAxisSpacing: 20,
                                              // mainAxisSpacing: 20,
                                            ),
                                            children: [
                                              Container(
                                                child: Buttons(
                                                  "Refreshment",
                                                  const Refreshment(),
                                                  Icon(
                                                    Icons.refresh,
                                                    size: height * 0.05,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              ),
                                              //...........WORK MANAGER....................
                                              Container(
                                                child: Buttons(
                                                  "Work Manager",
                                                  WorkEntry(),
                                                  Icon(
                                                    Icons.work_outline_rounded,
                                                    size: height * 0.05,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : dep == 'MEDIA'
                                            ? GridView(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  // childAspectRatio: 3 / 2,
                                                  // crossAxisSpacing: 20,
                                                  // mainAxisSpacing: 20,
                                                ),
                                                children: [
                                                  Container(
                                                    child: Buttons(
                                                      "Refreshment",
                                                      const Refreshment(),
                                                      Icon(
                                                        Icons.refresh,
                                                        size: height * 0.05,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                  ),
                                                  //...........WORK MANAGER....................
                                                  Container(
                                                    child: Buttons(
                                                      "Work Manager",
                                                      WorkEntry(),
                                                      Icon(
                                                        Icons
                                                            .work_outline_rounded,
                                                        size: height * 0.05,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Lottie.asset(
                                                'assets/loading_2.json'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showDialogBox() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("No Connection"),
        content: Text("Please check your internet connection"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context, 'Cancel');
              setState(() {
                isAlertSet = false;
              });
              isDeviceConnected =
                  await InternetConnectionChecker().hasConnection;
              if (!isDeviceConnected) {
                showDialogBox();
                setState(() {
                  isAlertSet = true;
                });
              }
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // addStringToSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('stringValue', dep);
  // }

  GestureDetector Buttons(String name, Widget pageName, Icon icon) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageName),
          );
        });
      },
      child: Container(
        margin: EdgeInsets.all(15),
        height: height * 0.50,
        width: width * 0.4,
        decoration: BoxDecoration(
          // color: Colors.blue.shade300,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(-10, 10),
              blurRadius: 5,
              // spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white12,
              offset: Offset(10, 10),
              blurRadius: 5,

            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: [

              Color(0xff26D0CE),
              Color(0xff1A2980),
              // Color(0xffEFA41C),
              // Color(0xffD52A29),
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            tileMode: TileMode.repeated,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Nexa',
                  fontSize: height * 0.02,
                  color: Color(0xffF7F9FC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
