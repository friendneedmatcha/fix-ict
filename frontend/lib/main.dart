import 'package:flutter/material.dart';
import 'package:frontend/screens/aboutusPage.dart';
import 'package:frontend/screens/editprofilePage.dart';
import 'package:frontend/screens/homePage.dart';
import 'package:frontend/screens/loginPage.dart';
import 'package:frontend/screens/profilePage.dart';
import 'package:frontend/screens/registerPage.dart';

void main(List<String> args) {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fixICT",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IBM',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D52)),
      ),
      home: Aboutuspage(),
    );
  }
}
