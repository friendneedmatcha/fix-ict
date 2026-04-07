import 'package:flutter/material.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:frontend/screens/admin/manage_user/manageuserPage.dart';
import 'package:frontend/screens/history/historyPage.dart';
import 'package:frontend/screens/report/reportListPage.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'สวัสดีตอนเช้า';
    if (hour >= 12 && hour < 17) return 'สวัสดีตอนบ่าย ';
    if (hour >= 17 && hour < 21) return 'สวัสดีตอนเย็น';
    return 'สวัสดีตอนดึก';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReportProvider>(context, listen: false).fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
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
                      'Hello ${authProvider.userdata?.firstName ?? ""} ${authProvider.userdata?.lastName ?? ""}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _getGreeting(),
                      style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF105D38),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "สรุปภาพรวมระบบ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "รายงานปัญหาทั้งหมด",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              _statBox(
                                label: "รอดำเนินการ",
                                count: reportProvider.reports
                                    .where((r) => r.status == 'PENDING')
                                    .length,
                              ),
                              SizedBox(width: 5),
                              _statBox(
                                label: "กำลังดำเนินการ",
                                count: reportProvider.reports
                                    .where((r) => r.status == 'IN_PROGRESS')
                                    .length,
                              ),
                              SizedBox(width: 5),
                              _statBox(
                                label: "เสร็จสิ้น",
                                count: reportProvider.reports
                                    .where((r) => r.status == 'SUCCESS')
                                    .length,
                              ),
                            ],
                          ),
                        ],
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
                            label: 'ดูการแจ้งซ่อม',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Reportlistpage(),
                                ),
                              );
                            },
                            showRightBorder: true,
                          ),
                          _buildActionButton(
                            icon: Icons.account_circle,
                            label: 'จัดการผู้ใช้',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Manageuserpage(),
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

                    reportProvider.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF105D38),
                            ),
                          )
                        : Column(
                            children:
                                ([...reportProvider.reports]..sort(
                                      (a, b) =>
                                          b.createdAt!.compareTo(a.createdAt!),
                                    ))
                                    .take(5)
                                    .map(
                                      (report) => Container(
                                        margin: EdgeInsets.only(bottom: 12),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.04,
                                              ),
                                              blurRadius: 8,
                                              offset: Offset(9, 2),
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
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 22,
                                              ),
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    report.createdAt
                                                            ?.toString()
                                                            .substring(0, 16) ??
                                                        "-",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF9E9E9E),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
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

Widget _statBox({required String label, required int count}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            "$count",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
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
