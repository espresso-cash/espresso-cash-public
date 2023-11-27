// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scalex.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScalexSignResponseDto _$ScalexSignResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _ScalexSignResponseDto.fromJson(json);
}

/// @nodoc
mixin _$ScalexSignResponseDto {
  String get timestamp => throw _privateConstructorUsedError;
  String get signature => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScalexSignResponseDtoCopyWith<ScalexSignResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScalexSignResponseDtoCopyWith<$Res> {
  factory $ScalexSignResponseDtoCopyWith(ScalexSignResponseDto value,
          $Res Function(ScalexSignResponseDto) then) =
      _$ScalexSignResponseDtoCopyWithImpl<$Res, ScalexSignResponseDto>;
  @useResult
  $Res call({String timestamp, String signature});
}

/// @nodoc
class _$ScalexSignResponseDtoCopyWithImpl<$Res,
        $Val extends ScalexSignResponseDto>
    implements $ScalexSignResponseDtoCopyWith<$Res> {
  _$ScalexSignResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? signature = null,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScalexSignResponseDtoCopyWith<$Res>
    implements $ScalexSignResponseDtoCopyWith<$Res> {
  factory _$$_ScalexSignResponseDtoCopyWith(_$_ScalexSignResponseDto value,
          $Res Function(_$_ScalexSignResponseDto) then) =
      __$$_ScalexSignResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String timestamp, String signature});
}

/// @nodoc
class __$$_ScalexSignResponseDtoCopyWithImpl<$Res>
    extends _$ScalexSignResponseDtoCopyWithImpl<$Res, _$_ScalexSignResponseDto>
    implements _$$_ScalexSignResponseDtoCopyWith<$Res> {
  __$$_ScalexSignResponseDtoCopyWithImpl(_$_ScalexSignResponseDto _value,
      $Res Function(_$_ScalexSignResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? signature = null,
  }) {
    return _then(_$_ScalexSignResponseDto(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScalexSignResponseDto implements _ScalexSignResponseDto {
  const _$_ScalexSignResponseDto(
      {required this.timestamp, required this.signature});

  factory _$_ScalexSignResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_ScalexSignResponseDtoFromJson(json);

  @override
  final String timestamp;
  @override
  final String signature;

  @override
  String toString() {
    return 'ScalexSignResponseDto(timestamp: $timestamp, signature: $signature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScalexSignResponseDto &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.signature, signature) ||
                other.signature == signature));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, signature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScalexSignResponseDtoCopyWith<_$_ScalexSignResponseDto> get copyWith =>
      __$$_ScalexSignResponseDtoCopyWithImpl<_$_ScalexSignResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScalexSignResponseDtoToJson(
      this,
    );
  }
}

abstract class _ScalexSignResponseDto implements ScalexSignResponseDto {
  const factory _ScalexSignResponseDto(
      {required final String timestamp,
      required final String signature}) = _$_ScalexSignResponseDto;

  factory _ScalexSignResponseDto.fromJson(Map<String, dynamic> json) =
      _$_ScalexSignResponseDto.fromJson;

  @override
  String get timestamp;
  @override
  String get signature;
  @override
  @JsonKey(ignore: true)
  _$$_ScalexSignResponseDtoCopyWith<_$_ScalexSignResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

ScalexSignRequestDto _$ScalexSignRequestDtoFromJson(Map<String, dynamic> json) {
  return _ScalexSignRequestDto.fromJson(json);
}

/// @nodoc
mixin _$ScalexSignRequestDto {
  String get data => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScalexSignRequestDtoCopyWith<ScalexSignRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScalexSignRequestDtoCopyWith<$Res> {
  factory $ScalexSignRequestDtoCopyWith(ScalexSignRequestDto value,
          $Res Function(ScalexSignRequestDto) then) =
      _$ScalexSignRequestDtoCopyWithImpl<$Res, ScalexSignRequestDto>;
  @useResult
  $Res call({String data, String path});
}

/// @nodoc
class _$ScalexSignRequestDtoCopyWithImpl<$Res,
        $Val extends ScalexSignRequestDto>
    implements $ScalexSignRequestDtoCopyWith<$Res> {
  _$ScalexSignRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? path = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ScalexSignRequestDtoCopyWith<$Res>
    implements $ScalexSignRequestDtoCopyWith<$Res> {
  factory _$$_ScalexSignRequestDtoCopyWith(_$_ScalexSignRequestDto value,
          $Res Function(_$_ScalexSignRequestDto) then) =
      __$$_ScalexSignRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String data, String path});
}

/// @nodoc
class __$$_ScalexSignRequestDtoCopyWithImpl<$Res>
    extends _$ScalexSignRequestDtoCopyWithImpl<$Res, _$_ScalexSignRequestDto>
    implements _$$_ScalexSignRequestDtoCopyWith<$Res> {
  __$$_ScalexSignRequestDtoCopyWithImpl(_$_ScalexSignRequestDto _value,
      $Res Function(_$_ScalexSignRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? path = null,
  }) {
    return _then(_$_ScalexSignRequestDto(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScalexSignRequestDto implements _ScalexSignRequestDto {
  const _$_ScalexSignRequestDto({required this.data, required this.path});

  factory _$_ScalexSignRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_ScalexSignRequestDtoFromJson(json);

  @override
  final String data;
  @override
  final String path;

  @override
  String toString() {
    return 'ScalexSignRequestDto(data: $data, path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ScalexSignRequestDto &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ScalexSignRequestDtoCopyWith<_$_ScalexSignRequestDto> get copyWith =>
      __$$_ScalexSignRequestDtoCopyWithImpl<_$_ScalexSignRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScalexSignRequestDtoToJson(
      this,
    );
  }
}

abstract class _ScalexSignRequestDto implements ScalexSignRequestDto {
  const factory _ScalexSignRequestDto(
      {required final String data,
      required final String path}) = _$_ScalexSignRequestDto;

  factory _ScalexSignRequestDto.fromJson(Map<String, dynamic> json) =
      _$_ScalexSignRequestDto.fromJson;

  @override
  String get data;
  @override
  String get path;
  @override
  @JsonKey(ignore: true)
  _$$_ScalexSignRequestDtoCopyWith<_$_ScalexSignRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}
