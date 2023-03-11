import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/service/api_service.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

    _createMarker();
    notifyListeners();
  }

  void _createMarker() {
    if (listStory.lat != null && listStory.lon != null) {
      final marker = Marker(
        markerId: const MarkerId("curr_position"),
        position: LatLng(listStory.lat!, listStory.lon!),
      );

      markers.add(marker);
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await _getStory();
  }
}
