import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularProgressIndicator(
            valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.greenAccent[700])),
        Text(
          "Loading",
          textDirection: TextDirection.rtl,
        )
      ]),
    );
  }
}
