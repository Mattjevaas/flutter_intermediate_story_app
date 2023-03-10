import 'package:flutter/material.dart';
import 'package:flutter_intermediate_story_app/data/model/request/register_request_model.dart';
import 'package:flutter_intermediate_story_app/service/api_service.dart';
import 'package:go_router_flow/go_router_flow.dart';

import '../common/exception/custom_exception.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService _apiService;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isHide = true;
  bool _isLoading = false;

  RegisterProvider({
    required ApiService apiService,
  }) : _apiService = apiService;

  bool get isHide => _isHide;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get usernameController => _usernameController;

  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void onChangeObscure() {
    _isHide = !_isHide;
    notifyListeners();
  }

  Future<void> userRegister(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final registerData = RegisterRequestModel(
      email: _emailController.text,
      name: _usernameController.text,
      password: _passwordController.text,
    );

    try {
      final response = await _apiService.userRegister(registerData);

      if (context.mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.message),
        ));
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
