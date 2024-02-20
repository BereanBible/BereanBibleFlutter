import 'package:flutter/material.dart';

class BibleBottomNavBar extends StatefulWidget {
  @override
  State<BibleBottomNavBar> createState() => _BibleBottomNavBarState();
}

class _BibleBottomNavBarState extends State<BibleBottomNavBar> {
  var reference = "";

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Bible Reader',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore Page',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: 1,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (value) {
        setState(() {
          // selectedIndex = value;
        });
      },
    );
  }
}