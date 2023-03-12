import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/request/add_story_request_model.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router_flow/go_router_flow.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../common/config/flavor_config.dart';
import '../common/enumeration/flavor_type.dart';
import '../common/exception/custom_exception.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';

class AddStoryProvider extends ChangeNotifier {
  final ApiService _apiService;
  final AuthService _authService;

  final TextEditingController _descController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  AddStoryProvider({
    required ApiService apiService,
    required AuthService authService,
  })  : _apiService = apiService,
        _authService = authService {
    if (FlavorConfig.instance.flavor == FlavorType.paid) {
      _getCurrentPosition();
    }
  }

  XFile? _imageFile;
  bool _isLoading = false;
  LatLng? _currLatLon;

  @override
  void dispose() {
    _descController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  TextEditingController get descController => _descController;
  XFile? get imageFile => _imageFile;
  bool get isLoading => _isLoading;
  TextEditingController get addressController => _addressController;
  LatLng? get currLatLon => _currLatLon;

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      _imageFile = photo;
      notifyListeners();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    if (imageFile != null && _descController.text.isNotEmpty) {
      final storyData = AddStoryRequestModel(
        description: _descController.text,
        image: imageFile!,
        lat: _currLatLon?.latitude,
        lon: _currLatLon?.longitude,
      );

      final userData = await _authService.getUserData();

      if (userData != null) {
        try {
          final response =
              await _apiService.uploadImage(userData.token, storyData);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.message),
            ));
            context.pop();
          }
        } on CustomException catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
            ));
          }
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Silahkan lengkapi data terlebih dahulu"),
          ),
        );
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _getCurrentPosition() async {
    _addressController.text = "Loading...";

    final Location location = Location();
    late LocationData locationData;

    final state = await _getPermission(location);

    if (!state) return;

    locationData = await location.getLocation();
    final latLng = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );

    final info = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    if (info.isNotEmpty) {
      final place = info[0];
      _addressController.text =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    } else {
      _addressController.text = "Location not found ";
    }

    _currLatLon = latLng;
    notifyListeners();
  }

  Future<void> getPosition({required double lat, required double lon}) async {
    _addressController.text = "Loading...";

    final Location location = Location();
    final state = await _getPermission(location);

    if (!state) return;

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

  Future<bool> _getPermission(Location location) async {
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _addressController.text = "Please enable location service";
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _addressController.text = "Location permission needed";
        return false;
      }
    }

    return true;
  }
}
