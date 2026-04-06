import 'package:flutter/material.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:frontend/providers/categoryProvider.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:frontend/screens/report/updatereportPage.dart';
import 'package:provider/provider.dart';

class Reportlistpage extends StatefulWidget {
  const Reportlistpage({super.key});

  @override
  State<Reportlistpage> createState() => _ReportlistpageState();
}

class _ReportlistpageState extends State<Reportlistpage> {
  String? category = "ทั้งหมด";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReportProvider>(context, listen: false).fetchAll();
      Provider.of<CategoryProvider>(context, listen: false).fetchAll();
    });
  }

  String _statusText(String? status) {
    switch (status) {
      case 'PENDING':
        return 'รอดำเนินการ';
      case 'IN_PROGRESS':
        return 'กำลังดำเนินการ';
      case 'SUCCESS':
        return 'เสร็จสิ้น';
      default:
        return status ?? '-';
    }
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'PENDING':
        return Color(0xFFFF9800);
      case 'IN_PROGRESS':
        return Color(0xFF00E35A);
      case 'SUCCESS':
        return Color(0xFF2196F3);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    final filteredReports = reportProvider.reports
        .where((r) => r.status != 'SUCCESS')
        .where(
          (r) => category == "ทั้งหมด" || r.categoryId.toString() == category,
        )
        .toList();

    final categoryItems = [
      "ทั้งหมด",
      ...categoryProvider.categories.map((c) => c.id.toString()),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "รายการปัญหา",
          style: TextStyle(
            fontFamily: "IBM",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: reportProvider.isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFF105D38)))
            : reportProvider.error != null
            ? Center(child: Text(reportProvider.error!))
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "เลือกหมวดหมู่ :",
                          style: TextStyle(
                            fontFamily: "IBM",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 34,
                            child: DropdownButtonFormField<String>(
                              style: TextStyle(
                                fontFamily: "IBM",
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              value: category,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: "ทั้งหมด",
                                  child: Text("ทั้งหมด"),
                                ),
                                ...categoryProvider.categories.map(
                                  (c) => DropdownMenuItem(
                                    value: c.id.toString(),
                                    child: Text(c.name ?? "-"),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  category = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ...filteredReports.map(
                    (report) => _dataShow(
                      title: report.title ?? "-",
                      date:
                          report.createdAt?.toString().substring(0, 16) ?? "-",
                      status: _statusText(report.status),
                      statusColor: _statusColor(report.status),
                      report: report,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _dataShow extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final ReportModel report;
  final VoidCallback? onTap;

  const _dataShow({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.report,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF105D38),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: 230,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: "IBM",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),

                          Text(
                            date,
                            style: TextStyle(
                              fontFamily: "IBM",
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Row(
                            children: [
                              Text(
                                "สถานะ : ",
                                style: TextStyle(
                                  fontFamily: "IBM",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                status,
                                style: TextStyle(
                                  fontFamily: "IBM",
                                  fontSize: 14,
                                  color: statusColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Updatereportpage(report: report),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      textStyle: TextStyle(
                        fontFamily: "IBM",
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    child: Text("รายละเอียด"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
