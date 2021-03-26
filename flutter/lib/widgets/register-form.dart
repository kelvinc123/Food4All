import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food4all_app/core/auth/authentication-service.dart';
import 'package:food4all_app/models/user.dart';
import 'widgets.dart';
import 'package:validators/validators.dart' as validators;
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerKey = GlobalKey<FormState>();
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _registerKey,
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
            Flexible(
              child: TextInputField(
                  label: "Confirm Password",
                  icon: FontAwesomeIcons.lock,
                  isPassword: true,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (String value) {
                    if (value.length < 8) {
                      return "Password must be at least 8 characters.";
                    } else if (value != user.password) {
                      return "Passwords must match.";
                    }
                    return null;
                  }),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                child: RoundedButton(
                  onPressed: () {
                    if (_registerKey.currentState.validate()) {
                      _registerKey.currentState.save();

                      context
                          .read<AuthenticationService>()
                          .register(email: user.email, password: user.password)
                          .then((uid) {
                        print("Created user $uid");
                        Navigator.pushNamed(context, "/");
                      }).catchError((e) {
                        final snackBar = new SnackBar(
                          content: Text("${e.message} (code: ${e.code})"),
                          backgroundColor: Colors.red[500],
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }
                  },
                  buttonName: "Register",
                ))
          ],
        ));
  }
}
