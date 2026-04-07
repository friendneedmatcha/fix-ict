import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/models/categoryModel.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/providers/categoryProvider.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:frontend/screens/history/historyPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  final List<String> _priOp = ["LOW", "MEDIUM", "HIGH"];

  /// ===== IMAGE STATE (แบบเดียวกับ EditProfile) =====
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;

  /// ===== PICK IMAGE =====
  Future<void> _pickImage() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("ถ่ายรูป"),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("เลือกจากแกลเลอรี่"),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picked = await _picker.pickImage(source: source, imageQuality: 80);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _selectedImage = picked;
        _selectedImageBytes = bytes;
      });
    }
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF105D38)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "แจ้งซ่อม",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CD080),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundImage:
                          authProvider.userdata?.profileImage != null
                          ? NetworkImage(
                              "${dotenv.env['API_URL']}/uploads/${authProvider.userdata!.profileImage}",
                            )
                          : null,
                      child: authProvider.userdata?.profileImage == null
                          ? const Icon(Icons.person, color: Colors.white)
                          : null,
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
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
                          style: const TextStyle(color: Colors.white),
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
                hintText: "เลือกความสำคัญ",
                onChanged: (val) => setState(() => _selectedPriority = val),
              ),
              const SizedBox(height: 10),

              categoryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : BoxDropdown(
                      name: "หมวดหมู่",
                      value: _selectedCat,
                      hintText: "เลือกหมวดหมู่",
                      categoryItems: categoryProvider.categories,
                      onChanged: (val) => setState(() => _selectedCat = val),
                    ),

              const SizedBox(height: 10),

              BoxInput(name: "รายละเอียด", maxLines: 3, controller: detailCon),

              const SizedBox(height: 15),

              const Text(
                "แนบรูปภาพ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              InkWell(
                onTap: _pickImage,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF5A5A5A)),
                  ),
                  child: _selectedImageBytes != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(
                            _selectedImageBytes!,
                            fit: BoxFit.cover,
                          ),
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

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E20),
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
                      imageFile: _selectedImage,
                    );

                    if (!mounted) return;

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("บันทึกสำเร็จ")),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HistoryPage()),
                        // (route) => false,
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
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
