import 'package:flutter/material.dart';

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({super.key});

  @override
  State<Editprofilepage> createState() => _EditprofilepageState();
}

class _EditprofilepageState extends State<Editprofilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFB00000),
            overlayColor: Colors.transparent,
            textStyle: TextStyle(fontSize: 20, fontFamily: "IBM"),
          ),
          onPressed: () {},
          child: Text("Cancel"),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(radius: 80, backgroundColor: Colors.green,),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                          iconSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
          
                SizedBox(height: 60),
                _dataShow(lable: "First Name", data: "Baby"),
                _dataShow(lable: "Last Name", data: "Boat"),
                _dataShow(lable: "Phone", data: "099-999-9999"),
                _dataShow(lable: "Email", data: "babyBoat@gmail.com"),
          
                SizedBox(height: 50),
                _btn(label: "save", color: Color(0xFF105D38)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _dataShow extends StatefulWidget {
  final String lable;
  final String data;

  const _dataShow({super.key, required this.lable, required this.data});

  @override
  State<_dataShow> createState() => _dataShowState();
}

class _dataShowState extends State<_dataShow> {
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.data);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 350,
        height: 82,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.lable,
                style: TextStyle(
                  fontFamily: "IBM",
                  fontSize: 20,
                  color: Color(0xFF5E5E5E),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: TextFormField(
                controller: _controller,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "IBM",
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _btn extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;
  const _btn({super.key, required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 268,
      height: 48,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(icon, size: 24, color: color),
                  )
                : SizedBox.shrink(),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: "IBM",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
