import 'package:flutter/material.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:frontend/providers/authProvider.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _selectedCategory = 'ทั้งหมด';

  final List<String> _categories = [
    'ทั้งหมด',
    'แจ้งแล้ว',
    'กำลังดำเนินการ',
    'ซ่อมสำเร็จ',
  ];

  // Map Thai label → API status value
  String? _statusFilter(String category) {
    switch (category) {
      case 'แจ้งแล้ว':
        return 'PENDING';
      case 'กำลังดำเนินการ':
        return 'IN_PROGRESS';
      case 'ซ่อมสำเร็จ':
        return 'RESOLVED';
      default:
        return null; // ทั้งหมด
    }
  }

  // Map API status → Thai label
  String _statusLabel(String? status) {
    switch (status) {
      case 'PENDING':
        return 'แจ้งแล้ว';
      case 'IN_PROGRESS':
        return 'กำลังดำเนินการ';
      case 'RESOLVED':
        return 'ซ่อมสำเร็จ';
      default:
        return status ?? '-';
    }
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'PENDING':
        return const Color(0xFFFFA500);
      case 'IN_PROGRESS':
        return const Color(0xFF1976D2);
      case 'RESOLVED':
        return const Color(0xFF105D38);
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthProvider>();
      final reportProvider = context.read<ReportProvider>();

      final userId = auth.userdata?.id;
      final role = auth.userdata?.role;

      if (role == 'ADMIN') {
        reportProvider.fetchAll();
      } else {
        if (userId != null) {
          reportProvider.getByUser(userId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = context.watch<ReportProvider>();
    final reports = reportProvider.reports;

    // Count per status
    int countPending = reports.where((r) => r.status == 'PENDING').length;
    int countInProgress = reports
        .where((r) => r.status == 'IN_PROGRESS')
        .length;
    int countResolved = reports.where((r) => r.status == 'RESOLVED').length;

    // Filtered list
    final String? filterStatus = _statusFilter(_selectedCategory);
    final List<ReportModel> filtered = filterStatus == null
        ? reports
        : reports.where((r) => r.status == filterStatus).toList();

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF105D38)),
        //   onPressed: () => Navigator.pop(context),
        // ),
        centerTitle: true,
        title: const Text(
          "ประวัติ",
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    // ── Summary bar ──────────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF105D38),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          _buildActionButton(
                            icon: Icons.handyman_outlined,
                            label: 'แจ้งแล้ว',
                            count: countPending,
                            onTap: () =>
                                setState(() => _selectedCategory = 'แจ้งแล้ว'),
                            showRightBorder: true,
                          ),
                          _buildActionButton(
                            icon: Icons.bar_chart_outlined,
                            label: 'กำลังดำเนินการ',
                            count: countInProgress,
                            onTap: () => setState(
                              () => _selectedCategory = 'กำลังดำเนินการ',
                            ),
                            showRightBorder: true,
                          ),
                          _buildActionButton(
                            icon: Icons.history_outlined,
                            label: 'ซ่อมเสร็จ',
                            count: countResolved,
                            onTap: () => setState(
                              () => _selectedCategory = 'ซ่อมสำเร็จ',
                            ),
                            showRightBorder: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // ── Category filter ──────────────────────────────────
                    Row(
                      children: [
                        const Text(
                          'เลือกหมวดหมู่ :',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFDDDDDD),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCategory,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black,
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                dropdownColor: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                items: _categories
                                    .map(
                                      (c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(c),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  if (val != null)
                                    setState(() => _selectedCategory = val);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Report list ──────────────────────────────────────
                    if (reportProvider.isLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: CircularProgressIndicator(
                          color: Color(0xFF105D38),
                        ),
                      )
                    else if (reportProvider.error != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'เกิดข้อผิดพลาด: ${reportProvider.error}',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      )
                    else if (filtered.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'ไม่มีรายการ',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) =>
                            _buildReportCard(filtered[index]),
                      ),

                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(ReportModel report) {
    final dateStr = report.createdAt != null
        ? DateFormat('dd/MM/yy  HH:mm').format(report.createdAt!.toLocal())
        : '-';

    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
          // top: 5,
          // bottom: 5,
        ),
        // margin: const EdgeInsets.only(bottom: 48),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/cardhis.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: IntrinsicHeight(
                child: Container(
                  color: Color(0xFFFFFFFF),
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 12,
                    left: 5,
                    right: 5,
                  ),
                  margin: const EdgeInsets.only(right: 13),
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: IntrinsicHeight(
                          child: Container(
                            padding: const EdgeInsets.only(right: 3),
                            margin: const EdgeInsets.only(right: 13),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    "${report.title}",
                                    style: TextStyle(
                                      color: Color(0xFF105D38),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 3),
                                  width: double.infinity,
                                  child: Text(
                                    "${report.description}",
                                    style: TextStyle(
                                      color: Color(0xFF606060),
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 11),
                        width: 30,
                        child: Text(
                          "Date\nTime\nStatus  ",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        width: 46,
                        child: Text(
                          "$dateStr  \nกำลังซ่อม  ",
                          style: TextStyle(
                            color: Color(0xFF606060),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IntrinsicWidth(
              child: IntrinsicHeight(
                child: Container(
                  color: Color(0xFFFFFFFF),
                  padding: const EdgeInsets.only(
                    top: 38,
                    bottom: 38,
                    left: 7,
                    right: 7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CLICK",
                        style: TextStyle(
                          color: Color(0xFF105D38),
                          fontSize: 14,
                        ),
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
}

Widget _buildActionButton({
  required IconData icon,
  required String label,
  required int count,
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
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            border: showRightBorder
                ? const Border(
                    right: BorderSide(color: Color(0xFF3D8B65), width: 1),
                  )
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
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
