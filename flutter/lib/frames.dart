import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'widgets/bottom_navbar.dart';

// This class is used for frame, meaning that
// the theme, bottom navigation bar, and top bar
// will be same for all pages.
class Frames extends StatefulWidget {
  @override
  _FramesState createState() => _FramesState();
}

class _FramesState extends State<Frames> {
  // specify the first index on _children variable which is Home()
  int _currentIndex = 0;

  // Here is the list of the widgets of all pages.
  // Each of them are available on screns/ directory
  final List<Widget> _children = [
    Home(),
    Drivers(),
    Profile(),
    Settings(),
  ];

  // Function to change index for changing page
  // from _children
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // The body of the page is currently Home() (index 0)
      body: _children[_currentIndex],

      // Bottom navigation bar from bottom_navbar.dart file
      bottomNavigationBar: BottomNavBar(_onItemTapped, _currentIndex),
    );
  }
}
