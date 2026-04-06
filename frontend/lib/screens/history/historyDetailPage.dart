import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/providers/reportProvider.dart';
import 'package:provider/provider.dart';

class Historydetailpage extends StatefulWidget {
  final int reportId;
  Historydetailpage({super.key, required this.reportId});

  @override
  State<Historydetailpage> createState() => _HistorydetailpageState();
}

class _HistorydetailpageState extends State<Historydetailpage> {
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

  int _selectedRating = 3;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ReportProvider>(
        context,
        listen: false,
      ).fetchById(widget.reportId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReportProvider>(context);
    final report = provider.selectedReport;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xD1105C37),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  // Green header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: const BoxDecoration(color: Color(0xFF105D38)),
                    child: const Text(
                      'FixICT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  // // Stars
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     vertical: 16,
                  //     horizontal: 20,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: List.generate(5, (index) {
                  //       return GestureDetector(
                  //         onTap: () =>
                  //             setState(() => _selectedRating = index + 1),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 4),
                  //           // decoration: BoxDecoration()
                  //           child: Icon(
                  //             index < _selectedRating ? Icons.star : Icons.star,
                  //             color: index < _selectedRating
                  //                 ? Colors.amber
                  //                 : Colors.grey.shade300,
                  //             size: 50,
                  //           ),
                  //         ),
                  //       );
                  //     }),
                  //   ),
                  // ),

                  // // Comment input
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                  //   child: TextField(
                  //     controller: _commentController,
                  //     decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Colors.white,
                  //       // fillColor: Colors.white,
                  //       hintText: 'แสดงความคิดเห็นเพิ่มเติม',
                  //       hintStyle: TextStyle(
                  //         color: Colors.grey.shade400,
                  //         fontSize: 14,
                  //       ),
                  //       contentPadding: const EdgeInsets.symmetric(
                  //         horizontal: 16,
                  //         vertical: 12,
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: BorderSide(color: Colors.grey.shade300),
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: BorderSide(color: Colors.grey.shade300),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: const BorderSide(
                  //           color: Color(0xFF105D38),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service name label
                  Text(
                    'ชื่อรายการซ่อม',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),

                  // Service title
                  Text(
                    report?.title ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Location & Priority row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'สถานที่',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              report?.location ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ความสำคัญ',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              report?.priority ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Detail label
                  Text(
                    'รายละเอียด',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),

                  // Detail text
                  Text(
                    report?.description ?? '',
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      /// 🔹 BEFORE IMAGE
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 200,
                            color: Colors.grey.shade200,
                            child: report?.imageBefore != null
                                ? Image.network(
                                    "$_apiUrl/uploads/${report!.imageBefore}",
                                    fit: BoxFit.cover,
                                  )
                                : _buildErrorImage(),
                          ),
                        ),
                      ),

                      /// 🔹 AFTER IMAGE (แสดงเฉพาะ SUCCESS)
                      if (report?.status == "SUCCESS") ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              color: Colors.grey.shade200,
                              child: report?.imageAfter != null
                                  ? Image.network(
                                      "$_apiUrl/uploads/${report!.imageAfter}",
                                      fit: BoxFit.cover,
                                    )
                                  : _buildErrorImage(),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Divider
                  // Divider(color: Colors.grey.shade200, thickness: 1),
                  const SizedBox(height: 12),

                  // Status / Date / Time row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoColumn(
                        label: 'status',
                        value: 'success',
                        valueColor: Color(0xFF105D38),
                        fontWeight: FontWeight.w600,
                      ),
                      _buildInfoColumn(
                        label: 'Date',
                        value: '12 May, 2026',
                        valueColor: Colors.black87,
                      ),
                      _buildInfoColumn(
                        label: 'Time',
                        value: '3:30 PM',
                        valueColor: Colors.black87,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.chevron_left,
            color: Colors.black87,
            size: 22,
          ),
        ),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'รายละเอียด',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildInfoColumn({
    required String label,
    required String value,
    required Color valueColor,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: fontWeight,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

Widget _buildErrorImage() {
  return Container(
    color: Colors.grey.shade300,
    child: Icon(Icons.image, size: 40, color: Colors.grey.shade500),
  );
}
