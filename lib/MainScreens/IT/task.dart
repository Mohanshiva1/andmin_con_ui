import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF0F3FF),
        body: Center(
          child: Stack(
            children: [
              // Container(
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [
              //       ClayContainer(
              //         // color: Colors.white,
              //         surfaceColor: Colors.black,
              //         // parentColor: Colors.red,
              //         height: 200,
              //         width: 300,
              //         borderRadius: 30,
              //         depth: -80,
              //         spread: 60,
              //         curveType: CurveType.concave,
              //       ),
              //       ClayContainer(
              //           height: 180,
              //           width: 180,
              //           borderRadius: 30,
              //         depth: -30,
              //         // spread: 1,
              //
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ));
  }
}
