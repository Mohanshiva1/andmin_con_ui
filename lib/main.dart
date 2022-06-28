import 'package:andmin_con_ui/MainScreens/CEO/ceo_main_screeen.dart';
import 'package:andmin_con_ui/MainScreens/PR/pr_main_screen.dart';
import 'package:andmin_con_ui/MainScreens/login_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'MainScreens/IT/it_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
      nextScreen: MainPage(),
      backgroundColor: const Color(0xff34455B),
      splashIconSize: 350,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginScreen();
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
  final database = FirebaseDatabase.instance.reference().child("staff");
  final user = FirebaseAuth.instance.currentUser;

  String? CurrerntUser;
  var fbData;

  var dep;

  loadData() {
    database.once().then((value) {
      for (var element in value.snapshot.children) {
        fbData = element.value;
        if (fbData['email'] == CurrerntUser) {
          if (fbData['department'] == "APP") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ITScreen()));
          }
          else if (fbData['department'] == "admin") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const CEOScreen()));
          }
          else if (fbData['department'] == "PR") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const PRScreen()));
          }
          else if (fbData['department'] == "WEB") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ITScreen()));
          }
          else if (fbData['department'] == "RND") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ITScreen()));
          }
        }
      }
    });
  }

  // ....................Get Location........................................


  @override
  void initState() {
    setState(()  {
      CurrerntUser = user?.email;
      loadData();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/81778-loading.json",
              ),
              // ElevatedButton(onPressed: (){
              //   setState(() {
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CEOScreen()));
              //
              //   });
              // }, child: Text("ceo")),
              // ElevatedButton(onPressed: (){
              //   setState(() {
              //
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ITScreen()));
              //
              //   });
              // }, child: Text("It")),
              // ElevatedButton(onPressed: (){
              //   setState(() {
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>PRScreen()));
              //   });
              // }, child: Text("PR")),

            ],
          ),
        ),
      ),
    );
  }
}
