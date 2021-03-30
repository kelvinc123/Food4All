class User {
  String uid;
  String email;
  String password;
  String displayName;

  User({this.uid, this.email, this.displayName, this.password});

  Map<String, dynamic> createMap() {
    return {'uid': uid, 'email': email, 'displayName': displayName};
  }

  User.fromFirestore(Map<String, dynamic> firestoreMap)
      : uid = firestoreMap['uid'],
        email = firestoreMap['email'],
        displayName = firestoreMap['display_name'];
}
