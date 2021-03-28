import 'package:flutter/material.dart';
import '../widgets/google-maps.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Available Takeouts")),
        backgroundColor: Colors.greenAccent[700],
      ),
      body: Center(
        child: GoogleMapWidget(),
      ),
    );
  }
}
