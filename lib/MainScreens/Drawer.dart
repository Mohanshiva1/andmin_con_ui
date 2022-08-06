import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'login_screen.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xffF7F9FC),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 4,
              indent: 25,
              endIndent: 25,
              thickness: 5,
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
          child: Icon(
            Icons.account_circle,
            color: Colors.black,
            size: 100,
          ),
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
          onTap: (){
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
            leading: IconButton(
              onPressed: () {
                // setState(() {
                //   FirebaseAuth.instance.signOut();
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const MainPage(),
                //     ),
                //   );
                // });
              },
              icon: Icon(
                Icons.logout,
                size: 30,
                color: Color(0xffEFA41C),
              ),
            ),
            title: Text(
              'Log Out',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Nexa',
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    ),
  );
}