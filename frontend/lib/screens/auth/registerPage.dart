import 'package:flutter/material.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/screens/user/userHomePage.dart';

class Registerpage extends StatefulWidget {
  final AuthProvider authProvider;
  const Registerpage({super.key, required this.authProvider});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF105D38)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
                    Expanded(
                      child: _FormInput(
                        label: "First Name",
                        controller: _firstNameController,
                      ),
                    ),
                    Expanded(
                      child: _FormInput(
                        label: "Last Name",
                        controller: _lastNameController,
                      ),
                    ),
                  ],
                ),
                _FormInput(
                  label: "Email",
                  icon: Icons.account_circle_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                _FormInput(
                  label: "Password",
                  icon: Icons.key,
                  isPassword: true,
                  controller: _passwordController,
                ),
                _FormInput(
                  label: "Confirm Password",
                  isPassword: true,
                  controller: _confirmPasswordController,
                ),
                _FormInput(
                  label: "Phone",
                  icon: Icons.phone,
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: 189,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: widget.authProvider.isLoading
                        ? null
                        : () async {
                            final user = Usermodel(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              tel: _phoneController.text,
                            );

                            final success = await widget.authProvider.register(
                              user,
                            );

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('สมัครสมาชิกสำเร็จ!'),
                                  backgroundColor: Colors.green,
                                ),
                              );

                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    widget.authProvider.error!.replaceAll(
                                      'Exception: ',
                                      '',
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },

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
  final TextEditingController controller;
  const _FormInput({
    super.key,
    required this.label,
    this.icon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: TextFormField(
        controller: controller,
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
