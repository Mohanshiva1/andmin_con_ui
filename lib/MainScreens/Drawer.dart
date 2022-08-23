import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Color(0xff1A2980),
      // Color(0xff26D0CE),
      backgroundColor: Colors.black.withOpacity(0.8),
      // backgroundColor: Color(0xffF7F9FC),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
              indent: 25,
              endIndent: 25,
              thickness: 2,
              color: Colors.white,
            ),
            buildMenuItem(),
          ],
        ),
      ),
    );
  }

  buildHeader() => Container(
        padding: EdgeInsets.only(top: 35),
        child: Column(
          children: [
            CircleAvatar(
              foregroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/ic_launcher.png'),
              // Icon(
              //   Icons.account_circle,
              //   color: Colors.orange.shade300,
              //   size: 100,
              // ),
              radius: 50,
            ),
          ],
        ),
      );

  buildMenuItem() => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPage(),
                    ),
                  );
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 30,
                  color: Color(0xffEFA41C),
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Nexa',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
