import 'package:ch4_lec8/screens/firstpage.dart';
import 'package:ch4_lec8/screens/homepage.dart';
import 'package:ch4_lec8/screens/secondpage.dart';
import 'package:ch4_lec8/screens/thirdpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context){
          return HomePage();
        },
        "first":(context){
          return FirstPage();
        },
        "second":(context){
          return SecondPage();
        },
        "third":(context){
          return Thirdpage();
        },
      },
    )
  );
}

