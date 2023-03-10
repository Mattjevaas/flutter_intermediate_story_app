import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/common/exception/custom_exception.dart';
import 'package:flutter_intermediate_story_app/data/model/request/login_request_model.dart';
import 'package:flutter_intermediate_story_app/service/api_service.dart';
import 'package:flutter_intermediate_story_app/service/auth_service.dart';
import 'package:go_router_flow/go_router_flow.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService _apiService;
  final AuthService _authService;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isHide = true;
  bool _isLoading = false;

  LoginProvider({
    required ApiService apiService,
    required AuthService authService,
  })  : _apiService = apiService,
        _authService = authService;

  bool get isHide => _isHide;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get emailController => _emailController;

  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onChangeObscure() {
    _isHide = !_isHide;
    notifyListeners();
  }

  Future<void> userLogin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final loginData = LoginRequestModel(
      email: _emailController.text,
      password: _passwordController.text,
    );

    try {
      String msg = "";
      final response = await _apiService.userLogin(loginData);

      if (response.message == "success") {
        final res = await _authService.userLogin(response.loginResult!);

        if (res) {
          msg = response.message;
          if (context.mounted) {
            context.go("/home");
          }
        } else {
          msg = "Error saving user data";
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(msg),
          ));
        }
      }
    } on CustomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }

    _isLoading = false;
    notifyListeners();
  }
}
