import 'package:flutter/material.dart';

class Historydetailpage extends StatefulWidget {
  const Historydetailpage({super.key});

  @override
  State<Historydetailpage> createState() => _HistorydetailpageState();
}

class _HistorydetailpageState extends State<Historydetailpage> {
  int _selectedRating = 3;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

                  // Stars
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedRating = index + 1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            // decoration: BoxDecoration()
                            child: Icon(
                              index < _selectedRating ? Icons.star : Icons.star,
                              color: index < _selectedRating
                                  ? Colors.amber
                                  : Colors.grey.shade300,
                              size: 50,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Comment input
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        // fillColor: Colors.white,
                        hintText: 'แสดงความคิดเห็นเพิ่มเติม',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF105D38),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                  const Text(
                    'ห้องน้ำตันแล้วจ้า',
                    style: TextStyle(
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
                            const Text(
                              'IT103',
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
                            const Text(
                              'ด่วน',
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
                  const Text(
                    'หลงรักคนมีเจ้าของ แอบมองอยู่ทุกวัน\nไปหลงชอบแฟนชาวบ้าน ทิ้งที่รู้ตัว\nก็น่ารัก ถูกใจนัก ไม่เคยเป็นอย่างนี้\nหลงรักคนมีเจ้าของ แอบมองอยู่เข้าเย็น\nก็รู้ว่าคงทำได้ แค่เท่านี้\nแค่พบเธอ คิดถึง แล้วนอนฝันดี',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Images row
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            color: Colors.grey.shade200,
                            child: Image.network(
                              'https://instagram.fkdt1-1.fna.fbcdn.net/v/t51.82787-19/567431191_18295625113264240_1988646781282220134_n.jpg?stp=dst-jpg_s150x150_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby4xMDgwLmMyIn0&_nc_ht=instagram.fkdt1-1.fna.fbcdn.net&_nc_cat=104&_nc_oc=Q6cZ2gF0mWMY_M-Xb-bc4nIoVK64Zl8z3tw6-vOLrrH-Ua-CGIrLwhNpOQ68A0-s9r0C0NE&_nc_ohc=JOpo31CWGiYQ7kNvwE29oGj&_nc_gid=2p1OUQIlGVmTk2BP5XrewA&edm=ALGbJPMBAAAA&ccb=7-5&oh=00_Af0Apv4d4AtarmrI9FhjT5zkMzhRUj7BeqveapcJf6-Kaw&oe=69D237C8&_nc_sid=7d3ac5https://via.placeholder.com/150x100/8B7355/ffffff?text=IMG1',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade300,
                                child: Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            color: Colors.grey.shade200,
                            child: Image.network(
                              'https://instagram.fkdt1-1.fna.fbcdn.net/v/t51.82787-19/640422877_18429895492190251_8797857697372111774_n.jpg?efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby4xMDgwLmMyIn0&_nc_ht=instagram.fkdt1-1.fna.fbcdn.net&_nc_cat=107&_nc_oc=Q6cZ2gF0mWMY_M-Xb-bc4nIoVK64Zl8z3tw6-vOLrrH-Ua-CGIrLwhNpOQ68A0-s9r0C0NE&_nc_ohc=Zjeksc6hADoQ7kNvwEyzCTh&_nc_gid=2p1OUQIlGVmTk2BP5XrewA&edm=ALGbJPMBAAAA&ccb=7-5&oh=00_Af1OFYK3wh34SD5MQ7g2NwNpF_GHjUzRBT0u0EaButB2Hg&oe=69D25C84&_nc_sid=7d3ac5',
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.grey.shade300,
                                child: Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
