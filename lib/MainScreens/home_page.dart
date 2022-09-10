import 'dart:async';
import 'package:andmin_con_ui/MainScreens/CEO/announcement_screen.dart';
import 'package:andmin_con_ui/MainScreens/PR/invoice/Screens/Customer_Details_Screen.dart';
import 'package:andmin_con_ui/MainScreens/PR/search_leads.dart';
import 'package:andmin_con_ui/MainScreens/PR/view_leads.dart';
import 'package:andmin_con_ui/MainScreens/refreshment.dart';
import 'package:andmin_con_ui/MainScreens/work_entry.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CEO/wrk_done_view.dart';
import 'CEO/wrk_not_entry.dart';
import 'Drawer.dart';
import 'PR/invoice/Screens/Company_Details_Screen.dart';
import 'PR/invoice/Screens/intro_Screen.dart';
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
    staff
        .child(user!.uid)
        .once()
        .then((value) => {
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
            })
        .then((value) => init());
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

  String name = '';
  String email = '';
  SharedPreferences? preferences;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    preferences?.setString('name', '${userName}');
    preferences?.setString('email', '${nowUser}');
    preferences?.setString('department', '${dep}');
    // print(preferences?.getString('name'));
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
      drawer: const ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(60), bottomRight: Radius.circular(60)),
        child: Drawer(
          child: NavigationDrawer(),
        ),
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
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          _scaffoldKey.currentState?.openDrawer();
                        });
                      },
                      iconSize: height * 0.04,
                      icon: Icon(Icons.menu),
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
                physics: BouncingScrollPhysics(),
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
                              //...........REFRESHMENT.....................
                              Container(
                                child: Buttons(
                                  "Refreshment",
                                  const Refreshment(),
                                  Icon(
                                    FontAwesomeIcons.mugHot,
                                    // Icons.refresh,
                                    size: height * 0.05,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                              //...........VIEW LEADS......................
                              Container(
                                child: Buttons(
                                  "View Leads",
                                  const ViewLeads(),
                                  Icon(
                                    FontAwesomeIcons.usersViewfinder,
                                    size: height * 0.05,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                              // ...........INVOICE.........................
                              Container(
                                child: Buttons(
                                  "Invoice",
                                  CustomerDetails(),
                                  // CompanyDetails(),
                                  Icon(
                                    FontAwesomeIcons.fileInvoiceDollar,
                                    size: height * 0.05,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                              // ...........WORK MANAGER....................
                              Container(
                                child: Buttons(
                                  "Work Manager",
                                  WorkEntry(),
                                  Icon(
                                    FontAwesomeIcons.briefcase,
                                    size: height * 0.05,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                              //...........SEARCH LEADS....................
                              Container(
                                child: Buttons(
                                  "Search Leads",
                                  SearchLeads(),
                                  Icon(
                                    FontAwesomeIcons.searchengin,
                                    size: height * 0.05,
                                    color: Colors.white.withOpacity(0.9),
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
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                    //...........REFRESHMENT....................
                                    Container(
                                      child: Buttons(
                                        "Refreshment",
                                        const Refreshment(),
                                        Icon(
                                          FontAwesomeIcons.mugHot,
                                          size: height * 0.05,
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                    //...........WORK HISTORY....................
                                    Container(
                                      child: Buttons(
                                        "Work Done",
                                        const ViewWrkDone(),
                                        Icon(
                                          FontAwesomeIcons.briefcase,
                                          size: height * 0.05,
                                          color: Colors.white.withOpacity(0.9),
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
                                          color: Colors.white.withOpacity(0.9),
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
                                    //         color: Colors.white.withOpacity(0.9),
                                    //       )),
                                    // ),
                                    // Container(
                                    //   child: buttons(
                                    //       "View Leads",
                                    //       const ViewLeeds(),
                                    //       Icon(
                                    //         Icons.view_day,
                                    //         size: height * 0.05,
                                    //         color: Colors.white.withOpacity(0.9),
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
                                            FontAwesomeIcons.mugHot,
                                            size: height * 0.05,
                                            color: Colors.white.withOpacity(0.9),
                                          ),
                                        ),
                                      ),
                                      //...........WORK MANAGER....................
                                      Container(
                                        child: Buttons(
                                          "Work Manager",
                                          WorkEntry(),
                                          Icon(
                                            FontAwesomeIcons.briefcase,
                                            size: height * 0.05,
                                            color: Colors.white.withOpacity(0.9),
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
                                                FontAwesomeIcons.mugHot,
                                                size: height * 0.05,
                                                color: Colors.white.withOpacity(0.9),
                                              ),
                                            ),
                                          ),
                                          //...........WORK MANAGER....................
                                          Container(
                                            child: Buttons(
                                              "Work Manager",
                                              WorkEntry(),
                                              Icon(
                                                FontAwesomeIcons.briefcase,
                                                size: height * 0.05,
                                                color: Colors.white.withOpacity(0.9),
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
                                                    FontAwesomeIcons.mugHot,
                                                    size: height * 0.05,
                                                    color: Colors.white.withOpacity(0.9),
                                                  ),
                                                ),
                                              ),
                                              //...........WORK MANAGER....................
                                              Container(
                                                child: Buttons(
                                                  "Work Manager",
                                                  WorkEntry(),
                                                  Icon(
                                                    FontAwesomeIcons.briefcase,
                                                    size: height * 0.05,
                                                    color: Colors.white.withOpacity(0.9),
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
                                                        FontAwesomeIcons.mugHot,
                                                        size: height * 0.05,
                                                        color:
                                                            Colors.white.withOpacity(0.9),
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
                                                        color:
                                                            Colors.white.withOpacity(0.9),
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
