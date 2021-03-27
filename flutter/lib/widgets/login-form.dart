import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food4all_app/core/auth/authentication-service.dart';
import 'package:food4all_app/models/user.dart';
import 'widgets.dart';
import 'package:validators/validators.dart' as validators;
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginKey = GlobalKey<FormState>();
  User user = User();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _loginKey,
        child: Column(
          children: <Widget>[
            Flexible(
              child: TextInputField(
                label: "Email",
                icon: FontAwesomeIcons.envelope,
                isEmail: true,
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                validator: (String value) {
                  if (!validators.isEmail(value)) {
                    return "Please enter a valid email.";
                  }
                  return null;
                },
                onChanged: (String value) => {user.email = value},
              ),
            ),
            Flexible(
              child: TextInputField(
                  label: "Password",
                  icon: FontAwesomeIcons.lock,
                  isPassword: true,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (String value) {
                    if (value.length < 8) {
                      return "Password must be at least 8 characters.";
                    }
                    return null;
                  },
                  onChanged: (String value) => {user.password = value}),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                child: RoundedButton(
                  onPressed: () {
                    if (_loginKey.currentState.validate()) {
                      setState(() {
                        _loading = true;
                      });
                      _loginKey.currentState.save();

                      context
                          .read<AuthenticationService>()
                          .signIn(
                              email: user.email.trim(), password: user.password)
                          .then((uid) {
                        print("Signed in user $uid");
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
                    }
                  },
                  buttonName: "Login",
                  loading: _loading,
                ))
          ],
        ));
  }
}
