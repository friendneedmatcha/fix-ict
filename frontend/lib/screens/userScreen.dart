import 'package:flutter/material.dart';
import 'package:frontend/screens/history/historyPage.dart';
import 'package:frontend/screens/search/searchPage.dart';
import 'package:frontend/screens/user/profilePage.dart';
import 'package:frontend/screens/user/userHomePage.dart';
import 'package:frontend/widgets/userNavbar.dart';

class UserMainScreen extends StatefulWidget {
  const UserMainScreen({super.key});

  @override
  State<UserMainScreen> createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _selectedPage = 0;

  final List<Widget> _pages = [
    const UserHomePage(),
    const SearchPage(),
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
      bottomNavigationBar: UserNavbar(
        selectedIndex: _selectedPage,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
