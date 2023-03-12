import 'package:freezed_annotation/freezed_annotation.dart';

import 'list_story_model.dart';

part 'story_response_model.freezed.dart';
part 'story_response_model.g.dart';

@freezed
class StoryResponseModel with _$StoryResponseModel {
  const factory StoryResponseModel({
    required bool error,
    required String message,
    required List<ListStory> listStory,
  }) = _StoryResponseModel;

  factory StoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseModelFromJson(json);
}
