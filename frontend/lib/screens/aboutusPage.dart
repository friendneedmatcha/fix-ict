import 'package:flutter/material.dart';

class Aboutuspage extends StatelessWidget {
  const Aboutuspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text(
          "About Team",
          style: TextStyle(
            color: Color(0xFF105D38),
            fontFamily: "IBM",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(child: Column(children: [Text("data")])),
      ),
    );
  }
}
