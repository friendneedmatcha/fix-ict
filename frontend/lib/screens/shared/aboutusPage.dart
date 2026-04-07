import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ฟังก์ชันช่วยเปิดลิงก์
Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

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
          onPressed: () {
            Navigator.pop(context);
          },
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _cardTeam(
                  name: "Thanapat",
                  id: "6787037",
                  nameIG: "thanapat.b_",
                  email: "thanapat.jul",
                  imagePath: "assets/profile/boat.jpeg",
                ),
                SizedBox(height: 20),
                _cardTeam(
                  name: "Wichapon",
                  id: "6787075",
                  nameIG: "ice_wcp",
                  email: "wichapon.aka",
                  imagePath: "assets/profile/ice.jpg",
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _cardTeam extends StatelessWidget {
  final String name;
  final String id;
  final String nameIG;
  final String email;
  final String? imagePath;
  const _cardTeam({
    super.key,
    required this.name,
    required this.id,
    required this.nameIG,
    required this.email,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 347,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Color(0xFFE7FBE1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), //
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 5),
              ),
            ],
          ),
          margin: EdgeInsets.only(top: 60),
          child: Padding(
            padding: EdgeInsetsGeometry.only(top: 90),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "IBM",
                    color: Color(0xFF105D38),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.badge_outlined,
                      color: Color(0xFF105D38),
                      size: 31,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "รหัสนักศึกษา :",
                      style: TextStyle(
                        fontFamily: "IBM",
                        fontSize: 16,
                        color: Color(0xFF8F92A1),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      id,
                      style: TextStyle(
                        fontFamily: "IBM",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _Contact(
                  icon: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Color(0xFFE1306C),
                    size: 28,
                  ),
                  title: nameIG,
                  onTap: () =>
                      _launchURL('https://www.instagram.com/${nameIG}/'),
                ),
                SizedBox(height: 20),
                _Contact(
                  icon: Icon(
                    Icons.email_outlined,
                    color: Color(0xFF105D38),
                    size: 28,
                  ),
                  title: email,
                  onTap: () => _launchURL('mailto:${email}'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: CircleAvatar(
            backgroundColor: Color(0xFF105D38),
            radius: 70,
            backgroundImage: (imagePath != null && imagePath!.isNotEmpty)
                ? AssetImage(imagePath!)
                : null,
            child: (imagePath == null || imagePath!.isEmpty)
                ? Icon(Icons.person, size: 70, color: Colors.white)
                : null,
          ),
        ),
      ],
    );
  }
}

class _Contact extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;
  const _Contact({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 307,
          height: 43,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              icon,
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontFamily: "IBM",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
