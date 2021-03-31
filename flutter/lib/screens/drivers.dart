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
          title: Text("Available Pickup"),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: DriverBody(),
    );
  }
}

class DriverBody extends StatelessWidget {
  DriverBody({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
      children: <Widget>[
        ProductBox(
            name: "Shawama King",
            description: "Available Takeouts: 10",
            image: "shaw.png"),
        ProductBox(
            name: "Dough Zone",
            description: "Available Takeouts: 10",
            image: "dough.png"),
        ProductBox(
            name: "Valhalla Sandwiches",
            description: "Available Takeouts: 10",
            image: "val.png"),
        ProductBox(
            name: "Uneeda Burger",
            description: "Available Takeouts: 10",
            image: "une.png"),
      ],
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.name, this.description, this.image})
      : super(key: key);
  final String name;
  final String description;
  final String image;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 120,
        child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    "assets/images/" + image,
                    width: 116.0,
                    height: 116.0,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(this.name,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(this.description),
                            ],
                          )))
                ])));
  }
}
