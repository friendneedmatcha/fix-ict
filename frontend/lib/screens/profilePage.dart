import 'package:flutter/material.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 80, backgroundColor: Color(0xFF4CD080)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF105D38),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                child: SizedBox(
                  width: 110,
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.edit, size: 18),
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontFamily: "IBMPlexSansThai",
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _dataShow(lable: "Name", data: "Baby Boat"),
              _dataShow(lable: "Phone", data: "099-999-9999"),
              _dataShow(lable: "Email", data: "BabyBoat@gmail.com"),
              SizedBox(height: 20),

              _btn(label: "Contact About Us", color: Color(0xFF0022FF)),
              SizedBox(height: 20),
              _btn(
                label: "Log Out",
                color: Color(0xFFDF0000),
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _btn extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  const _btn({super.key, required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268,
      height: 48,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(icon, size: 24, color: color),
                  )
                : SizedBox.shrink(),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: "IBMPlexSansThai",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _dataShow extends StatelessWidget {
  final String lable;
  final String data;
  const _dataShow({super.key, required this.lable, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 350,
        height: 82,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                lable,
                style: TextStyle(
                  fontFamily: "IBMPlexSansThai",
                  fontSize: 20,
                  color: Color(0xFF5E5E5E),
                ),
              ),
            ),
            Divider(thickness: 1, color: Colors.black),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                data,
                style: TextStyle(
                  fontFamily: "IBMPlexSansThai",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
