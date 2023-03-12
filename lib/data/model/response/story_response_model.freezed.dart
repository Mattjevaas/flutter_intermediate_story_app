// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoryResponseModel _$StoryResponseModelFromJson(Map<String, dynamic> json) {
  return _StoryResponseModel.fromJson(json);
}

/// @nodoc
mixin _$StoryResponseModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<ListStory> get listStory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryResponseModelCopyWith<StoryResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryResponseModelCopyWith<$Res> {
  factory $StoryResponseModelCopyWith(
          StoryResponseModel value, $Res Function(StoryResponseModel) then) =
      _$StoryResponseModelCopyWithImpl<$Res, StoryResponseModel>;
  @useResult
  $Res call({bool error, String message, List<ListStory> listStory});
}

/// @nodoc
class _$StoryResponseModelCopyWithImpl<$Res, $Val extends StoryResponseModel>
    implements $StoryResponseModelCopyWith<$Res> {
  _$StoryResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: null == listStory
          ? _value.listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<ListStory>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoryResponseModelCopyWith<$Res>
    implements $StoryResponseModelCopyWith<$Res> {
  factory _$$_StoryResponseModelCopyWith(_$_StoryResponseModel value,
          $Res Function(_$_StoryResponseModel) then) =
      __$$_StoryResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, List<ListStory> listStory});
}

/// @nodoc
class __$$_StoryResponseModelCopyWithImpl<$Res>
    extends _$StoryResponseModelCopyWithImpl<$Res, _$_StoryResponseModel>
    implements _$$_StoryResponseModelCopyWith<$Res> {
  __$$_StoryResponseModelCopyWithImpl(
      _$_StoryResponseModel _value, $Res Function(_$_StoryResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(_$_StoryResponseModel(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      listStory: null == listStory
          ? _value._listStory
          : listStory // ignore: cast_nullable_to_non_nullable
              as List<ListStory>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoryResponseModel implements _StoryResponseModel {
  const _$_StoryResponseModel(
      {required this.error,
      required this.message,
      required final List<ListStory> listStory})
      : _listStory = listStory;

  factory _$_StoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_StoryResponseModelFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  final List<ListStory> _listStory;
  @override
  List<ListStory> get listStory {
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listStory);
  }

  @override
  String toString() {
    return 'StoryResponseModel(error: $error, message: $message, listStory: $listStory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoryResponseModel &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._listStory, _listStory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message,
      const DeepCollectionEquality().hash(_listStory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoryResponseModelCopyWith<_$_StoryResponseModel> get copyWith =>
      __$$_StoryResponseModelCopyWithImpl<_$_StoryResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoryResponseModelToJson(
      this,
    );
  }
}

abstract class _StoryResponseModel implements StoryResponseModel {
  const factory _StoryResponseModel(
      {required final bool error,
      required final String message,
      required final List<ListStory> listStory}) = _$_StoryResponseModel;

  factory _StoryResponseModel.fromJson(Map<String, dynamic> json) =
      _$_StoryResponseModel.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  List<ListStory> get listStory;
  @override
  @JsonKey(ignore: true)
  _$$_StoryResponseModelCopyWith<_$_StoryResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
