import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'แจ้งซ่อม',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sarabun',
        scaffoldBackgroundColor: const Color(0xFFF2F2F2),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
      ),
      home: const RepairReportScreen(),
    );
  }
}

class RepairReportScreen extends StatefulWidget {
  const RepairReportScreen({super.key});

  @override
  State<RepairReportScreen> createState() => _RepairReportScreenState();
}

class _RepairReportScreenState extends State<RepairReportScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  String? _selectedPriority;
  String? _selectedCategory;
  int _currentIndex = 0;

  final List<String> _priorityOptions = ['ต่ำ', 'ปานกลาง', 'สูง', 'เร่งด่วน'];
  final List<String> _categoryOptions = [
    'ไฟฟ้า',
    'ประปา',
    'โครงสร้าง',
    'เครื่องปรับอากาศ',
    'อื่นๆ',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'แจ้งซ่อม',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // User Profile Card
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://randomuser.me/api/portraits/men/32.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Witchapon Aka',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '11/02/2026 03:15 PM',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Title Field
                    _buildLabel('ชื่อหัวข้อ'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _titleController,
                      hintText: 'ชื่อหัวข้อ',
                    ),

                    const SizedBox(height: 16),

                    // Location Field
                    _buildLabel('สถานที่'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _locationController,
                      hintText: 'ห้อง / ชั้น / อาคาร',
                    ),

                    const SizedBox(height: 16),

                    // Priority Dropdown
                    _buildLabel('ความสำคัญ'),
                    const SizedBox(height: 8),
                    _buildDropdown(
                      value: _selectedPriority,
                      items: _priorityOptions,
                      hintText: 'dropdown',
                      onChanged: (val) =>
                          setState(() => _selectedPriority = val),
                    ),

                    const SizedBox(height: 16),

                    // Category Dropdown
                    _buildLabel('หมวดหมู่'),
                    const SizedBox(height: 8),
                    _buildDropdown(
                      value: _selectedCategory,
                      items: _categoryOptions,
                      hintText: 'dropdown',
                      onChanged: (val) =>
                          setState(() => _selectedCategory = val),
                    ),

                    const SizedBox(height: 16),

                    // Detail Field
                    _buildLabel('รายละเอียด'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _detailController,
                      hintText: 'รายละเอียด',
                      maxLines: 4,
                    ),

                    const SizedBox(height: 16),

                    // Image Upload
                    _buildLabel('รูปภาพ'),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // Handle image upload
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Click upload Image',
                            style: TextStyle(
                              color: Color(0xFFBDBDBD),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSave,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E20),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'บันทึก',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        index: 0,
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home,
                        label: 'หน้าหลัก',
                      ),
                      _buildNavItem(
                        index: 1,
                        icon: Icons.search_outlined,
                        activeIcon: Icons.search,
                        label: 'ค้นหา',
                      ),
                      _buildNavItem(
                        index: 2,
                        icon: Icons.history_outlined,
                        activeIcon: Icons.history,
                        label: 'ประวัติ',
                      ),
                      _buildNavItem(
                        index: 3,
                        icon: Icons.person_outline,
                        activeIcon: Icons.person,
                        label: 'โปรไฟล์',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 29, 29, 29),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hintText,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 1.5),
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFBDBDBD)),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF9E9E9E),
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFF9E9E9E),
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSave() {
    // Validate and save logic here
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('กรุณากรอกชื่อหัวข้อ')));
      return;
    }
    // Handle save
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('บันทึกสำเร็จ'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}
