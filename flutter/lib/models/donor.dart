class Donor {
  String uid;
  String name;
  Map<String, dynamic> locationMap;
  List availableTakeouts;
  int takeoutCount;

  Donor(
      {this.uid,
      this.name,
      this.locationMap,
      this.availableTakeouts,
      this.takeoutCount});

  Map<String, dynamic> createMap() {
    return {
      'uid': uid,
      'name': name,
      'locationMap': locationMap,
      'availableTakeouts': availableTakeouts,
      'takeoutCount': takeoutCount
    };
  }

  Donor.fromFirestore(Map<String, dynamic> firestoreMap)
      : name = firestoreMap['name'],
        locationMap = firestoreMap['location_map'],
        availableTakeouts = firestoreMap['available_takeouts'],
        takeoutCount = firestoreMap['takeout_count'];
}
