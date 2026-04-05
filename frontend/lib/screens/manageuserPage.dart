import 'package:flutter/material.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/screens/addUserPage.dart';
import 'package:frontend/screens/editUserPage.dart';
import 'package:provider/provider.dart';

class Manageuserpage extends StatefulWidget {
  const Manageuserpage({super.key});

  @override
  State<Manageuserpage> createState() => _ManageuserpageState();
}

class _ManageuserpageState extends State<Manageuserpage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Userprovider>(context, listen: false).fetchAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userprovider>(context);
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
        child: userProvider.isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFF105D38)))
            : userProvider.error != null
            ? Center(child: Text(userProvider.error!))
            : ListView(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 100),
                children: userProvider.users
                    .map((user) => _dataUser(user: user))
                    .toList(),
              ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddUserPage()),
            );
          },
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
  final Usermodel user;
  const _dataUser({super.key, required this.user});

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
                        "${user.firstName} ${user.lastName}",
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
                          user.role ?? "USER",
                          style: TextStyle(
                            fontFamily: "IBM",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: user.role == "USER"
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUserPage(user: user),
                    ),
                  );
                },
                icon: Icon(Icons.edit, size: 30, color: Color(0xFF105D38)),
              ),
              IconButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("ยืนยันการลบ"),
                      content: Text(
                        "ต้องการลบ ${user.firstName} ${user.lastName} ใช่หรือไม่?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: Text("ยกเลิก"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: Text(
                            "ลบ",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final success = await Provider.of<Userprovider>(
                      context,
                      listen: false,
                    ).deleteUser(user.id!);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(success ? "ลบสำเร็จ" : "ลบไม่สำเร็จ"),
                      ),
                    );
                  }
                },
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
