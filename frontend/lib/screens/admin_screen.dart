import 'package:flutter/material.dart';
import 'package:frontend/screens/admin/adminPage.dart';
import 'package:frontend/screens/history/historyPage.dart';
import 'package:frontend/screens/report/reportlistPage.dart';
import 'package:frontend/screens/user/profilePage.dart';
import 'package:frontend/widgets/admin_navbar.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedPage = 0;

  final List<Widget> _pages = [
    const AdminPage(),
    const Reportlistpage(),
    const HistoryPage(),
    const Profilepage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedPage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedPage, children: _pages),
      bottomNavigationBar: AdminNabar(
        selectedIndex: _selectedPage,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
