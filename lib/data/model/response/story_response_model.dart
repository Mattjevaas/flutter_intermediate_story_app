import 'list_story_model.dart';

class StoryResponseModel {
  StoryResponseModel({
    required this.error,
    required this.message,
    required this.listStory,
  });

  final bool error;
  final String message;
  final List<ListStory> listStory;

  factory StoryResponseModel.fromJson(Map<String, dynamic> json) =>
      StoryResponseModel(
        error: json["error"],
        message: json["message"],
        listStory: List<ListStory>.from(
            json["listStory"].map((x) => ListStory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };
}
