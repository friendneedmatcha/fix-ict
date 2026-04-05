import 'package:flutter/material.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/services/authService.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              const Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF105D38),
                ),
              ),

              _FormInput(
                label: "Email",
                icon: Icons.account_circle_outlined,
                controller: _emailController,
              ),
              _FormInput(
                label: "Password",
                icon: Icons.key,
                isPassword: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 189,
                height: 44,
                child: ElevatedButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                          print(_emailController.text);
                          print(_passwordController.text);

                          await authProvider.login(
                            Usermodel(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );

                          if (authProvider.isAuthenticate) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('เข้าสู่ระบบสำเร็จ'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  authProvider.error ?? 'Login failed',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF105D38),
                    foregroundColor: Colors.white,
                  ),
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("LOGIN"),
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
  final TextEditingController controller;
  const _FormInput({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
      child: TextFormField(
        controller: controller,
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
