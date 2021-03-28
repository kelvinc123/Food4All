import 'package:flutter/material.dart';

class Drivers extends StatefulWidget {
  @override
  _DriversState createState() => _DriversState();
}

class _DriversState extends State<Drivers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("Available Pickup"),
      )),
      body: DriverBody(),
    );
  }
}

class DriverBody extends StatelessWidget {
  List<String> _testItems = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "h",
    "i",
    "j"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _testItems.length,
          itemBuilder: (BuildContext context, int index) {
            return RestaurantsWidget(_testItems[index]);
          }),
    );
  }
}

class RestaurantsWidget extends StatelessWidget {
  final item;

  RestaurantsWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(item),
    ));
  }
}
