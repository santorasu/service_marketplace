
import 'package:flutter/material.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF4A90E2),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'ORDERS'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'CHAT'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'BOOKMARKS'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
      ],
    );
  }
}
