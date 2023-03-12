// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_story_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailStoryResponseModel _$$_DetailStoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_DetailStoryResponseModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      listStory: json['story'] == null
          ? null
          : ListStory.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DetailStoryResponseModelToJson(
        _$_DetailStoryResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.listStory,
    };
