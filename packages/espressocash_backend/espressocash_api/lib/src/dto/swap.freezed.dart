// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SwapRouteRequestDto _$SwapRouteRequestDtoFromJson(Map<String, dynamic> json) {
  return _SwapRouteRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SwapRouteRequestDto {
  String get inputToken => throw _privateConstructorUsedError;
  String get outputToken => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  SwapMatch get match => throw _privateConstructorUsedError;
  SwapSlippage get slippage => throw _privateConstructorUsedError;
  String get userAccount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapRouteRequestDtoCopyWith<SwapRouteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapRouteRequestDtoCopyWith<$Res> {
  factory $SwapRouteRequestDtoCopyWith(
          SwapRouteRequestDto value, $Res Function(SwapRouteRequestDto) then) =
      _$SwapRouteRequestDtoCopyWithImpl<$Res, SwapRouteRequestDto>;
  @useResult
  $Res call(
      {String inputToken,
      String outputToken,
      String amount,
      SwapMatch match,
      SwapSlippage slippage,
      String userAccount});
}

/// @nodoc
class _$SwapRouteRequestDtoCopyWithImpl<$Res, $Val extends SwapRouteRequestDto>
    implements $SwapRouteRequestDtoCopyWith<$Res> {
  _$SwapRouteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputToken = null,
    Object? outputToken = null,
    Object? amount = null,
    Object? match = null,
    Object? slippage = null,
    Object? userAccount = null,
  }) {
    return _then(_value.copyWith(
      inputToken: null == inputToken
          ? _value.inputToken
          : inputToken // ignore: cast_nullable_to_non_nullable
              as String,
      outputToken: null == outputToken
          ? _value.outputToken
          : outputToken // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as SwapMatch,
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as SwapSlippage,
      userAccount: null == userAccount
          ? _value.userAccount
          : userAccount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SwapRouteRequestDtoCopyWith<$Res>
    implements $SwapRouteRequestDtoCopyWith<$Res> {
  factory _$$_SwapRouteRequestDtoCopyWith(_$_SwapRouteRequestDto value,
          $Res Function(_$_SwapRouteRequestDto) then) =
      __$$_SwapRouteRequestDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inputToken,
      String outputToken,
      String amount,
      SwapMatch match,
      SwapSlippage slippage,
      String userAccount});
}

/// @nodoc
class __$$_SwapRouteRequestDtoCopyWithImpl<$Res>
    extends _$SwapRouteRequestDtoCopyWithImpl<$Res, _$_SwapRouteRequestDto>
    implements _$$_SwapRouteRequestDtoCopyWith<$Res> {
  __$$_SwapRouteRequestDtoCopyWithImpl(_$_SwapRouteRequestDto _value,
      $Res Function(_$_SwapRouteRequestDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputToken = null,
    Object? outputToken = null,
    Object? amount = null,
    Object? match = null,
    Object? slippage = null,
    Object? userAccount = null,
  }) {
    return _then(_$_SwapRouteRequestDto(
      inputToken: null == inputToken
          ? _value.inputToken
          : inputToken // ignore: cast_nullable_to_non_nullable
              as String,
      outputToken: null == outputToken
          ? _value.outputToken
          : outputToken // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      match: null == match
          ? _value.match
          : match // ignore: cast_nullable_to_non_nullable
              as SwapMatch,
      slippage: null == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as SwapSlippage,
      userAccount: null == userAccount
          ? _value.userAccount
          : userAccount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapRouteRequestDto implements _SwapRouteRequestDto {
  const _$_SwapRouteRequestDto(
      {required this.inputToken,
      required this.outputToken,
      required this.amount,
      required this.match,
      required this.slippage,
      required this.userAccount});

  factory _$_SwapRouteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapRouteRequestDtoFromJson(json);

  @override
  final String inputToken;
  @override
  final String outputToken;
  @override
  final String amount;
  @override
  final SwapMatch match;
  @override
  final SwapSlippage slippage;
  @override
  final String userAccount;

  @override
  String toString() {
    return 'SwapRouteRequestDto(inputToken: $inputToken, outputToken: $outputToken, amount: $amount, match: $match, slippage: $slippage, userAccount: $userAccount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapRouteRequestDto &&
            (identical(other.inputToken, inputToken) ||
                other.inputToken == inputToken) &&
            (identical(other.outputToken, outputToken) ||
                other.outputToken == outputToken) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.match, match) || other.match == match) &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
            (identical(other.userAccount, userAccount) ||
                other.userAccount == userAccount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, inputToken, outputToken, amount,
      match, slippage, userAccount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SwapRouteRequestDtoCopyWith<_$_SwapRouteRequestDto> get copyWith =>
      __$$_SwapRouteRequestDtoCopyWithImpl<_$_SwapRouteRequestDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapRouteRequestDtoToJson(
      this,
    );
  }
}

abstract class _SwapRouteRequestDto implements SwapRouteRequestDto {
  const factory _SwapRouteRequestDto(
      {required final String inputToken,
      required final String outputToken,
      required final String amount,
      required final SwapMatch match,
      required final SwapSlippage slippage,
      required final String userAccount}) = _$_SwapRouteRequestDto;

  factory _SwapRouteRequestDto.fromJson(Map<String, dynamic> json) =
      _$_SwapRouteRequestDto.fromJson;

  @override
  String get inputToken;
  @override
  String get outputToken;
  @override
  String get amount;
  @override
  SwapMatch get match;
  @override
  SwapSlippage get slippage;
  @override
  String get userAccount;
  @override
  @JsonKey(ignore: true)
  _$$_SwapRouteRequestDtoCopyWith<_$_SwapRouteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

SwapRouteResponseDto _$SwapRouteResponseDtoFromJson(Map<String, dynamic> json) {
  return _SwapRouteResponseDto.fromJson(json);
}

/// @nodoc
mixin _$SwapRouteResponseDto {
  String get inAmount => throw _privateConstructorUsedError;
  String get outAmount => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get encodedTx => throw _privateConstructorUsedError;
  int get feeInUsdc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapRouteResponseDtoCopyWith<SwapRouteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapRouteResponseDtoCopyWith<$Res> {
  factory $SwapRouteResponseDtoCopyWith(SwapRouteResponseDto value,
          $Res Function(SwapRouteResponseDto) then) =
      _$SwapRouteResponseDtoCopyWithImpl<$Res, SwapRouteResponseDto>;
  @useResult
  $Res call(
      {String inAmount,
      String outAmount,
      String amount,
      String encodedTx,
      int feeInUsdc});
}

/// @nodoc
class _$SwapRouteResponseDtoCopyWithImpl<$Res,
        $Val extends SwapRouteResponseDto>
    implements $SwapRouteResponseDtoCopyWith<$Res> {
  _$SwapRouteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inAmount = null,
    Object? outAmount = null,
    Object? amount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
  }) {
    return _then(_value.copyWith(
      inAmount: null == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      encodedTx: null == encodedTx
          ? _value.encodedTx
          : encodedTx // ignore: cast_nullable_to_non_nullable
              as String,
      feeInUsdc: null == feeInUsdc
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SwapRouteResponseDtoCopyWith<$Res>
    implements $SwapRouteResponseDtoCopyWith<$Res> {
  factory _$$_SwapRouteResponseDtoCopyWith(_$_SwapRouteResponseDto value,
          $Res Function(_$_SwapRouteResponseDto) then) =
      __$$_SwapRouteResponseDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inAmount,
      String outAmount,
      String amount,
      String encodedTx,
      int feeInUsdc});
}

/// @nodoc
class __$$_SwapRouteResponseDtoCopyWithImpl<$Res>
    extends _$SwapRouteResponseDtoCopyWithImpl<$Res, _$_SwapRouteResponseDto>
    implements _$$_SwapRouteResponseDtoCopyWith<$Res> {
  __$$_SwapRouteResponseDtoCopyWithImpl(_$_SwapRouteResponseDto _value,
      $Res Function(_$_SwapRouteResponseDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inAmount = null,
    Object? outAmount = null,
    Object? amount = null,
    Object? encodedTx = null,
    Object? feeInUsdc = null,
  }) {
    return _then(_$_SwapRouteResponseDto(
      inAmount: null == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      encodedTx: null == encodedTx
          ? _value.encodedTx
          : encodedTx // ignore: cast_nullable_to_non_nullable
              as String,
      feeInUsdc: null == feeInUsdc
          ? _value.feeInUsdc
          : feeInUsdc // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SwapRouteResponseDto implements _SwapRouteResponseDto {
  const _$_SwapRouteResponseDto(
      {required this.inAmount,
      required this.outAmount,
      required this.amount,
      required this.encodedTx,
      required this.feeInUsdc});

  factory _$_SwapRouteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$$_SwapRouteResponseDtoFromJson(json);

  @override
  final String inAmount;
  @override
  final String outAmount;
  @override
  final String amount;
  @override
  final String encodedTx;
  @override
  final int feeInUsdc;

  @override
  String toString() {
    return 'SwapRouteResponseDto(inAmount: $inAmount, outAmount: $outAmount, amount: $amount, encodedTx: $encodedTx, feeInUsdc: $feeInUsdc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SwapRouteResponseDto &&
            (identical(other.inAmount, inAmount) ||
                other.inAmount == inAmount) &&
            (identical(other.outAmount, outAmount) ||
                other.outAmount == outAmount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.encodedTx, encodedTx) ||
                other.encodedTx == encodedTx) &&
            (identical(other.feeInUsdc, feeInUsdc) ||
                other.feeInUsdc == feeInUsdc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, inAmount, outAmount, amount, encodedTx, feeInUsdc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SwapRouteResponseDtoCopyWith<_$_SwapRouteResponseDto> get copyWith =>
      __$$_SwapRouteResponseDtoCopyWithImpl<_$_SwapRouteResponseDto>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SwapRouteResponseDtoToJson(
      this,
    );
  }
}

abstract class _SwapRouteResponseDto implements SwapRouteResponseDto {
  const factory _SwapRouteResponseDto(
      {required final String inAmount,
      required final String outAmount,
      required final String amount,
      required final String encodedTx,
      required final int feeInUsdc}) = _$_SwapRouteResponseDto;

  factory _SwapRouteResponseDto.fromJson(Map<String, dynamic> json) =
      _$_SwapRouteResponseDto.fromJson;

  @override
  String get inAmount;
  @override
  String get outAmount;
  @override
  String get amount;
  @override
  String get encodedTx;
  @override
  int get feeInUsdc;
  @override
  @JsonKey(ignore: true)
  _$$_SwapRouteResponseDtoCopyWith<_$_SwapRouteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}
