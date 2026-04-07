import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/screens/auth/registerPage.dart';
import 'package:frontend/screens/userScreen.dart';
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const Text(
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

                const SizedBox(height: 30),

                const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF105D38),
                  ),
                ),

                const SizedBox(height: 20),

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
                            await authProvider.login(
                              Usermodel(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );

                            if (!mounted) return;

                            if (authProvider.isAuthenticate) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('เข้าสู่ระบบสำเร็จ'),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MainScreen(),
                                ),
                                (route) => false,
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

                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            Registerpage(authProvider: authProvider),
                      ),
                    );
                  },
                  child: const Text(
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
        obscureText: isPassword,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF4CD080), width: 3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF4CD080), width: 3),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(icon, size: 30, color: Color.fromARGB(106, 0, 0, 0)),
          ),
          labelText: label,
          labelStyle: const TextStyle(color: Color.fromARGB(106, 0, 0, 0)),
        ),
      ),
    );
  }
}
