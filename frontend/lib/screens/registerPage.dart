import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: "IBM",
                    color: Color(0xFF105D38),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(child: _FormInput(label: "First Name")),
                    Expanded(child: _FormInput(label: "Last Name")),
                  ],
                ),
                _FormInput(
                  label: "Email",
                  icon: Icons.account_circle_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                _FormInput(
                  label: "Password",
                  icon: Icons.key,
                  isPassword: true,
                ),
                _FormInput(label: "Confirm Password", isPassword: true),
                _FormInput(
                  label: "Phone",
                  icon: Icons.phone,
                  keyboardType: TextInputType.number,
                ),

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
                      "REGISTER",
                      style: TextStyle(
                        fontFamily: "IBM",
                        fontSize: 16,
                        letterSpacing: 1.9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormInput extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isPassword;
  final TextInputType keyboardType;
  const _FormInput({
    super.key,
    required this.label,
    this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: TextFormField(
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xFF4CD080), width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xFF4CD080), width: 3),
          ),
          prefixIcon: icon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    icon,
                    size: 30,
                    color: Color.fromARGB(106, 0, 0, 0),
                  ),
                )
              : null,
          labelText: label,
          labelStyle: TextStyle(color: Color.fromARGB(106, 0, 0, 0)),
        ),
      ),
    );
  }
}
