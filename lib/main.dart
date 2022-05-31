import 'package:andmin_con_ui/MainScreens/CEO/ceo_main_screeen.dart';
import 'package:andmin_con_ui/MainScreens/PR/pr_main_screen.dart';
import 'package:andmin_con_ui/MainScreens/login_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MainScreens/IT/it_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset(
        "assets/splashscreen.json",
      ),
      nextScreen: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              print("error/////////////////////////////");
              return LoginScreen();
            }
          },
        ),
      ),
      backgroundColor: Color(0xff34455B),
      splashIconSize: 350,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final database = FirebaseDatabase.instance.reference().child("Staff");
  final user = FirebaseAuth.instance.currentUser;

  String? CurrerntUser;
  var fbData;

  var dep;

  loadData() {
    database.once().then((value) {
      for (var element in value.snapshot.children) {
        // print(element.key);
        fbData = element.value;
        // print(fbData['email']);
        if(fbData['email'] == CurrerntUser){
          print('kdkdmkdf');
          if(fbData['department'] == "App"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ITScreen()));
          }
          else if(fbData['department'] == "CEO"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CEOScreen()));
          }
          else if(fbData['department'] == "PR"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PRScreen()));
          }
          else if(fbData['department'] == "Web"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ITScreen()));
          }
          else if(fbData['department'] == "RND"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ITScreen()));
          }
        }
      }
    });
  }

  @override
  void initState() {

    setState(() {
      CurrerntUser = user?.email;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       setState(() {
              //         loadData();
              //       });
              //     },
              //     child: Text("get")),

              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      FirebaseAuth.instance.signOut();
                    });
                  },
                  child: Text("Singout")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CEOScreen()));
                    });
                  },
                  child: Text("CEO")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PRScreen()));
                    });
                  },
                  child: Text("PR")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ITScreen()));
                    });
                  },
                  child: Text("IT")),
            ],
          ),
        ),
      ),
    );
  }
}
