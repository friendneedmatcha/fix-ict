import 'package:flutter/material.dart';

class UserNavbar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const UserNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });
  @override
  State<UserNavbar> createState() => _UserNavbarState();
}

class _UserNavbarState extends State<UserNavbar> {
  @override
  Widget build(BuildContext context) {
    return _buildBottomNavBar();
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(
            Icons.home_outlined,
            'หน้าหลัก',
            widget.selectedIndex == 0,
            0,
          ),
          _buildBottomNavItem(
            Icons.manage_search,
            'ค้นหา',
            widget.selectedIndex == 1,
            1,
          ),

          _buildBottomNavItem(
            Icons.history,
            'ประวัติ',
            widget.selectedIndex == 2,
            2,
          ),
          _buildBottomNavItem(
            Icons.account_circle_outlined,
            'โปรไฟล์',
            widget.selectedIndex == 3,
            3,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    String label,
    bool isActive,
    int index, {
    bool? isMid,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onItemTapped(index),
        borderRadius: BorderRadius.circular(15),
        splashColor: Colors.green.withOpacity(0.1),
        highlightColor: Colors.green.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          constraints: BoxConstraints(minWidth: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isMid != null
                    ? Colors.white
                    : isActive
                    ? Color(0xFF105D38)
                    : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isMid != null
                      ? Colors.white
                      : isActive
                      ? Color(0xFF105D38)
                      : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
