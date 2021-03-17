import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodybite_app/pallete.dart';
import 'package:foodybite_app/widgets/widgets.dart';

import 'screens.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/Food4All.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    'Food4All',
                    style: TextStyle(
                        color: Colors.green[300],
                        fontSize: 80,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  MaterialButton(
                    child: Text("Get started"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
