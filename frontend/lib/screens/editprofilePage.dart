import 'package:flutter/material.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/userProvider.dart';
import 'package:frontend/models/userModel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({super.key});

  @override
  State<Editprofilepage> createState() => _EditprofilepageState();
}

class _EditprofilepageState extends State<Editprofilepage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final String apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";
  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;
  String _buildImageUrl(String? filename) {
    if (filename == null || filename.isEmpty) return '';
    if (filename.startsWith('http')) return filename;
    return '$apiUrl/uploads/$filename';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.userdata != null) {
        _firstNameController.text = authProvider.userdata?.firstName ?? "";
        _lastNameController.text = authProvider.userdata?.lastName ?? "";
        _phoneController.text = authProvider.userdata?.tel ?? "";
        _emailController.text = authProvider.userdata?.email ?? "";
      }
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // ลดขนาดไฟล์
    );
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _selectedImage = picked;
        _selectedImageBytes = bytes;
      });
    }
  }

  Future<void> _handleSave() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<Userprovider>(context, listen: false);

    final originalEmail = authProvider.userdata?.email ?? "";
    final newEmail = _emailController.text.trim();

    final updatedUser = Usermodel(
      id: authProvider.userdata?.id,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      tel: _phoneController.text.trim(),
      email: newEmail != originalEmail ? newEmail : null,
    );

    final success = await userProvider.updateProfile(
      updatedUser,
      imageFile: _selectedImage,
    );

    if (!mounted) return;

    if (success) {
      authProvider.updateUserData(userProvider.userdata!);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userProvider.error ?? 'Update failed')),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userprovider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFB00000),
            overlayColor: Colors.transparent,
            textStyle: TextStyle(fontSize: 20, fontFamily: "IBM"),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.green,
                      backgroundImage: _selectedImageBytes != null
                          ? MemoryImage(_selectedImageBytes!)
                          : (_buildImageUrl(
                                      authProvider.userdata?.profileImage,
                                    ).isNotEmpty
                                    ? NetworkImage(
                                        _buildImageUrl(
                                          authProvider.userdata?.profileImage,
                                        ),
                                      )
                                    : null)
                                as ImageProvider?,
                      child:
                          (_selectedImageBytes == null &&
                              (authProvider.userdata?.profileImage == null ||
                                  authProvider.userdata!.profileImage!.isEmpty))
                          ? Icon(Icons.person, size: 80, color: Colors.white)
                          : null,
                    ),

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: _pickImage,
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                          iconSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                if (_selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "รูปใหม่พร้อมอัปโหลด",
                      style: TextStyle(
                        color: Colors.green,
                        fontFamily: "IBM",
                        fontSize: 14,
                      ),
                    ),
                  ),

                SizedBox(height: 40),
                _dataShow(
                  lable: "First Name",
                  controller: _firstNameController,
                ),
                _dataShow(lable: "Last Name", controller: _lastNameController),
                _dataShow(lable: "Phone", controller: _phoneController),
                _dataShow(lable: "Email", controller: _emailController),

                SizedBox(height: 50),
                userProvider.isLoading
                    ? CircularProgressIndicator(color: Color(0xFF105D38))
                    : _btn(
                        label: "Save",
                        color: Color(0xFF105D38),
                        onPressed: _handleSave,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _dataShow extends StatelessWidget {
  final String lable;
  final TextEditingController controller;

  const _dataShow({super.key, required this.lable, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 350,
        height: 82,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                lable,
                style: TextStyle(
                  fontFamily: "IBM",
                  fontSize: 20,
                  color: Color(0xFF5E5E5E),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TextFormField(
                controller: controller,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "IBM",
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _btn extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  final VoidCallback? onPressed;
  const _btn({
    super.key,
    required this.label,
    required this.color,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(icon, size: 24, color: color),
                  )
                : SizedBox.shrink(),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: "IBM",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
