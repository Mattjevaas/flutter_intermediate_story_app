import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/service/api_service.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:go_router_flow/go_router_flow.dart';

import '../common/enumeration/result_state_enum.dart';
import '../data/model/response/list_story_model.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _apiService;
  final AuthService _authService;

  HomeProvider({
    required ApiService apiService,
    required AuthService authService,
  })  : _apiService = apiService,
        _authService = authService {
    _getAllStory();
  }

  final List<ListStory> _listStory = [];
  late ResultState _state;

  ResultState get state => _state;

  List<ListStory> get listStory => _listStory;

  Future<void> userLogout(BuildContext context) async {
    final res = await _authService.userLogout();

    if (res) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Logout berhasil")),
        );
        context.go("/login");
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Logout gagal")),
        );
      }
    }
  }

  Future<void> _getAllStory() async {
    _state = ResultState.loading;
    notifyListeners();

    final userData = await _authService.getUserData();

    if (userData != null) {
      try {
        final res = await _apiService.getAllStory(userData.token);

        if (res.listStory.isNotEmpty) {
          _listStory.clear();
          _listStory.addAll(res.listStory);
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

    notifyListeners();
  }

  Future<void> refreshData() async {
    await _getAllStory();
  }
}
