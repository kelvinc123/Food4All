import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food4all_app/core/auth/authentication-service.dart';
import 'package:food4all_app/screens/loading.dart';
import 'package:food4all_app/widgets/auth/authentication-wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import './frames.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default '_initialized' and '_error' state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set '_initialized' state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
      print("SUCCESS: Firebase initialized successfully.");
    } catch (e) {
      // Set '_error' state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
      print("FAILED: Firebase initialized unsuccessfully");
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Show error message if initialization failed
    // if (_error) {
    //   print("ERROR");
    // }

    if (!_initialized) {
      return Loading();
    } else {
      return MultiProvider(
          providers: [
            Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance),
            ),
            StreamProvider(
                create: (context) =>
                    context.read<AuthenticationService>().authStateChanges)
          ],
          child: MaterialApp(
            title: 'Food4All',
            theme: ThemeData(
              textTheme:
                  GoogleFonts.muktaTextTheme(Theme.of(context).textTheme),
              primarySwatch: Colors.green,
              accentColor: Colors.green[700],
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => AuthenticationWrapper(),
              'ForgotPassword': (context) => ForgotPassword(),
              'CreateNewAccount': (context) => CreateNewAccount(),
              'Frames': (context) => Frames(),
            },
          ));
    }
  }
}
