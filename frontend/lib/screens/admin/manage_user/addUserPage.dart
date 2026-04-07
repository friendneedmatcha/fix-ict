import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  String? _selectedCat;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telController = TextEditingController();
  // final List<String> _priOp = ["ต่ำ", "กลาง", 'สูง'];
  final List<String> _catOp = ["USER", 'ADMIN'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedCat == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบ')));
      return;
    }

    final userProvider = Provider.of<Userprovider>(context, listen: false);

    final newUser = Usermodel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      role: _selectedCat,
      tel: _telController.text.trim(),
    );

    final success = await userProvider.createUser(newUser);

    if (!mounted) return;

    if (success) {
      await userProvider.fetchAllUsers();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userProvider.error ?? 'เพิ่มผู้ใช้ไม่สำเร็จ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userprovider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "เพิ่มผู้ใช้งาน",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    BoxInput(name: "ชื่อ", controller: _firstNameController),
                    BoxInput(name: "นามสกุล", controller: _lastNameController),
                    BoxInput(name: "อีเมล", controller: _emailController),
                    BoxInput(name: "รหัสผ่าน", controller: _passwordController),
                    BoxInput(name: "เบอร์โทร", controller: _telController),

                    BoxDropdown(
                      name: "บทบาท",
                      value: _selectedCat,
                      items: _catOp,
                      hintText: 'dropdown',
                      onChanged: (val) => setState(() => _selectedCat = val),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E20),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: userProvider.isLoading ? null : _handleSave,
                        child: Text(
                          "บันทึก",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoxInput extends StatelessWidget {
  final String name;
  final String? hint;
  final int maxLines;
  final TextEditingController? controller;

  const BoxInput({
    super.key,
    required this.name,
    this.hint,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint ?? name,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF5A5A5A)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BoxDropdown extends StatelessWidget {
  final String name;
  final String? value;
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;

  const BoxDropdown({
    super.key,
    required this.name,
    this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: name,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF5A5A5A)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFBDBDBD)),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
        ),
      ],
    );
  }
}
