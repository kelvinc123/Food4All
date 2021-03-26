import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:food4all_app/screens/feed.dart';
import 'package:food4all_app/screens/screens.dart';
import '../../frames.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil('Feed', (Route<dynamic> route) => false);
      return Frames();
    }

    return LoginScreen();
  }
}
