import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/request/story_request_model.dart';
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
    _setControllerListener();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  final List<ListStory> _listStory = [];
  late ResultState _state;

  final int _currentSize = 10;
  int _currentPage = 1;
  bool _hasReachedMax = false;
  bool _isScrollLoading = false;

  ResultState get state => _state;

  List<ListStory> get listStory => _listStory;

  ScrollController get scrollController => _scrollController;

  bool get isScrollLoading => _isScrollLoading;

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
    if (_listStory.isEmpty) {
      _state = ResultState.loading;
    } else {
      _isScrollLoading = true;
    }
    notifyListeners();

    final userData = await _authService.getUserData();

    if (userData != null) {
      try {
        final requestData = StoryRequestModel(
          page: _currentPage,
          size: _currentSize,
        );

        final res = await _apiService.getAllStory(userData.token, requestData);

        if (res.listStory.isNotEmpty) {
          _listStory.addAll(res.listStory);
          _state = ResultState.hasData;
        } else {
          if (_listStory.isEmpty) {
            _state = ResultState.noData;
          } else {
            _state = ResultState.hasData;
            _hasReachedMax = true;
          }
        }
      } catch (e) {
        _state = ResultState.error;
      }
    } else {
      _state = ResultState.noData;
    }

    if (_isScrollLoading) {
      _isScrollLoading = false;
    }
    notifyListeners();
  }

  Future<void> refreshData() async {
    _listStory.clear();
    _currentPage = 1;
    _hasReachedMax = false;
    await _getAllStory();
  }

  void _setControllerListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (!_hasReachedMax) {
          _currentPage++;
          _getAllStory();
        }
      }
    });
  }
}
