import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food4all_app/pallete.dart';
import 'package:food4all_app/widgets/widgets.dart';
import '../../widgets/widgets.dart';

class CreateNewAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/register_bg.png'),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: kWhite,
                ),
              ),
              title: Text(
                'Create Account',
                style: kBodyText,
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Flexible(
                    child: Padding(
                        padding: EdgeInsets.only(top: 36.0),
                        child: RegisterForm())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: kBodyText.copyWith(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Login',
                        style: kBodyText.copyWith(
                            fontSize: 18,
                            color: Colors.greenAccent[700],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
      ],
    );
  }
}
