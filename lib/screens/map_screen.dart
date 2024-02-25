import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';
import 'home_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const String routeName = '/map_screen';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng? _currentLocation;
  late LocationService _locationService;
  GoogleMapController? _mapController;
  Marker? _destinationMarker;
  Set<Polyline> _polylines = Set<Polyline>(); // Store the polylines
  String googleMapsApi = dotenv.get("GOOGLE_MAPS_API_KEY");

  @override
  void initState() {
    super.initState();
    _locationService = LocationService();

    _locationService.locationStream.listen((LatLng location) {
      setState(() {
        _currentLocation = location;
      });
      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(location));
      }
      if (_currentLocation != null && _destinationMarker != null) {
        getPolylinePoints();
      }
    });
  }

  @override
  void dispose() {
    _locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);          },
        ),
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // Remove shadow
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 15,
              ),
              onMapCreated: (controller) => _mapController = controller,
              onLongPress: _addMarker,
              markers: {
                if (_currentLocation != null)
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: _currentLocation!,
                  ),
                if (_destinationMarker != null) _destinationMarker!,
              },
              polylines: _polylines, // Draw polylines
            ),
    );
  }

  void _addMarker(LatLng position) {
    setState(() {
      _destinationMarker = Marker(
        markerId: MarkerId('destination'),
        position: position,
        icon: BitmapDescriptor.defaultMarker,
      );
    });
    if (_currentLocation != null) {
      getPolylinePoints(); // i am updating the polylines when i change the markers
    }
  }

  Future<void> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    if (_destinationMarker != null && _currentLocation != null) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapsApi,
        PointLatLng(
          _currentLocation!.latitude, //get the location of user
          _currentLocation!.longitude,
        ),
        PointLatLng(
          _destinationMarker!.position.latitude,
          _destinationMarker!.position.longitude, //get the destination location
        ),
      );
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(
            LatLng(
              point.latitude,
              point.longitude,
            ),
          );
        });
      } else {
        print(result.errorMessage ?? "Error occurred");
      }

      setState(() {
        _polylines.clear(); // Clear existing polylines
        _polylines.add(Polyline(
          polylineId: PolylineId(
            'poly',
          ),
          visible: true,
          points: polylineCoordinates,
          color: Colors.blue,
        ));
      });
    }
  }
}
