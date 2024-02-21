import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  final Location _locationController = Location();
  final StreamController<LatLng> _locationUpdateController = StreamController<LatLng>.broadcast();

  Stream<LatLng> get locationStream => _locationUpdateController.stream;

  LocationService() {
    _init();
  }

  void _init() async {
    bool serviceEnabled = await _locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
      if (!serviceEnabled) return;
    }

    var permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        _locationUpdateController.add(LatLng(currentLocation.latitude!, currentLocation.longitude!));
      }
    });
  }

  void dispose() {
    _locationUpdateController.close();
  }
}
