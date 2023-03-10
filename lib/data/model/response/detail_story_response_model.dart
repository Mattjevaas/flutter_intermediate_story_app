import 'list_story_model.dart';

class DetailStoryResponseModel {
  DetailStoryResponseModel({
    required this.error,
    required this.message,
    required this.listStory,
  });

  final bool error;
  final String message;
  final ListStory? listStory;

  factory DetailStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      DetailStoryResponseModel(
        error: json["error"],
        message: json["message"],
        listStory: ListStory.fromJson(json["story"]),
      );
}
