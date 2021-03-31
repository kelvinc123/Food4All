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

  Future<List<Donor>> getDonors() async {
    final donors = await _db.collection('donors').get();

    List<Donor> donorObjs = [];

    for (final donor in donors.docs) {
      Donor donorObj = Donor.fromFirestore(donor.data());
      donorObj.uid = donor.id;
      donorObjs.add(donorObj);
    }

    return donorObjs;
  }

  Stream<QuerySnapshot> getDonorsStream() {
    return _db.collection('donors').snapshots(includeMetadataChanges: true);
  }
}
