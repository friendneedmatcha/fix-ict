import 'package:flutter/material.dart';
import 'package:frontend/screens/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fixICT",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IBMPlexSansThai',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D52)),
      ),
      home: Homepage(),
    );
  }
}
