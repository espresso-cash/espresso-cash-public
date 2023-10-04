// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dln_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentQuoteRequestDto _$PaymentQuoteRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _PaymentQuoteRequestDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentQuoteRequestDto {
  String get amount => throw _privateConstructorUsedError;
  String get senderAddress => throw _privateConstructorUsedError;
  String get receiverAddress => throw _privateConstructorUsedError;
  String get receiverBlockchain => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentQuoteRequestDtoCopyWith<PaymentQuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentQuoteRequestDtoCopyWith<$Res> {
  factory $PaymentQuoteRequestDtoCopyWith(PaymentQuoteRequestDto value,
          $Res Function(PaymentQuoteRequestDto) then) =
      _$PaymentQuoteRequestDtoCopyWithImpl<$Res, PaymentQuoteRequestDto>;
  @useResult
  $Res call(
      {String amount,
      String senderAddress,
      String receiverAddress,
      String receiverBlockchain});
}

/// @nodoc
class _$PaymentQuoteRequestDtoCopyWithImpl<$Res,
        $Val extends PaymentQuoteRequestDto>
    implements $PaymentQuoteRequestDtoCopyWith<$Res> {
  _$PaymentQuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? senderAddress = null,
    Object? receiverAddress = null,
    Object? receiverBlockchain = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      senderAddress: null == senderAddress
          ? _value.senderAddress
          : senderAddress // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAddress: null == receiverAddress
          ? _value.receiverAddress
          : receiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      receiverBlockchain: null == receiverBlockchain
          ? _value.receiverBlockchain
          : receiverBlockchain // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentQuoteRequestDtoCopyWith<$Res>
    implements $PaymentQuoteRequestDtoCopyWith<$Res> {
  factory _$$_PaymentQuoteRequestDtoCopyWith(_$_PaymentQuoteRequestDto value,
          $Res Function(_$_PaymentQuoteRequestDto) then) =
      __$$_PaymentQuoteRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String amount,
      String senderAddress,
      String receiverAddress,
      String receiverBlockchain});
}

/// @nodoc
class __$$_PaymentQuoteRequestDtoCopyWithImpl<$Res>
    extends _$PaymentQuoteRequestDtoCopyWithImpl<$Res,
        _$_PaymentQuoteRequestDto>
    implements _$$_PaymentQuoteRequestDtoCopyWith<$Res> {
  __$$_PaymentQuoteRequestDtoCopyWithImpl(_$_PaymentQuoteRequestDto _value,
      $Res Function(_$_PaymentQuoteRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? senderAddress = null,
    Object? receiverAddress = null,
    Object? receiverBlockchain = null,
  }) {
    return _then(_$_PaymentQuoteRequestDto(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      senderAddress: null == senderAddress
          ? _value.senderAddress
          : senderAddress // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAddress: null == receiverAddress
          ? _value.receiverAddress
          : receiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      receiverBlockchain: null == receiverBlockchain
          ? _value.receiverBlockchain
          : receiverBlockchain // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentQuoteRequestDto implements _PaymentQuoteRequestDto {
  const _$_PaymentQuoteRequestDto(
      {required this.amount,
      required this.senderAddress,
      required this.receiverAddress,
      required this.receiverBlockchain});

  factory _$_PaymentQuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentQuoteRequestDtoFromJson(json);

  @override
  final String amount;
  @override
  final String senderAddress;
  @override
  final String receiverAddress;
  @override
  final String receiverBlockchain;

  @override
  String toString() {
    return 'PaymentQuoteRequestDto(amount: $amount, senderAddress: $senderAddress, receiverAddress: $receiverAddress, receiverBlockchain: $receiverBlockchain)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentQuoteRequestDto &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.senderAddress, senderAddress) ||
                other.senderAddress == senderAddress) &&
            (identical(other.receiverAddress, receiverAddress) ||
                other.receiverAddress == receiverAddress) &&
            (identical(other.receiverBlockchain, receiverBlockchain) ||
                other.receiverBlockchain == receiverBlockchain));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, amount, senderAddress, receiverAddress, receiverBlockchain);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentQuoteRequestDtoCopyWith<_$_PaymentQuoteRequestDto> get copyWith =>
      __$$_PaymentQuoteRequestDtoCopyWithImpl<_$_PaymentQuoteRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentQuoteRequestDtoToJson(
      this,
    );
  }
}

abstract class _PaymentQuoteRequestDto implements PaymentQuoteRequestDto {
  const factory _PaymentQuoteRequestDto(
      {required final String amount,
      required final String senderAddress,
      required final String receiverAddress,
      required final String receiverBlockchain}) = _$_PaymentQuoteRequestDto;

  factory _PaymentQuoteRequestDto.fromJson(Map<String, dynamic> json) =
      _$_PaymentQuoteRequestDto.fromJson;

  @override
  String get amount;
  @override
  String get senderAddress;
  @override
  String get receiverAddress;
  @override
  String get receiverBlockchain;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentQuoteRequestDtoCopyWith<_$_PaymentQuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentQuoteResponseDto _$PaymentQuoteResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _PaymentQuoteResponseDto.fromJson(json);
}

/// @nodoc
mixin _$PaymentQuoteResponseDto {
  String get senderDeductAmount => throw _privateConstructorUsedError;
  String get receiverAmount => throw _privateConstructorUsedError;
  String get encodedTx => throw _privateConstructorUsedError;
  int get feeInUsdc => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentQuoteResponseDtoCopyWith<PaymentQuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentQuoteResponseDtoCopyWith<$Res> {
  factory $PaymentQuoteResponseDtoCopyWith(PaymentQuoteResponseDto value,
          $Res Function(PaymentQuoteResponseDto) then) =
      _$PaymentQuoteResponseDtoCopyWithImpl<$Res, PaymentQuoteResponseDto>;
  @useResult
  $Res call(
      {String senderDeductAmount,
      String receiverAmount,
      String encodedTx,
      int feeInUsdc,
      BigInt slot});
}

/// @nodoc
class _$PaymentQuoteResponseDtoCopyWithImpl<$Res,
        $Val extends PaymentQuoteResponseDto>
    implements $PaymentQuoteResponseDtoCopyWith<$Res> {
  _$PaymentQuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderDeductAmount = null,
    Object? receiverAmount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
    Object? slot = null,
  }) {
    return _then(_value.copyWith(
      senderDeductAmount: null == senderDeductAmount
          ? _value.senderDeductAmount
          : senderDeductAmount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAmount: null == receiverAmount
          ? _value.receiverAmount
          : receiverAmount // ignore: cast_nullable_to_non_nullable
              as String,
      encodedTx: null == encodedTx
          ? _value.encodedTx
          : encodedTx // ignore: cast_nullable_to_non_nullable
              as String,
      feeInUsdc: null == feeInUsdc
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentQuoteResponseDtoCopyWith<$Res>
    implements $PaymentQuoteResponseDtoCopyWith<$Res> {
  factory _$$_PaymentQuoteResponseDtoCopyWith(_$_PaymentQuoteResponseDto value,
          $Res Function(_$_PaymentQuoteResponseDto) then) =
      __$$_PaymentQuoteResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String senderDeductAmount,
      String receiverAmount,
      String encodedTx,
      int feeInUsdc,
      BigInt slot});
}

/// @nodoc
class __$$_PaymentQuoteResponseDtoCopyWithImpl<$Res>
    extends _$PaymentQuoteResponseDtoCopyWithImpl<$Res,
        _$_PaymentQuoteResponseDto>
    implements _$$_PaymentQuoteResponseDtoCopyWith<$Res> {
  __$$_PaymentQuoteResponseDtoCopyWithImpl(_$_PaymentQuoteResponseDto _value,
      $Res Function(_$_PaymentQuoteResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderDeductAmount = null,
    Object? receiverAmount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
    Object? slot = null,
  }) {
    return _then(_$_PaymentQuoteResponseDto(
      senderDeductAmount: null == senderDeductAmount
          ? _value.senderDeductAmount
          : senderDeductAmount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAmount: null == receiverAmount
          ? _value.receiverAmount
          : receiverAmount // ignore: cast_nullable_to_non_nullable
              as String,
      encodedTx: null == encodedTx
          ? _value.encodedTx
          : encodedTx // ignore: cast_nullable_to_non_nullable
              as String,
      feeInUsdc: null == feeInUsdc
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentQuoteResponseDto implements _PaymentQuoteResponseDto {
  const _$_PaymentQuoteResponseDto(
      {required this.senderDeductAmount,
      required this.receiverAmount,
      required this.encodedTx,
      required this.feeInUsdc,
      required this.slot});

  factory _$_PaymentQuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentQuoteResponseDtoFromJson(json);

  @override
  final String senderDeductAmount;
  @override
  final String receiverAmount;
  @override
  final String encodedTx;
  @override
  final int feeInUsdc;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'PaymentQuoteResponseDto(senderDeductAmount: $senderDeductAmount, receiverAmount: $receiverAmount, encodedTx: $encodedTx, feeInUsdc: $feeInUsdc, slot: $slot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentQuoteResponseDto &&
            (identical(other.senderDeductAmount, senderDeductAmount) ||
                other.senderDeductAmount == senderDeductAmount) &&
            (identical(other.receiverAmount, receiverAmount) ||
                other.receiverAmount == receiverAmount) &&
            (identical(other.encodedTx, encodedTx) ||
                other.encodedTx == encodedTx) &&
            (identical(other.feeInUsdc, feeInUsdc) ||
                other.feeInUsdc == feeInUsdc) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, senderDeductAmount,
      receiverAmount, encodedTx, feeInUsdc, slot);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentQuoteResponseDtoCopyWith<_$_PaymentQuoteResponseDto>
      get copyWith =>
          __$$_PaymentQuoteResponseDtoCopyWithImpl<_$_PaymentQuoteResponseDto>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentQuoteResponseDtoToJson(
      this,
    );
  }
}

abstract class _PaymentQuoteResponseDto implements PaymentQuoteResponseDto {
  const factory _PaymentQuoteResponseDto(
      {required final String senderDeductAmount,
      required final String receiverAmount,
      required final String encodedTx,
      required final int feeInUsdc,
      required final BigInt slot}) = _$_PaymentQuoteResponseDto;

  factory _PaymentQuoteResponseDto.fromJson(Map<String, dynamic> json) =
      _$_PaymentQuoteResponseDto.fromJson;

  @override
  String get senderDeductAmount;
  @override
  String get receiverAmount;
  @override
  String get encodedTx;
  @override
  int get feeInUsdc;
  @override
  BigInt get slot;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentQuoteResponseDtoCopyWith<_$_PaymentQuoteResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}
