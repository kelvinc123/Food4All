import 'package:flutter/material.dart';
import '../widgets/google-maps.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Takeouts Map"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: GoogleMapWidget(),
      ),
    );
  }
}
