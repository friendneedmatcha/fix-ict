import 'package:flutter/material.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/screens/aboutusPage.dart';
import 'package:frontend/screens/editprofilePage.dart';
import 'package:frontend/screens/auth/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String _buildImageUrl(String? filename) {
    if (filename == null || filename.isEmpty) return '';
    if (filename.startsWith('http')) return filename;

    final apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";
    return '$apiUrl/uploads/$filename';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final imageUrl = _buildImageUrl(authProvider.userdata?.profileImage);

    return authProvider.isAuthenticate
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Color(0xFF4CD080),
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : null,
                        child: imageUrl.isEmpty
                            ? Icon(Icons.person, size: 80, color: Colors.white)
                            : null,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Editprofilepage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF105D38),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
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
                                  fontFamily: "IBM",
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _dataShow(
                        lable: "Name",
                        data:
                            "${authProvider.userdata?.firstName} ${authProvider.userdata?.lastName}",
                      ),
                      _dataShow(
                        lable: "Phone",
                        data: authProvider.userdata?.tel ?? "-",
                      ),
                      _dataShow(
                        lable: "Email",
                        data: authProvider.userdata?.email ?? "-",
                      ),
                      SizedBox(height: 20),

                      _btn(
                        label: "Contact About Us",
                        color: Color(0xFF0022FF),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Aboutuspage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      _btn(
                        label: "Log Out",
                        color: Color(0xFFDF0000),
                        icon: Icons.logout,
                        onTap: () async {
                          await authProvider.logout();

                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Loginpage(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Loginpage();
  }
}

class _btn extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final VoidCallback? onTap;
  const _btn({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268,
      height: 48,
      child: OutlinedButton(
        onPressed: onTap,
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
                fontFamily: "IBM",
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
                  fontFamily: "IBM",
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
                  fontFamily: "IBM",
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
