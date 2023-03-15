import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/service/api_service.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../common/config/flavor_config.dart';
import '../common/enumeration/flavor_type.dart';
import '../common/enumeration/result_state_enum.dart';
import '../data/model/response/list_story_model.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService _apiService;
  final AuthService _authService;
  final String _storyId;

  DetailProvider({
    required ApiService apiService,
    required AuthService authService,
    required String storyId,
  })  : _apiService = apiService,
        _authService = authService,
        _storyId = storyId {
    _getStory();
  }

  final Set<Marker> markers = {};
  String _currAddress = "Location Unknown";
  late ListStory _listStory;
  late ResultState _state;

  ResultState get state => _state;

  ListStory get listStory => _listStory;

  Future<void> _getStory() async {
    _state = ResultState.loading;
    notifyListeners();

    final userData = await _authService.getUserData();

    if (userData != null) {
      try {
        final res = await _apiService.getStoryDetail(userData.token, _storyId);

        if (res.listStory != null) {
          _listStory = res.listStory!;
          _state = ResultState.hasData;
        } else {
          _state = ResultState.noData;
        }
      } catch (e) {
        _state = ResultState.error;
      }
    } else {
      _state = ResultState.noData;
    }
    if (FlavorConfig.instance.flavor == FlavorType.paid) {
      _getCurrAddress();
    }

    notifyListeners();
  }

  void _createMarker() {
    if (listStory.lat != null && listStory.lon != null) {
      final marker = Marker(
        markerId: const MarkerId("curr_position"),
        infoWindow: InfoWindow(title: _currAddress),
        position: LatLng(listStory.lat!, listStory.lon!),
      );

      markers.add(marker);
      notifyListeners();
    }
  }

  Future<void> _getCurrAddress() async {
    if (listStory.lat != null && listStory.lon != null) {
      final info = await geo.placemarkFromCoordinates(
        listStory.lat!,
        listStory.lon!,
      );

      if (info.isNotEmpty) {
        final place = info[0];
        _currAddress =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      }

      _createMarker();
    }
  }

  Future<void> refreshData() async {
    await _getStory();
  }
}
