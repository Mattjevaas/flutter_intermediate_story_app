import 'login_result_model.dart';

class LoginResponseModel {
  LoginResponseModel({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  final bool error;
  final String message;
  final LoginResult? loginResult;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        error: json["error"],
        message: json["message"],
        loginResult: json["loginResult"] != null
            ? LoginResult.fromJson(json["loginResult"])
            : null,
      );
}
