// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'limit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LimitResponseDto _$LimitResponseDtoFromJson(Map<String, dynamic> json) {
  return _LimitResponseDto.fromJson(json);
}

/// @nodoc
mixin _$LimitResponseDto {
  double get minAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LimitResponseDtoCopyWith<LimitResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LimitResponseDtoCopyWith<$Res> {
  factory $LimitResponseDtoCopyWith(
          LimitResponseDto value, $Res Function(LimitResponseDto) then) =
      _$LimitResponseDtoCopyWithImpl<$Res>;
  $Res call({double minAmount});
}

/// @nodoc
class _$LimitResponseDtoCopyWithImpl<$Res>
    implements $LimitResponseDtoCopyWith<$Res> {
  _$LimitResponseDtoCopyWithImpl(this._value, this._then);

  final LimitResponseDto _value;
  // ignore: unused_field
  final $Res Function(LimitResponseDto) _then;

  @override
  $Res call({
    Object? minAmount = freezed,
  }) {
    return _then(_value.copyWith(
      minAmount: minAmount == freezed
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_LimitResponseDtoCopyWith<$Res>
    implements $LimitResponseDtoCopyWith<$Res> {
  factory _$$_LimitResponseDtoCopyWith(
          _$_LimitResponseDto value, $Res Function(_$_LimitResponseDto) then) =
      __$$_LimitResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call({double minAmount});
}

/// @nodoc
class __$$_LimitResponseDtoCopyWithImpl<$Res>
    extends _$LimitResponseDtoCopyWithImpl<$Res>
    implements _$$_LimitResponseDtoCopyWith<$Res> {
  __$$_LimitResponseDtoCopyWithImpl(
      _$_LimitResponseDto _value, $Res Function(_$_LimitResponseDto) _then)
      : super(_value, (v) => _then(v as _$_LimitResponseDto));

  @override
  _$_LimitResponseDto get _value => super._value as _$_LimitResponseDto;

  @override
  $Res call({
    Object? minAmount = freezed,
  }) {
    return _then(_$_LimitResponseDto(
      minAmount: minAmount == freezed
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LimitResponseDto extends _LimitResponseDto {
  const _$_LimitResponseDto({required this.minAmount}) : super._();

  factory _$_LimitResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_LimitResponseDtoFromJson(json);

  @override
  final double minAmount;

  @override
  String toString() {
    return 'LimitResponseDto(minAmount: $minAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LimitResponseDto &&
            const DeepCollectionEquality().equals(other.minAmount, minAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(minAmount));

  @JsonKey(ignore: true)
  @override
  _$$_LimitResponseDtoCopyWith<_$_LimitResponseDto> get copyWith =>
      __$$_LimitResponseDtoCopyWithImpl<_$_LimitResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LimitResponseDtoToJson(
      this,
    );
  }
}

abstract class _LimitResponseDto extends LimitResponseDto {
  const factory _LimitResponseDto({required final double minAmount}) =
      _$_LimitResponseDto;
  const _LimitResponseDto._() : super._();

  factory _LimitResponseDto.fromJson(Map<String, dynamic> json) =
      _$_LimitResponseDto.fromJson;

  @override
  double get minAmount;
  @override
  @JsonKey(ignore: true)
  _$$_LimitResponseDtoCopyWith<_$_LimitResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

LimitRequestDto _$LimitRequestDtoFromJson(Map<String, dynamic> json) {
  return _LimitRequestDto.fromJson(json);
}

/// @nodoc
mixin _$LimitRequestDto {
  String get tokenSymbol => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LimitRequestDtoCopyWith<LimitRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LimitRequestDtoCopyWith<$Res> {
  factory $LimitRequestDtoCopyWith(
          LimitRequestDto value, $Res Function(LimitRequestDto) then) =
      _$LimitRequestDtoCopyWithImpl<$Res>;
  $Res call({String tokenSymbol});
}

/// @nodoc
class _$LimitRequestDtoCopyWithImpl<$Res>
    implements $LimitRequestDtoCopyWith<$Res> {
  _$LimitRequestDtoCopyWithImpl(this._value, this._then);

  final LimitRequestDto _value;
  // ignore: unused_field
  final $Res Function(LimitRequestDto) _then;

  @override
  $Res call({
    Object? tokenSymbol = freezed,
  }) {
    return _then(_value.copyWith(
      tokenSymbol: tokenSymbol == freezed
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LimitRequestDtoCopyWith<$Res>
    implements $LimitRequestDtoCopyWith<$Res> {
  factory _$$_LimitRequestDtoCopyWith(
          _$_LimitRequestDto value, $Res Function(_$_LimitRequestDto) then) =
      __$$_LimitRequestDtoCopyWithImpl<$Res>;
  @override
  $Res call({String tokenSymbol});
}

/// @nodoc
class __$$_LimitRequestDtoCopyWithImpl<$Res>
    extends _$LimitRequestDtoCopyWithImpl<$Res>
    implements _$$_LimitRequestDtoCopyWith<$Res> {
  __$$_LimitRequestDtoCopyWithImpl(
      _$_LimitRequestDto _value, $Res Function(_$_LimitRequestDto) _then)
      : super(_value, (v) => _then(v as _$_LimitRequestDto));

  @override
  _$_LimitRequestDto get _value => super._value as _$_LimitRequestDto;

  @override
  $Res call({
    Object? tokenSymbol = freezed,
  }) {
    return _then(_$_LimitRequestDto(
      tokenSymbol: tokenSymbol == freezed
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LimitRequestDto implements _LimitRequestDto {
  const _$_LimitRequestDto({required this.tokenSymbol});

  factory _$_LimitRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_LimitRequestDtoFromJson(json);

  @override
  final String tokenSymbol;

  @override
  String toString() {
    return 'LimitRequestDto(tokenSymbol: $tokenSymbol)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LimitRequestDto &&
            const DeepCollectionEquality()
                .equals(other.tokenSymbol, tokenSymbol));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(tokenSymbol));

  @JsonKey(ignore: true)
  @override
  _$$_LimitRequestDtoCopyWith<_$_LimitRequestDto> get copyWith =>
      __$$_LimitRequestDtoCopyWithImpl<_$_LimitRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LimitRequestDtoToJson(
      this,
    );
  }
}

abstract class _LimitRequestDto implements LimitRequestDto {
  const factory _LimitRequestDto({required final String tokenSymbol}) =
      _$_LimitRequestDto;

  factory _LimitRequestDto.fromJson(Map<String, dynamic> json) =
      _$_LimitRequestDto.fromJson;

  @override
  String get tokenSymbol;
  @override
  @JsonKey(ignore: true)
  _$$_LimitRequestDtoCopyWith<_$_LimitRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}
