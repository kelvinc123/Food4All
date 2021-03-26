import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  // Declare the function and int. Dart requires us
  // to declare the variables with the types
  // to pass in as an argument.
  final int _currentIndex;
  final Function _onItemTapped;

  // Here is how the class accept an argument,
  // it looks like __init__(self, arg) in Python.
  BottomNavBar(this._onItemTapped, this._currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // What function are we using when tapping
      // the navigation bar item
      onTap: _onItemTapped,

      // Set current index representing which page
      // is currently open
      currentIndex: _currentIndex,

      // Theme settings
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.greenAccent[400],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black45,

      // items argument contains all button that we
      // want to display
      items: const <BottomNavigationBarItem>[
        // item 1
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: "Home",
        ),

        // item 2
        BottomNavigationBarItem(
          icon: Icon(Icons.car_rental),
          label: "Drivers",
        ),

        // item 3
        BottomNavigationBarItem(
          icon: Icon(Icons.face_unlock_rounded),
          label: "Profile",
        ),

        // item 4
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          label: "Settings",
        ),
      ],
    );
  }
}
