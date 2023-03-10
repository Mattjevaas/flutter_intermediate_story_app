class AddStoryResponseModel {
  AddStoryResponseModel({
    required this.error,
    required this.message,
  });

  final bool error;
  final String message;

  factory AddStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      AddStoryResponseModel(
        error: json["error"],
        message: json["message"],
      );
}
