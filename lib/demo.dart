import 'dart:async';
import 'dart:developer';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map

  List mapData = [
    {
      'current': [21.2117513, 72.8854019],
      'destination': [21.2132506, 72.8784436]
    },
    {
      'current': [21.2324191, 72.8955507],
      'destination': [21.2407365, 72.9252453]
    },
  ];
  int numDeltas = 50; //number of delta to devide total distance
  int delay = 50; //milliseconds of delay to pass each delta

  // var position; //position variable while moving marker

  @override
  void initState() {
    // position = [loc1.latitude, loc1.longitude]; //initial position of moving marker
    addMarkers();
    super.initState();
  }

  addMarkers() async {
    mapData.forEach((element) {
      log("element['current'][0]--------------> ${element['current'][0]}");
      log("element['current'][1]--------------> ${element['current'][1]}");

      markers.add(Marker(
          markerId: MarkerId('tyht'),
          position: LatLng(element['current'][0], element['current'][1]),
          icon: BitmapDescriptor.defaultMarker));
    });
    // markers.add(Marker(markerId: MarkerId(loc1.toString()), position: loc1, icon: BitmapDescriptor.defaultMarker));
    log("Marker--------------> ${markers}");

    setState(() {
      //refresh UI
    });
  }

  transition(result, int index, positions) {
    var i = 0;
    double? deltaLat;
    double? deltaLng;
    var position = positions;
    deltaLat = (result[0] - position[0]) / numDeltas;
    deltaLng = (result[1] - position[1]) / numDeltas;
    moveMarker(i, deltaLat, deltaLng, position);
  }

  moveMarker(int i, double? deltaLat, double? deltaLng, List position) {
    position[0] += deltaLat;
    position[1] += deltaLng;
    var latlng = LatLng(position[0], position[1]);
    markers.add(Marker(
      markerId: MarkerId("movingmarker"),
      position: latlng,
      icon: BitmapDescriptor.defaultMarker,
    ));

    setState(() {
      //refresh UI
    });

    if (i != numDeltas) {
      i++;
      Future.delayed(Duration(milliseconds: delay), () {
        moveMarker(i, deltaLat, deltaLng, position);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Move Marker Position on Google Map"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("Move"),
          onPressed: () {
            var result = [27.661838, 85.308543];
            //latitude and longitude of new position

            transition(mapData[0]['destination'], 0, mapData[0]['current']);
            //start moving marker
          },
        ),
        body: GoogleMap(
          //Map widget from google_maps_flutter package
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          initialCameraPosition: CameraPosition(
            //innital position in map
            target: LatLng(21.2117513, 72.8854019), //initial position
            zoom: 14.0, //initial zoom level
          ),
          markers: markers, //markers to show on map
          mapType: MapType.normal, //map type
          onMapCreated: (controller) {
            //method called when map is created
            setState(() {
              mapController = controller;
            });
          },
        ));
  }
}
