// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoryResponseModel _$$_StoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_StoryResponseModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: (json['listStory'] as List<dynamic>)
          .map((e) => ListStory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_StoryResponseModelToJson(
        _$_StoryResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.listStory,
    };
