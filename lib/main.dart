import 'package:andmin_con_ui/MainScreens/CEO/ceo_main_screeen.dart';
import 'package:andmin_con_ui/MainScreens/PR/pr_main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'MainScreens/IT/it_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()

        );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
