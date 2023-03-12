import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_story_response_model.freezed.dart';
part 'add_story_response_model.g.dart';

@freezed
class AddStoryResponseModel with _$AddStoryResponseModel {
  const factory AddStoryResponseModel({
    required bool error,
    required String message,
  }) = _AddStoryResponseModel;

  factory AddStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddStoryResponseModelFromJson(json);
}
