class User {
  String email;
  String password;
  String displayName;

  User({this.email, this.displayName, this.password});

  Map<String, dynamic> createMap() {
    return {'email': email, 'display_name': displayName};
  }

  User.fromFirestore(Map<String, dynamic> firestoreMap)
      : email = firestoreMap['email'],
        displayName = firestoreMap['display_name'];
}
