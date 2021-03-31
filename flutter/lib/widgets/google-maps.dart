import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food4all_app/core/db/db-service.dart';
import 'package:food4all_app/models/donor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Set<Marker> _markers = new Set();
  final Location location = new Location();

  final LatLng _center = const LatLng(47.6062, -122.3321);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: DatabaseService().getDonorsStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          for (final document in snapshot.data.docs) {
            Donor donor = Donor.fromFirestore(document.data());
            donor.uid = document.id;
            GeoPoint coords = donor.locationMap['coordinates'];

            final marker = Marker(
                markerId: MarkerId(donor.uid),
                position: LatLng(coords.latitude, coords.longitude),
                infoWindow: InfoWindow(
                    title: donor.name,
                    snippet: "Available takeouts: ${donor.takeoutCount}"),
                onTap: () => {
                      showBottomSheet(
                          context: context,
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(18.0))),
                          builder: (builder) {
                            return Container(
                              padding: EdgeInsets.all(12),
                              height: 160,
                              child: Center(
                                  child: new Text(
                                donor.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 28),
                              )),
                            );
                          })
                    });

            _markers.add(marker);
          }

          return Scaffold(
              body: Stack(
            children: [
              new GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _center, zoom: 14),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapToolbarEnabled: false,
                markers: _markers,
                // compassEnabled: true,
              )
            ],
          ));
        });
  }
}
