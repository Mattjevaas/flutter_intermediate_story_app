// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_story_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddStoryResponseModel _$AddStoryResponseModelFromJson(
    Map<String, dynamic> json) {
  return _AddStoryResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AddStoryResponseModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddStoryResponseModelCopyWith<AddStoryResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddStoryResponseModelCopyWith<$Res> {
  factory $AddStoryResponseModelCopyWith(AddStoryResponseModel value,
          $Res Function(AddStoryResponseModel) then) =
      _$AddStoryResponseModelCopyWithImpl<$Res, AddStoryResponseModel>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$AddStoryResponseModelCopyWithImpl<$Res,
        $Val extends AddStoryResponseModel>
    implements $AddStoryResponseModelCopyWith<$Res> {
  _$AddStoryResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddStoryResponseModelCopyWith<$Res>
    implements $AddStoryResponseModelCopyWith<$Res> {
  factory _$$_AddStoryResponseModelCopyWith(_$_AddStoryResponseModel value,
          $Res Function(_$_AddStoryResponseModel) then) =
      __$$_AddStoryResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$_AddStoryResponseModelCopyWithImpl<$Res>
    extends _$AddStoryResponseModelCopyWithImpl<$Res, _$_AddStoryResponseModel>
    implements _$$_AddStoryResponseModelCopyWith<$Res> {
  __$$_AddStoryResponseModelCopyWithImpl(_$_AddStoryResponseModel _value,
      $Res Function(_$_AddStoryResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_$_AddStoryResponseModel(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddStoryResponseModel implements _AddStoryResponseModel {
  const _$_AddStoryResponseModel({required this.error, required this.message});

  factory _$_AddStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_AddStoryResponseModelFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString() {
    return 'AddStoryResponseModel(error: $error, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddStoryResponseModel &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddStoryResponseModelCopyWith<_$_AddStoryResponseModel> get copyWith =>
      __$$_AddStoryResponseModelCopyWithImpl<_$_AddStoryResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddStoryResponseModelToJson(
      this,
    );
  }
}

abstract class _AddStoryResponseModel implements AddStoryResponseModel {
  const factory _AddStoryResponseModel(
      {required final bool error,
      required final String message}) = _$_AddStoryResponseModel;

  factory _AddStoryResponseModel.fromJson(Map<String, dynamic> json) =
      _$_AddStoryResponseModel.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_AddStoryResponseModelCopyWith<_$_AddStoryResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
