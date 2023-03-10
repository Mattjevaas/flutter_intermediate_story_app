import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/response/login_result_model.dart';

class AuthLocalDatasource {
  final Future<SharedPreferences> _prefs;

  AuthLocalDatasource({
    required Future<SharedPreferences> prefs,
  }) : _prefs = prefs;

  static const _authKey = "AUTH_KEY";

  Future<bool> saveAuthData(LoginResult loginData) async {
    final SharedPreferences prefs = await _prefs;
    final res = await prefs.setString(_authKey, json.encode(loginData));

    return res;
  }

  Future<LoginResult?> getAuthData() async {
    final SharedPreferences prefs = await _prefs;
    final res = prefs.getString(_authKey);

    if (res != null) {
      final loginData = LoginResult.fromJson(json.decode(res));
      return loginData;
    }

    return null;
  }

  Future<bool> deleteAuthData() async {
    final SharedPreferences prefs = await _prefs;
    final res = prefs.remove(_authKey);

    return res;
  }
}
