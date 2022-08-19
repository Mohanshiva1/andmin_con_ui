// import 'dart:ui';
//
// import 'package:andmin_con_ui/MainScreens/PR/create_leed.dart';
// import 'package:andmin_con_ui/MainScreens/PR/search_leads.dart';
// import 'package:andmin_con_ui/MainScreens/PR/view_leads.dart';
// import 'package:andmin_con_ui/main.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// import '../CEO/wrk_done_view.dart';
// import '../CEO/wrk_not_entry.dart';
// import '../work_entry.dart';
//
// class PRScreen extends StatefulWidget {
//   const PRScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PRScreen> createState() => _PRScreenState();
// }
//
// class _PRScreenState extends State<PRScreen> {
//   final _auth = FirebaseDatabase.instance.reference().child("staff");
//   final user = FirebaseAuth.instance.currentUser;
//
//   String? CurrerntUser;
//   var fbData;
//   var userName;
//   var dep;
//   loadData() {
//     _auth.once().then((value) => {
//           for (var element in value.snapshot.children)
//             {
//               fbData = element.value,
//               if (fbData["email"] == CurrerntUser)
//                 {
//                   // print(fbData),
//                   setState(() {
//                     userName = fbData['name'];
//                     dep = fbData['department'];
//                     print(userName);
//                     print(dep);
//                   }),
//                 }
//             }
//         });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     CurrerntUser = user?.email;
//     super.initState();
//     loadData();
//   }
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: Drawer(
//         child: NavigationDrawer(),
//       ),
//       backgroundColor: Color(0xffF7F9FC),
//       body: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             right: 0,
//             left: 0,
//             bottom: 0,
//             child: Container(
//               width: double.infinity,
//               height: 600,
//               decoration: BoxDecoration(
//                 // color: Colors.orange.shade400,
//                 gradient: LinearGradient(
//                     colors: [
//                       Color(0xff21409D),
//                       Color(0xff050851),
//                     ],
//                     stops: [
//                       0.0,
//                       11.0
//                     ],
//                     begin: FractionalOffset.topLeft,
//                     end: FractionalOffset.bottomRight,
//                     tileMode: TileMode.repeated),
//               ),
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 30,
//                     left: 20,
//                     // right: 30,
//
//                     child: IconButton(
//                       color: Colors.orange.shade800,
//                       onPressed: () {
//                         setState(() {
//
//                           _scaffoldKey.currentState?.openDrawer();
//
//                         });
//                       },
//                       icon: Icon(
//                         Icons.account_circle,
//                         size: height * 0.04,
//                       ),
//                     ),
//                   ),
//                   // Positioned(
//                   //     top: 10,
//                   //     left: 0,
//                   //     right: 0,
//                   //     child: Lottie.asset(
//                   //       'assets/69164-marketing-campaign-creative-3d-animation.json',
//                   //       height: 500,
//                   //       reverse: true,
//                   //     )),
//                   Positioned(
//                     top: 200,
//                     right: 0,
//                     left: 0,
//                     child: Center(
//                       child: Text(
//                         'Team Name',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Color(0xffffffff),
//                             fontFamily: "Nexa",
//                             fontWeight: FontWeight.w900),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 300,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Color(0xffF7F9FC),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(30),
//                   topLeft: Radius.circular(30),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     dep == 'PR'
//                         ? GridView(
//                       physics: const NeverScrollableScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                       ),
//                       children: [
//                         Container(
//                           child: Buttons(
//                               "Create Leads",
//                               const CreateLeeds(),
//                               Icon(
//                                 Icons.create_rounded,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//                         Container(
//                           child: Buttons(
//                               "View Leads",
//                               const ViewLeeds(),
//                               Icon(
//                                 Icons.view_day,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//                         Container(
//                           child: Buttons(
//                               "Work Manager",
//                               NewWorkEntry(),
//                               Icon(
//                                 Icons.work_outline_rounded,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//                         Container(
//                           child: Buttons(
//                               "Search Leads",
//                               SearchLeads(),
//                               Icon(
//                                 Icons.view_day,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//                       ],
//                     )
//                         : dep == 'IT' ? GridView(
//                       physics: const NeverScrollableScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         // childAspectRatio: 3 / 2,
//                         // crossAxisSpacing: 20,
//                         // mainAxisSpacing: 20,
//                       ),
//                       children: [
//                         // Container(
//                         //   child: Buttons(
//                         //       "New Task",
//                         //       const TaskScreen(),
//                         //       Icon(
//                         //         Icons.add_task_sharp,
//                         //         size: height * 0.05,
//                         //         color: Colors.amber,
//                         //       )),
//                         // ),
//                         Container(
//                           child: Buttons(
//                               "Work Manager",
//                               NewWorkEntry(),
//                               Icon(
//                                 Icons.work_outline_rounded,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//                       ],
//                     )
//                         : dep == 'RND'? GridView(
//                       physics: const NeverScrollableScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         // childAspectRatio: 3 / 2,
//                         // crossAxisSpacing: 20,
//                         // mainAxisSpacing: 20,
//                       ),
//                       children: [
//                         // Container(
//                         //   child: Buttons(
//                         //       "New Task",
//                         //       const TaskScreen(),
//                         //       Icon(
//                         //         Icons.add_task_sharp,
//                         //         size: height * 0.05,
//                         //         color: Colors.amber,
//                         //       )),
//                         // ),
//                         Container(
//                           child: Buttons(
//                               "Work Manager",
//                               NewWorkEntry(),
//                               Icon(
//                                 Icons.work_outline_rounded,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//                       ],
//                     )
//                         : dep == 'MEDIA'? GridView(
//                       physics: const NeverScrollableScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         // childAspectRatio: 3 / 2,
//                         // crossAxisSpacing: 20,
//                         // mainAxisSpacing: 20,
//                       ),
//                       children: [
//                         // Container(
//                         //   child: Buttons(
//                         //       "New Task",
//                         //       const TaskScreen(),
//                         //       Icon(
//                         //         Icons.add_task_sharp,
//                         //         size: height * 0.05,
//                         //         color: Colors.amber,
//                         //       )),
//                         // ),
//                         Container(
//                           child: Buttons(
//                               "Work Manager",
//                               NewWorkEntry(),
//                               Icon(
//                                 Icons.work_outline_rounded,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//                       ],
//                     )
//                         : dep == 'ADMIN'? GridView(
//                       physics: const NeverScrollableScrollPhysics(),
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//
//                       ),
//                       children: [
//                         // Container(
//                         //   child: buttons(
//                         //       "New User",
//                         //       NewUser(),
//                         //       Icon(
//                         //         Icons.manage_accounts_outlined,
//                         //         size: height * 0.05,
//                         //         color: Colors.amber,
//                         //       )),
//                         // ),
//                         // Container(
//                         //   child: buttons(
//                         //       "View Leads",
//                         //       const ViewLeeds(),
//                         //       Icon(
//                         //         Icons.view_day,
//                         //         size: height * 0.05,
//                         //         color: Colors.amber,
//                         //       )),
//                         // ),
//
//                         Container(
//                           child: Buttons(
//                               "Work Done",
//                               const ViewWrkDone(),
//                               Icon(
//                                 Icons.work_outline_rounded,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//                         Container(
//                           child: Buttons(
//                               "Absent Details",
//                               const AbsentAndPresent(),
//                               Icon(
//                                 Icons.work_outline_rounded,
//                                 size: height * 0.05,
//                                 color: Colors.amber,
//                               )),
//                         ),
//
//                       ],
//                     ) :
//                     Text(""),
//                   ],
//                 ),
//               ),
//             ),
//           )
//
//           // Positioned(
//           //   top: height * 0.13,
//           //   left: 1,
//           //   right: 1,
//           //   child: BackdropFilter(
//           //     filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
//           //     child: Column(
//           //       children: [
//           //         Center(
//           //           child: Text(
//           //             "Choose your Destination",
//           //             style: TextStyle(
//           //                 fontWeight: FontWeight.w900,
//           //                 fontFamily: "Nexa",
//           //                 fontSize: height * 0.025,
//           //                 color: Colors.black),
//           //           ),
//           //         ),
//           //         const Divider(
//           //           thickness: 3,
//           //           indent: 30,
//           //           endIndent: 30,
//           //           height: 4,
//           //           color: Colors.black,
//           //         ),
//           //         SizedBox(
//           //           height: height * 0.03,
//           //         ),
//           //         Center(
//           //           child: Text(
//           //             "Welcome Back ${userName.toString().trim()}",
//           //             style: TextStyle(
//           //                 color: Colors.black,
//           //                 fontFamily: 'Nexa',
//           //                 fontWeight: FontWeight.bold,
//           //                 fontSize: height * 0.017),
//           //           ),
//           //         )
//           //       ],
//           //     ),
//           //   ),
//           // ),
//           // Positioned(
//           //     top: height * 0.03,
//           //     left: width * 0.9,
//           //     right: width * 0.0,
//           //     child: IconButton(
//           //       onPressed: () {
//           //         setState(() {
//           //           FirebaseAuth.instance.signOut();
//           //           Navigator.pushReplacement(context,
//           //               MaterialPageRoute(builder: (context) =>  const MainPage()));
//           //
//           //         });
//           //       },
//           //       icon: Icon(Icons.logout,color: Colors.white,),
//           //       iconSize: 25,
//           //     )),
//           // Positioned(
//           //   top: height * 0.01,
//           //   bottom: height * 0.0,
//           //   left: width * 0.05,
//           //   right: width * 0.05,
//           //   child: Column(
//           //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //     children: [
//           //       GridView(
//           //         physics: const NeverScrollableScrollPhysics(),
//           //         scrollDirection: Axis.vertical,
//           //         shrinkWrap: true,
//           //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           //             crossAxisCount: 2,
//           //
//           //             ),
//           //         children: [
//           //           Container(
//           //             child: Buttons(
//           //                 "Create Leads",
//           //                 const CreateLeeds(),
//           //                 Icon(
//           //                   Icons.create_rounded,
//           //                   size: height * 0.05,
//           //                   color: Colors.amber,
//           //                 )),
//           //           ),
//           //           Container(
//           //             child: Buttons(
//           //                 "View Leads",
//           //                 const ViewLeeds(),
//           //                 Icon(
//           //                   Icons.view_day,
//           //                   size: height * 0.05,
//           //                   color: Colors.amber,
//           //                 )),
//           //           ),
//           //           Container(
//           //             child: Buttons(
//           //                 "Work Manager",
//           //                 NewWorkEntry(),
//           //                 Icon(
//           //                   Icons.work_outline_rounded,
//           //                   size: height * 0.05,
//           //                   color: Colors.amber,
//           //                 )),
//           //           ),
//           //           Container(
//           //             child: Buttons(
//           //                 "Search Leads",
//           //                 SearchLeads(),
//           //                 Icon(
//           //                   Icons.view_day,
//           //                   size: height * 0.05,
//           //                   color: Colors.amber,
//           //                 )),
//           //           ),
//           //         ],
//           //       ),
//           //     ],
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
//
//   GestureDetector Buttons(String name, Widget pageName, Icon icon) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => pageName));
//         });
//       },
//       child: AnimatedContainer(
//         margin: EdgeInsets.all(20),
//         height: height * 0.15,
//         width: width * 0.4,
//         duration: Duration(milliseconds: 100),
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black38,
//               offset: Offset(13,13),
//               blurRadius: 15,
//             ),
//             BoxShadow(
//               color: Colors.white,
//               offset: Offset(-4,-4),
//               blurRadius: 10,
//             )
//           ],
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//               colors: [
//                 Color(0xffEFA41C),
//                 Color(0xffD52A29),
//               ],
//               begin: FractionalOffset.topLeft,
//               end: FractionalOffset.bottomRight,
//               tileMode: TileMode.repeated),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               icon,
//               SizedBox(
//                 height: height * 0.02,
//               ),
//               Text(
//                 name,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontFamily: 'Nexa',
//                   fontSize: height * 0.013,
//                   color: Color(0xffF7F9FC),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class NavigationDrawer extends StatefulWidget {
//   const NavigationDrawer({Key? key}) : super(key: key);
//
//   @override
//   State<NavigationDrawer> createState() => _NavigationDrawerState();
// }
//
// class _NavigationDrawerState extends State<NavigationDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             buildHeader(),
//             buildMenuItem(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   buildHeader() => Container(
//         padding: EdgeInsets.only(top: 35),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 52,
//               // child: Lottie.asset('assets/39610-design.json'),
//             )
//           ],
//         ),
//       );
//
//   buildMenuItem() => Container(
//         padding: EdgeInsets.all(24),
//         child: Column(
//           children: [
//             ListTile(
//               leading: IconButton(
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const MainPage()));
//
//               }, icon: Icon(Icons.logout),),
//               title: Text('Log Out'),
//             )
//           ],
//         ),
//       );
// }
