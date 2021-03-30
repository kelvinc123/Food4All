import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/models.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(User user) async {
    CollectionReference usersRef = _db.collection('users');
    try {
      usersRef.doc(user.uid).set(user.createMap());
    } catch (e) {
      return e.message;
    }
  }

  Future<User> getUser(String id) async {
    var snap = await _db.collection('users').doc(id).get();
  }

  // Stream<List<Donor>> getDonorLocations() {
  //   return _db.collection('donors').snapshots().map((snapshot) => snapshot.docs
  //       .map((document) => Donor.fromFirestore(document.data))
  //       .toList());
  // }
}
