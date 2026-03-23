import 'package:flutter/material.dart';

class Reportlistpage extends StatefulWidget {
  const Reportlistpage({super.key});

  @override
  State<Reportlistpage> createState() => _ReportlistpageState();
}

class _ReportlistpageState extends State<Reportlistpage> {
  String? category = "ทั้งหมด";
  final List<String> categories = ['ทั้งหมด', 'สุดหล่อ', 'ท่อหมก', 'ทรงเชง'];
  @override
  Widget build(BuildContext context) {
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
        child: Center(
          child: ListView(
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
                        child: DropdownButtonFormField(
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
                          items: categories.map((String v) {
                            return DropdownMenuItem(value: v, child: Text(v));
                          }).toList(),
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
              _dataShow(
                title: "พังหมดแล้ว",
                date: "Dec 2, 2020 3:30PM",
                status: "กำลังดำเนินการ",
                statusColor: Color(0xFF00E35A),
              ),
              _dataShow(
                title: "คับ",
                date: "Dec 2, 2020 3:30PM",
                status: "กำลังดำเนินการ",
                statusColor: Color(0xFF00E35A),
              ),
              _dataShow(
                title: "แล้ว",
                date: "Dec 2, 2020 3:30PM",
                status: "กำลังดำเนินการ",
                statusColor: Color(0xFF00E35A),
              ),
              _dataShow(
                title: "พอ",
                date: "Dec 2, 2020 3:30PM",
                status: "กำลังดำเนินการ",
                statusColor: Color(0xFF00E35A),
              ),
              _dataShow(
                title: "พังหมดแล้ว",
                date: "Dec 2, 2020 3:30PM",
                status: "กำลังดำเนินการ",
                statusColor: Color(0xFF00E35A),
              ),
              _dataShow(
                title: "พังหมดแล้ว",
                date: "Dec 2, 2020 3:30PM",
                status: "กำลังดำเนินการ",
                statusColor: Color(0xFF00E35A),
              ),
              _dataShow(
                title: "พังหมดแล้ว",
                date: "Dec 2, 2020 3:30PM",
                status: "กำลังดำเนินการ",
                statusColor: Color(0xFF00E35A),
              ),
            ],
          ),
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
  final VoidCallback? onTap;
  const _dataShow({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
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
                    onPressed: () {},
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
