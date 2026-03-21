import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF22C375), Color(0xFF105D38)],
                        begin: Alignment.center,
                        end: Alignment.topRight,
                      ).createShader(bounds),
                      child: const Text(
                        'Fix',
                        style: TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.bold,
                          fontFamily: "IBM",
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "ICT",
                      style: TextStyle(
                        fontSize: 58,
                        fontWeight: FontWeight.bold,
                        fontFamily: "IBM",
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: "IBM",
                  color: Color(0xFF105D38),
                ),
              ),
              SizedBox(height: 20),

              _FormInput(
                label: "Username",
                icon: Icons.account_circle_outlined,
              ),
              _FormInput(label: "Password", icon: Icons.key, isPassword: true),

              SizedBox(height: 20),

              SizedBox(
                width: 189,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF105D38),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      side: BorderSide(color: Color(0xFF4CD080), width: 3),
                    ),
                  ),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontFamily: "IBM",
                      fontSize: 16,
                      letterSpacing: 1.9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Have account? Sign in",
                  style: TextStyle(
                    color: Color.fromARGB(106, 0, 0, 0),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  const _FormInput({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xFF4CD080), width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xFF4CD080), width: 3),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(icon, size: 30, color: Color.fromARGB(106, 0, 0, 0)),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Color.fromARGB(106, 0, 0, 0)),
        ),
      ),
    );
  }
}
