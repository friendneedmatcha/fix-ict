import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  String? _selectedCat;

  // final List<String> _priOp = ["ต่ำ", "กลาง", 'สูง'];
  final List<String> _catOp = ["USER", 'ADMIN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Expanded(
                    child: Center(
                      child: Text(
                        "เพิ่มผู้ใช้งาน",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width: 40),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    BoxInput(name: "ชื่อ"),
                    const SizedBox(height: 10),

                    BoxInput(name: "นามสกุล"),
                    const SizedBox(height: 10),
                    BoxInput(name: "อีเมล"),
                    const SizedBox(height: 10),
                    BoxInput(name: "รหัสผ่าน"),
                    const SizedBox(height: 10),

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
                        onPressed: () => print("55"),
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

  const BoxInput({super.key, required this.name, this.hint, this.maxLines = 1});

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
