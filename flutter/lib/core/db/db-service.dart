import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/models.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(User user) {
    CollectionReference usersRef = _db.collection('users');
    return usersRef.add(user.createMap());
  }

  Future<User> getUser(String id) async {
    var snap = await _db.collection('users').doc(id).get();
  }
}
