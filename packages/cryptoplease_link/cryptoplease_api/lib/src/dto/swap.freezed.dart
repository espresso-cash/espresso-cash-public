// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'swap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SwapResponseDto _$SwapResponseDtoFromJson(Map<String, dynamic> json) {
  return _SwapResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SwapResponseDto {
  String get swapTransaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapResponseDtoCopyWith<SwapResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapResponseDtoCopyWith<$Res> {
  factory $SwapResponseDtoCopyWith(
          SwapResponseDto value, $Res Function(SwapResponseDto) then) =
      _$SwapResponseDtoCopyWithImpl<$Res>;
  $Res call({String swapTransaction});
}

/// @nodoc
class _$SwapResponseDtoCopyWithImpl<$Res>
    implements $SwapResponseDtoCopyWith<$Res> {
  _$SwapResponseDtoCopyWithImpl(this._value, this._then);

  final SwapResponseDto _value;
  // ignore: unused_field
  final $Res Function(SwapResponseDto) _then;

  @override
  $Res call({
    Object? swapTransaction = freezed,
  }) {
    return _then(_value.copyWith(
      swapTransaction: swapTransaction == freezed
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SwapResponseDtoCopyWith<$Res>
    implements $SwapResponseDtoCopyWith<$Res> {
  factory _$$_SwapResponseDtoCopyWith(
          _$_SwapResponseDto value, $Res Function(_$_SwapResponseDto) then) =
      __$$_SwapResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call({String swapTransaction});
}

/// @nodoc
class __$$_SwapResponseDtoCopyWithImpl<$Res>
    extends _$SwapResponseDtoCopyWithImpl<$Res>
    implements _$$_SwapResponseDtoCopyWith<$Res> {
  __$$_SwapResponseDtoCopyWithImpl(
      _$_SwapResponseDto _value, $Res Function(_$_SwapResponseDto) _then)
      : super(_value, (v) => _then(v as _$_SwapResponseDto));

  @override
  _$_SwapResponseDto get _value => super._value as _$_SwapResponseDto;

  @override
  $Res call({
    Object? swapTransaction = freezed,
  }) {
    return _then(_$_SwapResponseDto(
      swapTransaction: swapTransaction == freezed
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapResponseDto implements _SwapResponseDto {
  const _$_SwapResponseDto({required this.swapTransaction});

  factory _$_SwapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapResponseDtoFromJson(json);

  @override
  final String swapTransaction;

  @override
  String toString() {
    return 'SwapResponseDto(swapTransaction: $swapTransaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapResponseDto &&
            const DeepCollectionEquality()
                .equals(other.swapTransaction, swapTransaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(swapTransaction));

  @JsonKey(ignore: true)
  @override
  _$$_SwapResponseDtoCopyWith<_$_SwapResponseDto> get copyWith =>
      __$$_SwapResponseDtoCopyWithImpl<_$_SwapResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapResponseDtoToJson(
      this,
    );
  }
}

abstract class _SwapResponseDto implements SwapResponseDto {
  const factory _SwapResponseDto({required final String swapTransaction}) =
      _$_SwapResponseDto;

  factory _SwapResponseDto.fromJson(Map<String, dynamic> json) =
      _$_SwapResponseDto.fromJson;

  @override
  String get swapTransaction;
  @override
  @JsonKey(ignore: true)
  _$$_SwapResponseDtoCopyWith<_$_SwapResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

SwapRequestDto _$SwapRequestDtoFromJson(Map<String, dynamic> json) {
  return _SwapRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SwapRequestDto {
  String get userPublicKey => throw _privateConstructorUsedError;
  JupiterRoute get route => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapRequestDtoCopyWith<SwapRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapRequestDtoCopyWith<$Res> {
  factory $SwapRequestDtoCopyWith(
          SwapRequestDto value, $Res Function(SwapRequestDto) then) =
      _$SwapRequestDtoCopyWithImpl<$Res>;
  $Res call({String userPublicKey, JupiterRoute route});

  $JupiterRouteCopyWith<$Res> get route;
}

/// @nodoc
class _$SwapRequestDtoCopyWithImpl<$Res>
    implements $SwapRequestDtoCopyWith<$Res> {
  _$SwapRequestDtoCopyWithImpl(this._value, this._then);

  final SwapRequestDto _value;
  // ignore: unused_field
  final $Res Function(SwapRequestDto) _then;

  @override
  $Res call({
    Object? userPublicKey = freezed,
    Object? route = freezed,
  }) {
    return _then(_value.copyWith(
      userPublicKey: userPublicKey == freezed
          ? _value.userPublicKey
          : userPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$_SwapRequestDtoCopyWith<$Res>
    implements $SwapRequestDtoCopyWith<$Res> {
  factory _$$_SwapRequestDtoCopyWith(
          _$_SwapRequestDto value, $Res Function(_$_SwapRequestDto) then) =
      __$$_SwapRequestDtoCopyWithImpl<$Res>;
  @override
  $Res call({String userPublicKey, JupiterRoute route});

  @override
  $JupiterRouteCopyWith<$Res> get route;
}

/// @nodoc
class __$$_SwapRequestDtoCopyWithImpl<$Res>
    extends _$SwapRequestDtoCopyWithImpl<$Res>
    implements _$$_SwapRequestDtoCopyWith<$Res> {
  __$$_SwapRequestDtoCopyWithImpl(
      _$_SwapRequestDto _value, $Res Function(_$_SwapRequestDto) _then)
      : super(_value, (v) => _then(v as _$_SwapRequestDto));

  @override
  _$_SwapRequestDto get _value => super._value as _$_SwapRequestDto;

  @override
  $Res call({
    Object? userPublicKey = freezed,
    Object? route = freezed,
  }) {
    return _then(_$_SwapRequestDto(
      userPublicKey: userPublicKey == freezed
          ? _value.userPublicKey
          : userPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      route: route == freezed
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as JupiterRoute,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapRequestDto implements _SwapRequestDto {
  const _$_SwapRequestDto({required this.userPublicKey, required this.route});

  factory _$_SwapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapRequestDtoFromJson(json);

  @override
  final String userPublicKey;
  @override
  final JupiterRoute route;

  @override
  String toString() {
    return 'SwapRequestDto(userPublicKey: $userPublicKey, route: $route)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapRequestDto &&
            const DeepCollectionEquality()
                .equals(other.userPublicKey, userPublicKey) &&
            const DeepCollectionEquality().equals(other.route, route));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userPublicKey),
      const DeepCollectionEquality().hash(route));

  @JsonKey(ignore: true)
  @override
  _$$_SwapRequestDtoCopyWith<_$_SwapRequestDto> get copyWith =>
      __$$_SwapRequestDtoCopyWithImpl<_$_SwapRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapRequestDtoToJson(
      this,
    );
  }
}

abstract class _SwapRequestDto implements SwapRequestDto {
  const factory _SwapRequestDto(
      {required final String userPublicKey,
      required final JupiterRoute route}) = _$_SwapRequestDto;

  factory _SwapRequestDto.fromJson(Map<String, dynamic> json) =
      _$_SwapRequestDto.fromJson;

  @override
  String get userPublicKey;
  @override
  JupiterRoute get route;
  @override
  @JsonKey(ignore: true)
  _$$_SwapRequestDtoCopyWith<_$_SwapRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}
