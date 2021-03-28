import 'package:flutter/material.dart';
import 'package:food4all_app/core/auth/authentication-service.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _loading
            ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
            : OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  )),
                ),
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });

                  context
                      .read<AuthenticationService>()
                      .signInWithGoogle()
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
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/google_logo.png'),
                        height: 35.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Sign in with Google",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
              ));
  }
}
