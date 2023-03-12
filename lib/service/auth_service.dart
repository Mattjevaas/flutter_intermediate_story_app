import 'package:flutter_intermediate_story_app/data/locale/auth_local_datasource.dart';

import '../data/model/response/login_result_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  AuthLocalDatasource? _locale;

  factory AuthService({required AuthLocalDatasource locale}) {
    _instance._locale = locale;
    return _instance;
  }
  AuthService._internal();

  bool _isLogin = false;

  bool get isLogin => _isLogin;
  static AuthService get instance => _instance;

  Future<bool> userLogin(LoginResult loginData) async {
    final res = await _locale!.saveAuthData(loginData);

    _isLogin = res;
    return res;
  }

  Future<bool> userLogout() async {
    final res = await _locale!.deleteAuthData();

    if (res) {
      _isLogin = false;
    } else {
      _isLogin = true;
    }

    return res;
  }

  Future<bool> isUserLogin() async {
    final res = await _locale!.getAuthData();

    if (res != null) {
      _isLogin = true;
      return true;
    }

    _isLogin = false;
    return false;
  }

  Future<LoginResult?> getUserData() async {
    final res = await _locale!.getAuthData();
    return res;
  }
}
