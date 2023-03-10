class RegisterResponseModel {
  RegisterResponseModel({
    required this.error,
    required this.message,
  });

  final bool error;
  final String message;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
