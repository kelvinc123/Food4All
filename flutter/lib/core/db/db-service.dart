import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/models.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User> getUser(String id) async {
    var snap = await _db.collection('users').doc(id).get();

    return User.fromMap(snap.data);
  }
}
