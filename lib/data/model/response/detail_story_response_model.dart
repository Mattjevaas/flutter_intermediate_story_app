import 'package:freezed_annotation/freezed_annotation.dart';

import 'list_story_model.dart';

part 'detail_story_response_model.freezed.dart';
part 'detail_story_response_model.g.dart';

@freezed
class DetailStoryResponseModel with _$DetailStoryResponseModel {
  const factory DetailStoryResponseModel({
    required bool error,
    required String message,
    @JsonKey(name: "story") required ListStory? listStory,
  }) = _DetailStoryResponseModel;

  factory DetailStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryResponseModelFromJson(json);
}
