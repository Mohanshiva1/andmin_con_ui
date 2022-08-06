import 'package:andmin_con_ui/MainScreens/PR/create_leed.dart';
import 'package:andmin_con_ui/MainScreens/PR/serarch_leads.dart';
import 'package:andmin_con_ui/MainScreens/PR/view_leed.dart';
import 'package:andmin_con_ui/MainScreens/work_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'CEO/wrk_done_view.dart';
import 'CEO/wrk_not_entry.dart';
import 'Drawer.dart';

class TeamMainPage extends StatefulWidget {
  const TeamMainPage({Key? key}) : super(key: key);

  @override
  State<TeamMainPage> createState() => _TeamMainPageState();
}

class _TeamMainPageState extends State<TeamMainPage> {
  final staff = FirebaseDatabase.instance.reference().child("staff");
  final fingerPrint =
      FirebaseDatabase.instance.reference().child("fingerPrint");

  final user = FirebaseAuth.instance.currentUser;

  // String? formattedTime;
  var formattedDate;
  // var formattedMonth;
  // var formattedYear;

  todayDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('yyy-MM-dd');
    // var formatterYear = DateFormat('yyy');
    // var formatterMonth = DateFormat('MM');
    // formattedTime = DateFormat('HH:mm').format(now);
    formattedDate = formatterDate.format(now);
    // formattedYear = formatterYear.format(now);
    // formattedMonth = formatterMonth.format(now);
    // // print(formattedTime);
    // print(formattedDate);
  }

  String? nowUser;
  var fbData;
  var userName;
  var dep;
  bool fingerPrintStatus = false;

  getFingerPrint() {
    fingerPrint.child(user!.uid).once().then((value) => {
          // print(value.snapshot.value),
          for (var f1 in value.snapshot.children)
            {
              // print(f1.key),
              if (f1.key == formattedDate)
                {
                  setState(() {
                    fingerPrintStatus = true;
                    // print(fingerPrintStatus);
                  }),
                }
            }
        }).then((value) => loadData());
  }

  loadData() {
    staff.child(user!.uid).once().then((value) => {
          // print(value.snapshot.value),
          fbData = value.snapshot.value,
          if (fbData["email"] == nowUser)
            {
              // // print(fbData),
              setState(() {
                userName = fbData['name'];
                dep = fbData['department'];
                // print(userName);
                // print(dep);
              }),
            }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    nowUser = user?.email;
    super.initState();
    todayDate();
    getFingerPrint();

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
              height: 600,
              decoration: BoxDecoration(
                // color: Colors.orange.shade400,
                gradient: LinearGradient(
                    colors: [
                      Color(0xff21409D),
                      Color(0xff050851),
                    ],
                    stops: [
                      0.0,
                      11.0,
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    tileMode: TileMode.repeated),
              ),
              child: Stack(
                children: [
                  Positioned(
                      top: height * 0.06,
                      right: width * 0.0,
                      // left: width*0.3,
                      child: Image.asset(
                        'assets/business-team-doing-creative-brainstorming.png',
                        scale: 10.0,
                      )),
                  Positioned(
                    top: 30,
                    left: 20,
                    // right: 30,

                    child: IconButton(
                      color: Colors.orange.shade800,
                      onPressed: () {
                        setState(() {
                          // _scaffoldKey.currentState?.openDrawer();
                          getFingerPrint();
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
                            fontSize: height * 0.02,
                            color: Color(0xffffffff),
                            fontFamily: "Nexa",
                            fontWeight: FontWeight.w900),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    fingerPrintStatus == true
                        ? dep == 'PR'
                            ? GridView(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                children: [
                                  Container(
                                    child: Buttons(
                                        "Create Leads",
                                        const CreateLeeds(),
                                        Icon(
                                          Icons.create_rounded,
                                          size: height * 0.05,
                                          color: Colors.amber,
                                        )),
                                  ),
                                  Container(
                                    child: Buttons(
                                        "View Leads",
                                        const ViewLeads(),
                                        Icon(
                                          Icons.view_day,
                                          size: height * 0.05,
                                          color: Colors.amber,
                                        )),
                                  ),
                                  Container(
                                    child: Buttons(
                                        "Work Manager",
                                        WorkEntry(),
                                        Icon(
                                          Icons.work_outline_rounded,
                                          size: height * 0.05,
                                          color: Colors.amber,
                                        )),
                                  ),
                                  Container(
                                    child: Buttons(
                                        "Search Leads",
                                        SearchLeads(),
                                        Icon(
                                          Icons.view_day,
                                          size: height * 0.05,
                                          color: Colors.amber,
                                        )),
                                  ),
                                ],
                              )
                            : dep == 'ADMIN'
                                ? GridView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                    ),
                                    children: [
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

                                      Container(
                                        child: Buttons(
                                            "Work Done",
                                            const ViewWrkDone(),
                                            Icon(
                                              Icons.work_outline_rounded,
                                              size: height * 0.05,
                                              color: Colors.amber,
                                            )),
                                      ),
                                      Container(
                                        child: Buttons(
                                            "Absent Details",
                                            const AbsentAndPresent(),
                                            Icon(
                                              Icons.work_outline_rounded,
                                              size: height * 0.05,
                                              color: Colors.amber,
                                            )),
                                      ),
                                    ],
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
                                          // Container(
                                          //   child: Buttons(
                                          //       "New Task",
                                          //       const TaskScreen(),
                                          //       Icon(
                                          //         Icons.add_task_sharp,
                                          //         size: height * 0.05,
                                          //         color: Colors.amber,
                                          //       )),
                                          // ),
                                          Container(
                                            child: Buttons(
                                                "Work Manager",
                                                WorkEntry(),
                                                Icon(
                                                  Icons.work_outline_rounded,
                                                  size: height * 0.05,
                                                  color: Colors.amber,
                                                )),
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
                                              // Container(
                                              //   child: Buttons(
                                              //       "New Task",
                                              //       const TaskScreen(),
                                              //       Icon(
                                              //         Icons.add_task_sharp,
                                              //         size: height * 0.05,
                                              //         color: Colors.amber,
                                              //       )),
                                              // ),
                                              Container(
                                                child: Buttons(
                                                    "Work Manager",
                                                    WorkEntry(),
                                                    Icon(
                                                      Icons
                                                          .work_outline_rounded,
                                                      size: height * 0.05,
                                                      color: Colors.amber,
                                                    )),
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
                                                  // Container(
                                                  //   child: Buttons(
                                                  //       "New Task",
                                                  //       const TaskScreen(),
                                                  //       Icon(
                                                  //         Icons.add_task_sharp,
                                                  //         size: height * 0.05,
                                                  //         color: Colors.amber,
                                                  //       )),
                                                  // ),
                                                  Container(
                                                    child: Buttons(
                                                        "Work Manager",
                                                        WorkEntry(),
                                                        Icon(
                                                          Icons
                                                              .work_outline_rounded,
                                                          size: height * 0.05,
                                                          color: Colors.amber,
                                                        )),
                                                  ),
                                                ],
                                              )
                                            : dep == 'MEDIA'
                                                ? GridView(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      // childAspectRatio: 3 / 2,
                                                      // crossAxisSpacing: 20,
                                                      // mainAxisSpacing: 20,
                                                    ),
                                                    children: [
                                                      // Container(
                                                      //   child: Buttons(
                                                      //       "New Task",
                                                      //       const TaskScreen(),
                                                      //       Icon(
                                                      //         Icons.add_task_sharp,
                                                      //         size: height * 0.05,
                                                      //         color: Colors.amber,
                                                      //       )),
                                                      // ),
                                                      Container(
                                                        child: Buttons(
                                                            "Work Manager",
                                                            WorkEntry(),
                                                            Icon(
                                                              Icons
                                                                  .work_outline_rounded,
                                                              size:
                                                                  height * 0.05,
                                                              color:
                                                                  Colors.amber,
                                                            )),
                                                      ),
                                                    ],
                                                  )
                                                : Lottie.asset(
                                                    'assets/81778-loading.json')
                        : Text(
                            'FingerPrint Not Recognized',
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: height * 0.02,
                                fontWeight: FontWeight.w600),
                          )
                  ],
                ),
              ),
            ),
          )
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
              context, MaterialPageRoute(builder: (context) => pageName));
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(40),
        height: height * 0.15,
        width: width * 0.4,
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(-10, 10),
                blurRadius: 15,
                spreadRadius: 9),
            BoxShadow(
              color: Colors.white12,
              offset: Offset(4, 4),
              blurRadius: 10,
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          gradient: LinearGradient(
              colors: [
                Color(0xffEFA41C),
                Color(0xffD52A29),
              ],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              tileMode: TileMode.repeated),
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
                  fontSize: height * 0.013,
                  color: Color(0xffF7F9FC),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
