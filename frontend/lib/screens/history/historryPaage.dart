import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF105D38)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true, // ทำให้ title อยู่กลาง
        title: const Text(
          "ประวัติ",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black, // ปรับสีตามต้องการ
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
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
                            onTap: () {},
                            showRightBorder: true,
                          ),
                          _buildActionButton(
                            icon: Icons.bar_chart_outlined,
                            label: 'กำลังดำเนินการ',
                            onTap: () {},
                            showRightBorder: true,
                          ),
                          _buildActionButton(
                            icon: Icons.history_outlined,
                            label: 'ซ่อมเสร็จ',
                            onTap: () {},
                            showRightBorder: false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
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
                    SizedBox(height: 14),
                    IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 18,
                          // top: 5,
                          // bottom: 5,
                        ),
                        margin: const EdgeInsets.only(bottom: 48),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: IntrinsicHeight(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              right: 3,
                                            ),
                                            margin: const EdgeInsets.only(
                                              right: 13,
                                            ),
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    bottom: 6,
                                                  ),
                                                  child: Text(
                                                    "TITLE NAME",
                                                    style: TextStyle(
                                                      color: Color(0xFF105D38),
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                    left: 3,
                                                  ),
                                                  width: double.infinity,
                                                  child: Text(
                                                    "ดูดดอกครับกูไม่ดูดเกล็ดแต่กูบิดสุดปลอกตอนที่กูดูดเสร็จ\n",
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
                                        margin: const EdgeInsets.only(
                                          right: 11,
                                        ),
                                        width: 29,
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
                                        width: 39,
                                        child: Text(
                                          "12/12/69    \n0:00PM      \nกำลังซ่อม  ",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    ),
                  ],
                ),
              ),
            ),
            // ),
            SizedBox(height: 14),
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
              Text(
                "6",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
