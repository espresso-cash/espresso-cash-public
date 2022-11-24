// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'get_swap_fee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetSwapFeeResponseDto _$GetSwapFeeResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _GetSwapFeeResponseDto.fromJson(json);
}

/// @nodoc
mixin _$GetSwapFeeResponseDto {
  int get feeInUsdc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetSwapFeeResponseDtoCopyWith<GetSwapFeeResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetSwapFeeResponseDtoCopyWith<$Res> {
  factory $GetSwapFeeResponseDtoCopyWith(GetSwapFeeResponseDto value,
          $Res Function(GetSwapFeeResponseDto) then) =
      _$GetSwapFeeResponseDtoCopyWithImpl<$Res>;
  $Res call({int feeInUsdc});
}

/// @nodoc
class _$GetSwapFeeResponseDtoCopyWithImpl<$Res>
    implements $GetSwapFeeResponseDtoCopyWith<$Res> {
  _$GetSwapFeeResponseDtoCopyWithImpl(this._value, this._then);

  final GetSwapFeeResponseDto _value;
  // ignore: unused_field
  final $Res Function(GetSwapFeeResponseDto) _then;

  @override
  $Res call({
    Object? feeInUsdc = freezed,
  }) {
    return _then(_value.copyWith(
      feeInUsdc: feeInUsdc == freezed
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_GetSwapFeeResponseDtoCopyWith<$Res>
    implements $GetSwapFeeResponseDtoCopyWith<$Res> {
  factory _$$_GetSwapFeeResponseDtoCopyWith(_$_GetSwapFeeResponseDto value,
          $Res Function(_$_GetSwapFeeResponseDto) then) =
      __$$_GetSwapFeeResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call({int feeInUsdc});
}

/// @nodoc
class __$$_GetSwapFeeResponseDtoCopyWithImpl<$Res>
    extends _$GetSwapFeeResponseDtoCopyWithImpl<$Res>
    implements _$$_GetSwapFeeResponseDtoCopyWith<$Res> {
  __$$_GetSwapFeeResponseDtoCopyWithImpl(_$_GetSwapFeeResponseDto _value,
      $Res Function(_$_GetSwapFeeResponseDto) _then)
      : super(_value, (v) => _then(v as _$_GetSwapFeeResponseDto));

  @override
  _$_GetSwapFeeResponseDto get _value =>
      super._value as _$_GetSwapFeeResponseDto;

  @override
  $Res call({
    Object? feeInUsdc = freezed,
  }) {
    return _then(_$_GetSwapFeeResponseDto(
      feeInUsdc: feeInUsdc == freezed
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetSwapFeeResponseDto implements _GetSwapFeeResponseDto {
  const _$_GetSwapFeeResponseDto({required this.feeInUsdc});

  factory _$_GetSwapFeeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_GetSwapFeeResponseDtoFromJson(json);

  @override
  final int feeInUsdc;

  @override
  String toString() {
    return 'GetSwapFeeResponseDto(feeInUsdc: $feeInUsdc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetSwapFeeResponseDto &&
            const DeepCollectionEquality().equals(other.feeInUsdc, feeInUsdc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(feeInUsdc));

  @JsonKey(ignore: true)
  @override
  _$$_GetSwapFeeResponseDtoCopyWith<_$_GetSwapFeeResponseDto> get copyWith =>
      __$$_GetSwapFeeResponseDtoCopyWithImpl<_$_GetSwapFeeResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetSwapFeeResponseDtoToJson(
      this,
    );
  }
}

abstract class _GetSwapFeeResponseDto implements GetSwapFeeResponseDto {
  const factory _GetSwapFeeResponseDto({required final int feeInUsdc}) =
      _$_GetSwapFeeResponseDto;

  factory _GetSwapFeeResponseDto.fromJson(Map<String, dynamic> json) =
      _$_GetSwapFeeResponseDto.fromJson;

  @override
  int get feeInUsdc;
  @override
  @JsonKey(ignore: true)
  _$$_GetSwapFeeResponseDtoCopyWith<_$_GetSwapFeeResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

GetSwapFeeRequestDto _$GetSwapFeeRequestDtoFromJson(Map<String, dynamic> json) {
  return _GetSwapFeeRequestDto.fromJson(json);
}

/// @nodoc
mixin _$GetSwapFeeRequestDto {
  JupiterRoute get route => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetSwapFeeRequestDtoCopyWith<GetSwapFeeRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetSwapFeeRequestDtoCopyWith<$Res> {
  factory $GetSwapFeeRequestDtoCopyWith(GetSwapFeeRequestDto value,
          $Res Function(GetSwapFeeRequestDto) then) =
      _$GetSwapFeeRequestDtoCopyWithImpl<$Res>;
  $Res call({JupiterRoute route});

  $JupiterRouteCopyWith<$Res> get route;
}

/// @nodoc
class _$GetSwapFeeRequestDtoCopyWithImpl<$Res>
    implements $GetSwapFeeRequestDtoCopyWith<$Res> {
  _$GetSwapFeeRequestDtoCopyWithImpl(this._value, this._then);

  final GetSwapFeeRequestDto _value;
  // ignore: unused_field
  final $Res Function(GetSwapFeeRequestDto) _then;

  @override
  $Res call({
    Object? route = freezed,
  }) {
    return _then(_value.copyWith(
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as JupiterRoute,
    ));
  }

  @override
  $JupiterRouteCopyWith<$Res> get route {
    return $JupiterRouteCopyWith<$Res>(_value.route, (value) {
      return _then(_value.copyWith(route: value));
    });
  }
}

/// @nodoc
abstract class _$$_GetSwapFeeRequestDtoCopyWith<$Res>
    implements $GetSwapFeeRequestDtoCopyWith<$Res> {
  factory _$$_GetSwapFeeRequestDtoCopyWith(_$_GetSwapFeeRequestDto value,
          $Res Function(_$_GetSwapFeeRequestDto) then) =
      __$$_GetSwapFeeRequestDtoCopyWithImpl<$Res>;
  @override
  $Res call({JupiterRoute route});

  @override
  $JupiterRouteCopyWith<$Res> get route;
}

/// @nodoc
class __$$_GetSwapFeeRequestDtoCopyWithImpl<$Res>
    extends _$GetSwapFeeRequestDtoCopyWithImpl<$Res>
    implements _$$_GetSwapFeeRequestDtoCopyWith<$Res> {
  __$$_GetSwapFeeRequestDtoCopyWithImpl(_$_GetSwapFeeRequestDto _value,
      $Res Function(_$_GetSwapFeeRequestDto) _then)
      : super(_value, (v) => _then(v as _$_GetSwapFeeRequestDto));

  @override
  _$_GetSwapFeeRequestDto get _value => super._value as _$_GetSwapFeeRequestDto;

  @override
  $Res call({
    Object? route = freezed,
  }) {
    return _then(_$_GetSwapFeeRequestDto(
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as JupiterRoute,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetSwapFeeRequestDto implements _GetSwapFeeRequestDto {
  const _$_GetSwapFeeRequestDto({required this.route});

  factory _$_GetSwapFeeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_GetSwapFeeRequestDtoFromJson(json);

  @override
  final JupiterRoute route;

  @override
  String toString() {
    return 'GetSwapFeeRequestDto(route: $route)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetSwapFeeRequestDto &&
            const DeepCollectionEquality().equals(other.route, route));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(route));

  @JsonKey(ignore: true)
  @override
  _$$_GetSwapFeeRequestDtoCopyWith<_$_GetSwapFeeRequestDto> get copyWith =>
      __$$_GetSwapFeeRequestDtoCopyWithImpl<_$_GetSwapFeeRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetSwapFeeRequestDtoToJson(
      this,
    );
  }
}

abstract class _GetSwapFeeRequestDto implements GetSwapFeeRequestDto {
  const factory _GetSwapFeeRequestDto({required final JupiterRoute route}) =
      _$_GetSwapFeeRequestDto;

  factory _GetSwapFeeRequestDto.fromJson(Map<String, dynamic> json) =
      _$_GetSwapFeeRequestDto.fromJson;

  @override
  JupiterRoute get route;
  @override
  @JsonKey(ignore: true)
  _$$_GetSwapFeeRequestDtoCopyWith<_$_GetSwapFeeRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}
