import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Updatereportpage extends StatefulWidget {
  final ReportModel report;
  const Updatereportpage({super.key, required this.report});

  @override
  State<Updatereportpage> createState() => _UpdatereportpageState();
}

class _UpdatereportpageState extends State<Updatereportpage> {
  String? _selectedStatus;
  final List<String> _statusOptions = ['PENDING', 'IN_PROGRESS', 'SUCCESS'];

  XFile? _selectedImage;
  Uint8List? _selectedImageBytes;

  String _statusLabel(String s) {
    switch (s) {
      case 'PENDING':
        return 'รอดำเนินการ';
      case 'IN_PROGRESS':
        return 'กำลังดำเนินการ';
      case 'SUCCESS':
        return 'เสร็จสิ้น';
      default:
        return s;
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.report.status ?? 'PENDING';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("ถ่ายรูป"),
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("เลือกจากแกลเลอรี่"),
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    final picked = await picker.pickImage(source: source, imageQuality: 80);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _selectedImage = picked;
        _selectedImageBytes = bytes;
      });
    }
  }

  String _buildImageUrl(String? filename) {
    if (filename == null || filename.isEmpty) return '';
    if (filename.startsWith('http')) return filename;
    final apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";
    return '$apiUrl/uploads/$filename';
  }

  Future<void> _handleSave() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);

    final success = await reportProvider.updateReport(
      id: widget.report.id!,
      status: _selectedStatus!,
      note: "",
      updatedBy: authProvider.userdata!.id!,
      imageFile: _selectedImage,
    );

    if (!mounted) return;

    if (success) {
      await reportProvider.fetchAll();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(reportProvider.error ?? 'Update failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);
    final imageUrl = _buildImageUrl(widget.report.imageBefore);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: IconButton.styleFrom(
                minimumSize: Size.square(10),
                iconSize: 15,
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.arrow_back_ios_new_outlined),
            ),
            title: const Text(
              "รายละเอียด",
              style: TextStyle(
                fontFamily: "IBM",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _containerBox(
              child: _headTitle(
                title: widget.report.title ?? "-",
                reporter:
                    "${widget.report.userFirstName ?? ''} ${widget.report.userLastName ?? ''}"
                        .trim(),
                date:
                    widget.report.createdAt?.toString().substring(0, 16) ?? "-",
              ),
            ),
            _containerBox(
              child: _address(address: widget.report.location ?? "-"),
            ),
            _containerBox(
              child: _description(
                desc: widget.report.description ?? "-",
                imageUrl: imageUrl.isNotEmpty ? imageUrl : null,
                imageAfterUrl: _buildImageUrl(widget.report.imageAfter),
              ),
            ),
            _containerBox(
              child: _updateStatus(
                selectedStatus: _selectedStatus,
                statusOptions: _statusOptions,
                statusLabel: _statusLabel,
                selectedImageBytes: _selectedImageBytes,
                onPickImage: _pickImage,
                isLoading: reportProvider.isLoading,
                onSave: _handleSave,
                onStatusChanged: (val) => setState(() => _selectedStatus = val),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _updateStatus extends StatelessWidget {
  final String? selectedStatus;
  final List<String> statusOptions;
  final String Function(String) statusLabel;

  final Uint8List? selectedImageBytes;
  final VoidCallback onPickImage;
  final bool isLoading;
  final VoidCallback onSave;
  final ValueChanged<String?> onStatusChanged;

  const _updateStatus({
    super.key,
    required this.selectedStatus,
    required this.statusOptions,
    required this.statusLabel,

    required this.selectedImageBytes,
    required this.onPickImage,
    required this.isLoading,
    required this.onSave,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              "อัพเดทสถานะ : ",
              style: TextStyle(
                fontFamily: "IBM",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: selectedStatus,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                items: statusOptions
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text(statusLabel(s)),
                      ),
                    )
                    .toList(),
                onChanged: onStatusChanged,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        Row(
          children: [
            Text(
              "อัพโหลดรูป",
              style: TextStyle(
                fontFamily: "IBM",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: onPickImage,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "เลือกรูป",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "IBM",
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),

        if (selectedImageBytes != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(
              selectedImageBytes!,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),

        SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : onSave,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              backgroundColor: Color(0xFF105D38),
              foregroundColor: Colors.white,
            ),
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    "SAVE",
                    style: TextStyle(
                      fontFamily: "IBM",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _description extends StatelessWidget {
  final String desc;
  final String? imageUrl;
  final String? imageAfterUrl;
  const _description({
    super.key,
    required this.desc,
    this.imageUrl,
    this.imageAfterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.description_outlined,
              size: 30,
              color: Color(0xFF105D38),
            ),
            Text(
              "รายละเอียด",
              style: TextStyle(
                fontFamily: "IBM",
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF105D38),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
          child: Text(desc, overflow: TextOverflow.ellipsis, maxLines: 7),
        ),
        Text(
          "รูปก่อนดำเนินการ",
          style: TextStyle(fontFamily: "IBM", fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 180,
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, color: Colors.grey, size: 40),
                        SizedBox(height: 8),
                        Text(
                          "ไม่พบรูปภาพ",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ColoredBox(color: Colors.amber),
                ),
        ),
        if (imageAfterUrl != null && imageAfterUrl!.isNotEmpty) ...[
          SizedBox(height: 12),
          Text(
            "รูปหลังดำเนินการ",
            style: TextStyle(fontFamily: "IBM", fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageAfterUrl!,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey.shade200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, color: Colors.grey, size: 40),
                    SizedBox(height: 8),
                    Text(
                      "ไม่พบรูปภาพ",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _address extends StatelessWidget {
  final String address;
  const _address({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_pin, size: 30, color: Color(0xFF105D38)),
        Text(
          "สถานที่ : ",
          style: TextStyle(
            fontFamily: "IBM",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF105D38),
          ),
        ),
        Expanded(
          child: Text(
            address,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontFamily: "IBM", fontSize: 18),
          ),
        ),
      ],
    );
  }
}

class _containerBox extends StatelessWidget {
  final Widget child;
  const _containerBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
        color: Colors.white,
      ),
      child: child,
    );
  }
}

class _headTitle extends StatelessWidget {
  final String title;
  final String reporter;
  final String date;
  const _headTitle({
    super.key,
    required this.title,
    required this.reporter,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "หัวข้อ",
                  style: TextStyle(
                    fontFamily: "IBM",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF105D38),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(fontFamily: "IBM", fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "รายงานโดย :",
                style: TextStyle(fontFamily: "IBM", fontSize: 12),
              ),
              Text(
                reporter,
                style: TextStyle(fontFamily: "IBM", fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "แจ้งเมื่อ :",
                style: TextStyle(fontFamily: "IBM", fontSize: 12),
              ),
              Text(
                date,
                style: TextStyle(fontFamily: "IBM", fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
