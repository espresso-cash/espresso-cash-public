// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QuoteResponseDto _$QuoteResponseDtoFromJson(Map<String, dynamic> json) {
  return _QuoteResponseDto.fromJson(json);
}

/// @nodoc
mixin _$QuoteResponseDto {
  double get quoteAmount => throw _privateConstructorUsedError;
  double get feeAmount => throw _privateConstructorUsedError;
  double get networkFeeAmount => throw _privateConstructorUsedError;
  int get minAmount => throw _privateConstructorUsedError;
  double get quotePrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuoteResponseDtoCopyWith<QuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteResponseDtoCopyWith<$Res> {
  factory $QuoteResponseDtoCopyWith(
          QuoteResponseDto value, $Res Function(QuoteResponseDto) then) =
      _$QuoteResponseDtoCopyWithImpl<$Res>;
  $Res call(
      {double quoteAmount,
      double feeAmount,
      double networkFeeAmount,
      int minAmount,
      double quotePrice});
}

/// @nodoc
class _$QuoteResponseDtoCopyWithImpl<$Res>
    implements $QuoteResponseDtoCopyWith<$Res> {
  _$QuoteResponseDtoCopyWithImpl(this._value, this._then);

  final QuoteResponseDto _value;
  // ignore: unused_field
  final $Res Function(QuoteResponseDto) _then;

  @override
  $Res call({
    Object? quoteAmount = freezed,
    Object? feeAmount = freezed,
    Object? networkFeeAmount = freezed,
    Object? minAmount = freezed,
    Object? quotePrice = freezed,
  }) {
    return _then(_value.copyWith(
      quoteAmount: quoteAmount == freezed
          ? _value.quoteAmount
          : quoteAmount // ignore: cast_nullable_to_non_nullable
              as double,
      feeAmount: feeAmount == freezed
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      networkFeeAmount: networkFeeAmount == freezed
          ? _value.networkFeeAmount
          : networkFeeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      minAmount: minAmount == freezed
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as int,
      quotePrice: quotePrice == freezed
          ? _value.quotePrice
          : quotePrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_QuoteResponseDtoCopyWith<$Res>
    implements $QuoteResponseDtoCopyWith<$Res> {
  factory _$$_QuoteResponseDtoCopyWith(
          _$_QuoteResponseDto value, $Res Function(_$_QuoteResponseDto) then) =
      __$$_QuoteResponseDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {double quoteAmount,
      double feeAmount,
      double networkFeeAmount,
      int minAmount,
      double quotePrice});
}

/// @nodoc
class __$$_QuoteResponseDtoCopyWithImpl<$Res>
    extends _$QuoteResponseDtoCopyWithImpl<$Res>
    implements _$$_QuoteResponseDtoCopyWith<$Res> {
  __$$_QuoteResponseDtoCopyWithImpl(
      _$_QuoteResponseDto _value, $Res Function(_$_QuoteResponseDto) _then)
      : super(_value, (v) => _then(v as _$_QuoteResponseDto));

  @override
  _$_QuoteResponseDto get _value => super._value as _$_QuoteResponseDto;

  @override
  $Res call({
    Object? quoteAmount = freezed,
    Object? feeAmount = freezed,
    Object? networkFeeAmount = freezed,
    Object? minAmount = freezed,
    Object? quotePrice = freezed,
  }) {
    return _then(_$_QuoteResponseDto(
      quoteAmount: quoteAmount == freezed
          ? _value.quoteAmount
          : quoteAmount // ignore: cast_nullable_to_non_nullable
              as double,
      feeAmount: feeAmount == freezed
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      networkFeeAmount: networkFeeAmount == freezed
          ? _value.networkFeeAmount
          : networkFeeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      minAmount: minAmount == freezed
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as int,
      quotePrice: quotePrice == freezed
          ? _value.quotePrice
          : quotePrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QuoteResponseDto implements _QuoteResponseDto {
  const _$_QuoteResponseDto(
      {required this.quoteAmount,
      required this.feeAmount,
      required this.networkFeeAmount,
      required this.minAmount,
      required this.quotePrice});

  factory _$_QuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_QuoteResponseDtoFromJson(json);

  @override
  final double quoteAmount;
  @override
  final double feeAmount;
  @override
  final double networkFeeAmount;
  @override
  final int minAmount;
  @override
  final double quotePrice;

  @override
  String toString() {
    return 'QuoteResponseDto(quoteAmount: $quoteAmount, feeAmount: $feeAmount, networkFeeAmount: $networkFeeAmount, minAmount: $minAmount, quotePrice: $quotePrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuoteResponseDto &&
            const DeepCollectionEquality()
                .equals(other.quoteAmount, quoteAmount) &&
            const DeepCollectionEquality().equals(other.feeAmount, feeAmount) &&
            const DeepCollectionEquality()
                .equals(other.networkFeeAmount, networkFeeAmount) &&
            const DeepCollectionEquality().equals(other.minAmount, minAmount) &&
            const DeepCollectionEquality()
                .equals(other.quotePrice, quotePrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(quoteAmount),
      const DeepCollectionEquality().hash(feeAmount),
      const DeepCollectionEquality().hash(networkFeeAmount),
      const DeepCollectionEquality().hash(minAmount),
      const DeepCollectionEquality().hash(quotePrice));

  @JsonKey(ignore: true)
  @override
  _$$_QuoteResponseDtoCopyWith<_$_QuoteResponseDto> get copyWith =>
      __$$_QuoteResponseDtoCopyWithImpl<_$_QuoteResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuoteResponseDtoToJson(
      this,
    );
  }
}

abstract class _QuoteResponseDto implements QuoteResponseDto {
  const factory _QuoteResponseDto(
      {required final double quoteAmount,
      required final double feeAmount,
      required final double networkFeeAmount,
      required final int minAmount,
      required final double quotePrice}) = _$_QuoteResponseDto;

  factory _QuoteResponseDto.fromJson(Map<String, dynamic> json) =
      _$_QuoteResponseDto.fromJson;

  @override
  double get quoteAmount;
  @override
  double get feeAmount;
  @override
  double get networkFeeAmount;
  @override
  int get minAmount;
  @override
  double get quotePrice;
  @override
  @JsonKey(ignore: true)
  _$$_QuoteResponseDtoCopyWith<_$_QuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

QuoteRequestDto _$QuoteRequestDtoFromJson(Map<String, dynamic> json) {
  return _QuoteRequestDto.fromJson(json);
}

/// @nodoc
mixin _$QuoteRequestDto {
  String get tokenSymbol => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuoteRequestDtoCopyWith<QuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteRequestDtoCopyWith<$Res> {
  factory $QuoteRequestDtoCopyWith(
          QuoteRequestDto value, $Res Function(QuoteRequestDto) then) =
      _$QuoteRequestDtoCopyWithImpl<$Res>;
  $Res call({String tokenSymbol, String value});
}

/// @nodoc
class _$QuoteRequestDtoCopyWithImpl<$Res>
    implements $QuoteRequestDtoCopyWith<$Res> {
  _$QuoteRequestDtoCopyWithImpl(this._value, this._then);

  final QuoteRequestDto _value;
  // ignore: unused_field
  final $Res Function(QuoteRequestDto) _then;

  @override
  $Res call({
    Object? tokenSymbol = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      tokenSymbol: tokenSymbol == freezed
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_QuoteRequestDtoCopyWith<$Res>
    implements $QuoteRequestDtoCopyWith<$Res> {
  factory _$$_QuoteRequestDtoCopyWith(
          _$_QuoteRequestDto value, $Res Function(_$_QuoteRequestDto) then) =
      __$$_QuoteRequestDtoCopyWithImpl<$Res>;
  @override
  $Res call({String tokenSymbol, String value});
}

/// @nodoc
class __$$_QuoteRequestDtoCopyWithImpl<$Res>
    extends _$QuoteRequestDtoCopyWithImpl<$Res>
    implements _$$_QuoteRequestDtoCopyWith<$Res> {
  __$$_QuoteRequestDtoCopyWithImpl(
      _$_QuoteRequestDto _value, $Res Function(_$_QuoteRequestDto) _then)
      : super(_value, (v) => _then(v as _$_QuoteRequestDto));

  @override
  _$_QuoteRequestDto get _value => super._value as _$_QuoteRequestDto;

  @override
  $Res call({
    Object? tokenSymbol = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_QuoteRequestDto(
      tokenSymbol: tokenSymbol == freezed
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QuoteRequestDto implements _QuoteRequestDto {
  const _$_QuoteRequestDto({required this.tokenSymbol, required this.value});

  factory _$_QuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_QuoteRequestDtoFromJson(json);

  @override
  final String tokenSymbol;
  @override
  final String value;

  @override
  String toString() {
    return 'QuoteRequestDto(tokenSymbol: $tokenSymbol, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuoteRequestDto &&
            const DeepCollectionEquality()
                .equals(other.tokenSymbol, tokenSymbol) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tokenSymbol),
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  _$$_QuoteRequestDtoCopyWith<_$_QuoteRequestDto> get copyWith =>
      __$$_QuoteRequestDtoCopyWithImpl<_$_QuoteRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuoteRequestDtoToJson(
      this,
    );
  }
}

abstract class _QuoteRequestDto implements QuoteRequestDto {
  const factory _QuoteRequestDto(
      {required final String tokenSymbol,
      required final String value}) = _$_QuoteRequestDto;

  factory _QuoteRequestDto.fromJson(Map<String, dynamic> json) =
      _$_QuoteRequestDto.fromJson;

  @override
  String get tokenSymbol;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$_QuoteRequestDtoCopyWith<_$_QuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}
