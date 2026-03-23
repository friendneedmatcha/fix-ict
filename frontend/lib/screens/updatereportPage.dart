import 'package:flutter/material.dart';

class Updatereportpage extends StatefulWidget {
  const Updatereportpage({super.key});

  @override
  State<Updatereportpage> createState() => _UpdatereportpageState();
}

class _UpdatereportpageState extends State<Updatereportpage> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
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
                title: "พังหมดแล้ว ไม่มีแววได้ซ่อม",
                reporter: "รักแบบพี่ เอาดีไม่ได้",
                date: "Dec 2, 2020 3:30PM",
              ),
            ),
            _containerBox(child: _address(address: "ห้องน้ำชาย")),
            _containerBox(
              child: _description(
                desc:
                    "มีไรหรอครับโทษทีก็ที่พวกผมโก๋มือถือฟอยล์ล์ดูด หลอดดูดน้ำ เดี๋ยวผมหยิบไฟแช็คถือบ้องดูดโจ๋ อย่าทำให้ผมโมโหพวกคุณอะเด็กโกโรโกโสคิดการ ใหญ่ เหมือนพวกผมเป็นโจโฉควันขโมง",
              ),
            ),
            _containerBox(child: _updateStatus()),
          ],
        ),
      ),
    );
  }
}

class _updateStatus extends StatefulWidget {
  const _updateStatus({super.key});

  @override
  State<_updateStatus> createState() => _updateStatusState();
}

class _updateStatusState extends State<_updateStatus> {
  String? status = "กำลังนะจ๊ะ";
  final List<String> allstatus = [
    'รอแปป',
    'สองทีเสร็จ',
    'กำลังนะจ๊ะ',
    'พอแล้วคร้านทำ',
  ];
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
              child: DropdownButtonFormField(
                isExpanded: true,
                value: status,
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
                items: allstatus.map((String v) {
                  return DropdownMenuItem(value: v, child: Text(v));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    status = value;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              "อัพโหลดรูป : ",
              style: TextStyle(
                fontFamily: "IBM",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              backgroundColor: Color(0xFF105D38),
              foregroundColor: Colors.white,
            ),
            child: Text(
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
  final String? images;
  const _description({super.key, required this.desc, this.images});

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
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: images != null
              ? Image.asset(
                  "$images",
                  color: Colors.amber,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                )
              : SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ColoredBox(
                    color: Colors.amber,
                  ), // ใส่สี Amber เต็มพื้นที่ SizedBox
                ),
        ),
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
