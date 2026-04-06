import 'package:flutter/material.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:frontend/screens/history/historryPaage.dart';
import 'package:frontend/screens/report/formPage.dart';
import 'package:frontend/screens/search/searchPage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ReportProvider>(context, listen: false).fetchTop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final reportProvider = Provider.of<ReportProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),
                    Text(
                      'Hello ${authProvider.userdata?.firstName}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'สวัสดีตอนเช้าคับ',
                      style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF79),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF105D38),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          _buildActionButton(
                            icon: Icons.handyman_outlined,
                            label: 'แจ้งซ่อม',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormPage(),
                                ),
                              );
                            },
                            showRightBorder: true,
                          ),
                          _buildActionButton(
                            icon: Icons.bar_chart_outlined,
                            label: 'ติดตาม',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(),
                                ),
                              );
                            },
                            showRightBorder: true,
                          ),
                          _buildActionButton(
                            icon: Icons.history_outlined,
                            label: 'ประวัติ',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryPage(),
                                ),
                              );
                            },
                            showRightBorder: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28),

                    Text(
                      'รายการล่าสุดที่แจ้งเข้ามา',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),

                    SizedBox(height: 14),

                    if (reportProvider.isLoading)
                      Center(child: CircularProgressIndicator())
                    else if (reportProvider.reportTop.isEmpty)
                      Center(child: Text("ยังไม่มีรายการ"))
                    else
                      Column(
                        children: reportProvider.reportTop.map((report) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  offset: Offset(2, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF105D38),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.build, color: Colors.white),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        report.title ?? "-",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        DateFormat('dd MMM yyyy, HH:mm').format(
                                          DateTime.parse(
                                            report.createdAt ?? "",
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
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

Widget _buildActionButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required bool showRightBorder,
}) {
  return Expanded(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.white24,
        highlightColor: Colors.white10,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            border: showRightBorder
                ? Border(right: BorderSide(color: Color(0xFF3D8B65), width: 1))
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 26),
              SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
