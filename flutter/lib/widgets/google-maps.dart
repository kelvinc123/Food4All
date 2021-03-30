import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Map<String, Marker> _markers = {};
  GoogleMapController mapController;
  CollectionReference donors = FirebaseFirestore.instance.collection('donors');

  final LatLng _center = const LatLng(47.6062, -122.3321);

  Future<void> _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // _addMarker() {
  //   var marker = Marker(
  //     position: mapController.cameraPosition.target,
  //     infoWindow: InfoWindow(),

  //   )
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: donors.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        return new GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 13),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
        );
      },
    );
  }
}
