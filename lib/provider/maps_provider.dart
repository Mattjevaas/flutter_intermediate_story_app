import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsProvider extends ChangeNotifier {
  final double _startLat;
  final double _startLon;

  MapsProvider({
    required double startLat,
    required double startLon,
  })  : _startLat = startLat,
        _startLon = startLon {
    _createInitialMarker();
    _getPosition(lat: _startLat, lon: _startLon);
  }

  final TextEditingController _addressController = TextEditingController();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  LatLng? _currLatLon;

  @override
  void dispose() {
    _addressController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Set<Marker> get markers => _markers;
  TextEditingController get addressController => _addressController;
  LatLng? get currLatLon => _currLatLon;

  set mapController(GoogleMapController value) {
    _mapController = value;
  }

  void _createInitialMarker() {
    final marker = Marker(
      markerId: const MarkerId("curr_position"),
      position: LatLng(_startLat, _startLon),
    );

    _markers.add(marker);
    notifyListeners();
  }

  void setNewMarker({required double lat, required double lon}) async {
    _markers.clear();
    final marker = Marker(
      markerId: const MarkerId("curr_position"),
      position: LatLng(lat, lon),
    );

    _markers.add(marker);
    notifyListeners();

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lon), 15),
    );

    await _getPosition(lat: lat, lon: lon);
  }

  Future<void> _getPosition({
    required double lat,
    required double lon,
  }) async {
    _addressController.text = "Loading...";

    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _addressController.text = "Please enable location service";
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _addressController.text = "Location permission needed";
        return;
      }
    }

    final info = await geo.placemarkFromCoordinates(
      lat,
      lon,
    );

    if (info.isNotEmpty) {
      final place = info[0];
      _addressController.text =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    } else {
      _addressController.text = "Location not found ";
    }

    _currLatLon = LatLng(lat, lon);
    notifyListeners();
  }
}
