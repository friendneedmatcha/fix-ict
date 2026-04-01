import 'package:flutter/material.dart';

class Manageuserpage extends StatelessWidget {
  const Manageuserpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "จัดการผู้ใช้งาน",
          style: TextStyle(
            fontFamily: "IBM",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40),
          children: [
            _dataUser(fname: "Nong", lname: "Ice", role: "User"),
            _dataUser(fname: "Nong", lname: "Ice", role: "User"),
            _dataUser(fname: "Wichapon", lname: "Akarak", role: "User"),
            _dataUser(fname: "Baby", lname: "Boat", role: "Admin"),
            _dataUser(fname: "Nong", lname: "Ice", role: "User"),
            _dataUser(fname: "Baby", lname: "Boat", role: "Admin"),
            _dataUser(fname: "Nong", lname: "Ice", role: "User"),
            _dataUser(fname: "Baby", lname: "Boat", role: "Admin"),
            _dataUser(fname: "Nong", lname: "Ice", role: "User"),
            _dataUser(fname: "Baby", lname: "Boat", role: "Admin"),
            _dataUser(fname: "Nong", lname: "Ice", role: "User"),
            _dataUser(fname: "Nong", lname: "Ice", role: "User"),
            _dataUser(fname: "Nong", lname: "Ice", role: "User"),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          elevation: 0,
          shape: CircleBorder(
            side: BorderSide(color: Color(0xFF105D38), width: 4),
          ),
          child: Icon(Icons.person_add_alt, size: 40, color: Color(0xFF105D38)),
        ),
      ),
    );
  }
}

class _dataUser extends StatelessWidget {
  final String fname;
  final String lname;
  final String role;
  const _dataUser({
    super.key,
    required this.fname,
    required this.lname,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 330,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "$fname $lname",
                        style: TextStyle(
                          fontFamily: "IBM",
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Role : ",
                          style: TextStyle(
                            fontFamily: "IBM",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFF8F92A1),
                          ),
                        ),
                        Text(
                          role,
                          style: TextStyle(
                            fontFamily: "IBM",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: role == "User"
                                ? Color(0xFF8F92A1)
                                : Color(0xFFEA0000),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, size: 30, color: Color(0xFF105D38)),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 30,
                  color: Color(0xFFFF0000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
