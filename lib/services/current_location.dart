import 'dart:async';

import 'package:flutter_geocoder_alternative/flutter_geocoder_alternative.dart';
import 'package:geocode/geocode.dart';
//import 'package:geocoder2/geocoder2.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

late LocationData _currentPosition;
String _address = "";
late GoogleMapController mapController;
late Marker marker;
Location location = Location();
late CameraPosition _cameraPosition =
    CameraPosition(target: LatLng(0, 0), zoom: 10.0);

LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

Future<String> getLoc() async {

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return "null";
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return "null";
    }
  }
  String details = "";

  _currentPosition = await location.getLocation();
  DateTime now = DateTime.now();

  details += "";
  details += DateFormat('EEE d MMM kk:mm:ss ').format(now);

  _initialcameraposition =
      LatLng(_currentPosition.latitude!, _currentPosition.longitude!);

  _getAddress(_currentPosition.latitude!, _currentPosition.longitude!)
      .then((value) {
    _address = value;
  });
  details += "{}";
  details += _currentPosition.latitude.toString()+" , "+_currentPosition.longitude.toString();
  details += "{}";
  details += _address;

  return details;
}

Future _getAddress(double lat, double lang) async {
  Geocoder geocoder=Geocoder();
  return geocoder.getAddressFromLonLat(lat, lang);
  // final coordinates = Coordinates(lat, lang);
  // List<Address> add =
  // await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //return add;
}
