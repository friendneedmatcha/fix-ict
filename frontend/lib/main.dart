import 'package:flutter/material.dart';
import 'package:frontend/screens/loginPage.dart';
import 'package:frontend/screens/registerPage.dart';

void main(List<String> args) {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registerpage()
    );
  }
}