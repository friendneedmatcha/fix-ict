import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/categoryModel.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/providers/categoryProvider.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<CategoryProvider>(context, listen: false).fetchAll();
    });
  }

  final TextEditingController titleCon = TextEditingController();
  final TextEditingController locationCon = TextEditingController();
  final TextEditingController detailCon = TextEditingController();

  String? _selectedPriority;
  String? _selectedCat;

  final List<String> _priOp = ["LOW", "MEDIUM", 'HIGH'];
  final List<String> _catOp = ["a", 'b', 'c'];

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("เลือกจากแกลเลอรี่"),
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (picked != null) {
                    setState(() => _image = File(picked.path));
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("ถ่ายรูป"),
                onTap: () async {
                  Navigator.pop(context);
                  final picked = await _picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (picked != null) {
                    setState(() => _image = File(picked.path));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    titleCon.dispose();
    locationCon.dispose();
    detailCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    String img =
        "http://localhost:3000/uploads/${authProvider.userdata?.profileImage}";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF105D38)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "แจ้งซ่อม",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CD080),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: DecorationImage(
                                image: NetworkImage(img),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${authProvider.userdata?.firstName ?? ''} ${authProvider.userdata?.lastName ?? ''}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                DateFormat(
                                  'dd/MM/yyyy HH:mm',
                                ).format(DateTime.now()),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    BoxInput(name: "ชื่อหัวข้อ", controller: titleCon),

                    const SizedBox(height: 10),

                    BoxInput(
                      name: "สถานที่",
                      hint: "ห้อง / ชั้น / อาคาร",
                      controller: locationCon,
                    ),

                    const SizedBox(height: 10),

                    BoxDropdown(
                      name: "ความสำคัญ",
                      value: _selectedPriority,
                      items: _priOp,
                      hintText: 'เลือกความสำคัญ',
                      onChanged: (val) =>
                          setState(() => _selectedPriority = val),
                    ),

                    const SizedBox(height: 10),

                    categoryProvider.isLoading
                        ? const CircularProgressIndicator()
                        : BoxDropdown(
                            name: "หมวดหมู่",
                            value: _selectedCat,
                            hintText: 'เลือกหมวดหมู่',
                            categoryItems: categoryProvider.categories,
                            onChanged: (val) =>
                                setState(() => _selectedCat = val),
                          ),

                    const SizedBox(height: 10),

                    BoxInput(
                      name: "รายละเอียด",
                      maxLines: 3,
                      controller: detailCon,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "แนบรูปภาพ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    InkWell(
                      onTap: _pickImage,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF5A5A5A)),
                        ),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(_image!, fit: BoxFit.cover),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.cloud_upload,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text("กดเพื่ออัปโหลด / ถ่ายรูป"),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// BUTTON
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
                        ),
                        onPressed: () async {
                          final reportProvider = Provider.of<ReportProvider>(
                            context,
                            listen: false,
                          );

                          final report = ReportModel(
                            title: titleCon.text,
                            location: locationCon.text,
                            priority: _selectedPriority,
                            description: detailCon.text,
                            userId: authProvider.userdata?.id,
                            categoryId: _selectedCat != null
                                ? int.parse(_selectedCat!)
                                : null,
                          );

                          final success = await reportProvider.createReport(
                            report,
                            imageFile: _image,
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("บันทึกสำเร็จ")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  reportProvider.error ?? "เกิดข้อผิดพลาด",
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
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
  final TextEditingController controller;

  const BoxInput({
    super.key,
    required this.name,
    this.hint,
    this.maxLines = 1,
    required this.controller,
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
    );
  }
}

class BoxDropdown extends StatelessWidget {
  final String name;
  final String? value;
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;

  // เพิ่ม optional สำหรับ category
  final List<Categorymodel>? categoryItems; // 👈 เพิ่ม

  const BoxDropdown({
    super.key,
    required this.name,
    this.value,
    this.items = const [],
    required this.hintText,
    required this.onChanged,
    this.categoryItems, // 👈 เพิ่ม
  });

  @override
  Widget build(BuildContext context) {
    // สร้าง items จาก categoryItems ถ้ามี
    final dropdownItems = categoryItems != null
        ? categoryItems!
              .map(
                (cat) => DropdownMenuItem(
                  value: cat.id.toString(),
                  child: Text(cat.name ?? ''),
                ),
              )
              .toList()
        : items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList();

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
            hintText: hintText,
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
          items: dropdownItems,
        ),
      ],
    );
  }
}
