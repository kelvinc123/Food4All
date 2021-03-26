import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> create() async {
  CollectionReference usersRef = firestore.collection("users");
  usersRef.add({
    'email': 'test@test123.com',
    'first_name': 'Test2',
    'last_name': 'Testerson',
    'full_name': 'Test2 Testerson',
    'is_donor': false,
    'user_name': 'test02'
  }).then((DocumentReference userDoc) {
    userDoc.get().then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        print("User \"${snapshot.data()['full_name']}\" created.");
      } else {
        print("No data found.");
      }
    });
  }).catchError((error) => print("Failed to add user: $error"));
  return;
}

Future<UserCredential> signInUser(String email, String password) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print("No user found for that email.");
    } else if (e.code == "wrong-password") {
      print("Wrong password provided for that user.");
    }
  } catch (e) {
    print(e);
  }
}

Future<void> setAuthStateListener() async {
  auth.authStateChanges().listen((User user) {
    if (user == null) {
      // TODO: Change app state
      print("User is currently signed out!");
    } else {
      // TODO: Change app state
      print("User is signed in!");
    }
  });
  print("Hit read");
}

Future<void> registerUser(String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    print(userCredential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print("The provided password is too weak.");
    } else if (e.code == "email-already-in-use") {
      print("An account already exists for that email.");
    }
  } catch (e) {
    print(e);
  }
  print("Hit update");
}

Future<void> delete() async {
  print("Hit update");
}
