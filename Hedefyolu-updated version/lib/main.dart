import 'package:Hedefyolu/data/dbHelper.dart';
import 'package:Hedefyolu/screens/ControlPage.dart';
import 'package:Hedefyolu/screens/GetStarted.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ControlPage()
    );
  }


}