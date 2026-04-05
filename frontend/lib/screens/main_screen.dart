import 'package:flutter/material.dart';
import 'package:frontend/screens/historryPaage.dart';
import 'package:frontend/screens/searchPage.dart';
import 'package:frontend/widgets/navbar.dart'; // ไฟล์ Navbar ของคุณ
import 'package:frontend/screens/homePage.dart';
import 'package:frontend/screens/profilePage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const HistoryPage(),
    const Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: Navbar(
        selectedIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
