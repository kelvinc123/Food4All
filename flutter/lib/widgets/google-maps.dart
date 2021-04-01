import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4all_app/core/db/db-service.dart';
import 'package:food4all_app/models/donor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'widgets.dart';

class GoogleMapWidget extends StatefulWidget {
  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Set<Marker> _markers = HashSet<Marker>();
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

          _markers.clear();

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
                            return Stack(
                              children: [
                                Positioned(
                                    top: 4.0,
                                    right: 4.0,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      tooltip: "Close",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      visualDensity: VisualDensity.compact,
                                      splashRadius: 12.0,
                                    )),
                                Container(
                                  padding: EdgeInsets.all(12.0),
                                  height: 160,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 24.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 14.0),
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.greenAccent[700],
                                                    radius: 33.0,
                                                    child: CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:
                                                            NetworkImage(donor
                                                                .photoUrl))),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      donor.name,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 24,
                                                          height: 0.8),
                                                    ),
                                                    Text(
                                                      donor.locationMap[
                                                          'address_full'],
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 12.0),
                                            child: RoundedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  _showDialog(
                                                      context, donor.name);
                                                  document.reference.update({
                                                    'takeout_count':
                                                        donor.takeoutCount - 1
                                                  });
                                                },
                                                buttonName:
                                                    "${donor.takeoutCount} takeouts available"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
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

  _showDialog(BuildContext context, String donorName) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(
                "Takeout Accepted!",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              content: new Text(
                  "Thank you for accepting a takeout from $donorName."),
              actions: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
