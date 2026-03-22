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
          child: Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
