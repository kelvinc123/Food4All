class Donor {
  String uid;
  String name;
  Map<String, dynamic> locationMap;
  List availableTakeouts;
  int takeoutCount;
  String photoUrl;

  Donor(
      {this.uid,
      this.name,
      this.locationMap,
      this.availableTakeouts,
      this.takeoutCount,
      this.photoUrl});

  Map<String, dynamic> createMap() {
    return {
      'uid': uid,
      'name': name,
      'locationMap': locationMap,
      'availableTakeouts': availableTakeouts,
      'takeoutCount': takeoutCount,
      'photoUrl': photoUrl
    };
  }

  Donor.fromFirestore(Map<String, dynamic> firestoreMap)
      : name = firestoreMap['name'],
        locationMap = firestoreMap['location_map'],
        availableTakeouts = firestoreMap['available_takeouts'],
        takeoutCount = firestoreMap['takeout_count'],
        photoUrl = firestoreMap['photoUrl'];
}
