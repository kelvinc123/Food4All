import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food4all_app/core/auth/authentication-service.dart';
import 'package:food4all_app/pallete.dart';
import '../../widgets/widgets.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/login_bg.png'),
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
              'Forgot Password',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Container(
                      width: size.width * 0.8,
                      child: Text(
                        'Enter the email where you would like password reset instructions sent.',
                        style: kBodyText,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                      label: 'Email',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      onPressed: () {
                        setState(() {
                          _loading = true;
                        });

                        context
                            .read<AuthenticationService>()
                            .sendPasswordResetEmail(
                                email: "sstevens88@gmail.com")
                            .then((msg) {
                          final snackBar = new SnackBar(
                            content: Text(msg),
                            backgroundColor: Colors.greenAccent[700],
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            _loading = false;
                          });
                        }).catchError((e) {
                          final snackBar = new SnackBar(
                            content: Text("${e.message} (code: ${e.code})"),
                            backgroundColor: Colors.red[500],
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            _loading = false;
                          });
                        });
                      },
                      buttonName: 'Send',
                      loading: _loading,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
