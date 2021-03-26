import 'package:flutter/material.dart';
import 'package:food4all_app/pallete.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.onPressed,
    this.loading = false,
    @required this.buttonName,
  }) : super(key: key);

  final Function onPressed;
  final bool loading;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: Colors.greenAccent[700],
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        child: loading
            ? CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(
                buttonName,
                style: kBodyText.copyWith(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
