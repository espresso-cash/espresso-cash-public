// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'moonpay_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoonpayQuoteDto _$MoonpayQuoteDtoFromJson(Map<String, dynamic> json) {
  return _MoonpayQuoteDto.fromJson(json);
}

/// @nodoc
mixin _$MoonpayQuoteDto {
  String get accountId => throw _privateConstructorUsedError;
  String get baseCurrencyCode => throw _privateConstructorUsedError;
  double get baseCurrencyAmount => throw _privateConstructorUsedError;
  String get quoteCurrencyCode => throw _privateConstructorUsedError;
  double get quoteCurrencyAmount => throw _privateConstructorUsedError;
  double get quoteCurrencyPrice => throw _privateConstructorUsedError;
  double get feeAmount => throw _privateConstructorUsedError;
  double get extraFeeAmount => throw _privateConstructorUsedError;
  double get extraFeePercentage => throw _privateConstructorUsedError;
  double get networkFeeAmount => throw _privateConstructorUsedError;
  bool get networkFeeAmountNonRefundable => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  dynamic get feeDiscountType => throw _privateConstructorUsedError;
  dynamic get feeAmountDiscount => throw _privateConstructorUsedError;
  String get feeRuleId => throw _privateConstructorUsedError;
  MoonpayCurrency get baseCurrency => throw _privateConstructorUsedError;
  MoonpayCurrency get currency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoonpayQuoteDtoCopyWith<MoonpayQuoteDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoonpayQuoteDtoCopyWith<$Res> {
  factory $MoonpayQuoteDtoCopyWith(
          MoonpayQuoteDto value, $Res Function(MoonpayQuoteDto) then) =
      _$MoonpayQuoteDtoCopyWithImpl<$Res>;
  $Res call(
      {String accountId,
      String baseCurrencyCode,
      double baseCurrencyAmount,
      String quoteCurrencyCode,
      double quoteCurrencyAmount,
      double quoteCurrencyPrice,
      double feeAmount,
      double extraFeeAmount,
      double extraFeePercentage,
      double networkFeeAmount,
      bool networkFeeAmountNonRefundable,
      double totalAmount,
      dynamic feeDiscountType,
      dynamic feeAmountDiscount,
      String feeRuleId,
      MoonpayCurrency baseCurrency,
      MoonpayCurrency currency});

  $MoonpayCurrencyCopyWith<$Res> get baseCurrency;
  $MoonpayCurrencyCopyWith<$Res> get currency;
}

/// @nodoc
class _$MoonpayQuoteDtoCopyWithImpl<$Res>
    implements $MoonpayQuoteDtoCopyWith<$Res> {
  _$MoonpayQuoteDtoCopyWithImpl(this._value, this._then);

  final MoonpayQuoteDto _value;
  // ignore: unused_field
  final $Res Function(MoonpayQuoteDto) _then;

  @override
  $Res call({
    Object? accountId = freezed,
    Object? baseCurrencyCode = freezed,
    Object? baseCurrencyAmount = freezed,
    Object? quoteCurrencyCode = freezed,
    Object? quoteCurrencyAmount = freezed,
    Object? quoteCurrencyPrice = freezed,
    Object? feeAmount = freezed,
    Object? extraFeeAmount = freezed,
    Object? extraFeePercentage = freezed,
    Object? networkFeeAmount = freezed,
    Object? networkFeeAmountNonRefundable = freezed,
    Object? totalAmount = freezed,
    Object? feeDiscountType = freezed,
    Object? feeAmountDiscount = freezed,
    Object? feeRuleId = freezed,
    Object? baseCurrency = freezed,
    Object? currency = freezed,
  }) {
    return _then(_value.copyWith(
      accountId: accountId == freezed
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrencyCode: baseCurrencyCode == freezed
          ? _value.baseCurrencyCode
          : baseCurrencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrencyAmount: baseCurrencyAmount == freezed
          ? _value.baseCurrencyAmount
          : baseCurrencyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      quoteCurrencyCode: quoteCurrencyCode == freezed
          ? _value.quoteCurrencyCode
          : quoteCurrencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      quoteCurrencyAmount: quoteCurrencyAmount == freezed
          ? _value.quoteCurrencyAmount
          : quoteCurrencyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      quoteCurrencyPrice: quoteCurrencyPrice == freezed
          ? _value.quoteCurrencyPrice
          : quoteCurrencyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      feeAmount: feeAmount == freezed
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      extraFeeAmount: extraFeeAmount == freezed
          ? _value.extraFeeAmount
          : extraFeeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      extraFeePercentage: extraFeePercentage == freezed
          ? _value.extraFeePercentage
          : extraFeePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      networkFeeAmount: networkFeeAmount == freezed
          ? _value.networkFeeAmount
          : networkFeeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      networkFeeAmountNonRefundable: networkFeeAmountNonRefundable == freezed
          ? _value.networkFeeAmountNonRefundable
          : networkFeeAmountNonRefundable // ignore: cast_nullable_to_non_nullable
              as bool,
      totalAmount: totalAmount == freezed
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      feeDiscountType: feeDiscountType == freezed
          ? _value.feeDiscountType
          : feeDiscountType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      feeAmountDiscount: feeAmountDiscount == freezed
          ? _value.feeAmountDiscount
          : feeAmountDiscount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      feeRuleId: feeRuleId == freezed
          ? _value.feeRuleId
          : feeRuleId // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrency: baseCurrency == freezed
          ? _value.baseCurrency
          : baseCurrency // ignore: cast_nullable_to_non_nullable
              as MoonpayCurrency,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as MoonpayCurrency,
    ));
  }

  @override
  $MoonpayCurrencyCopyWith<$Res> get baseCurrency {
    return $MoonpayCurrencyCopyWith<$Res>(_value.baseCurrency, (value) {
      return _then(_value.copyWith(baseCurrency: value));
    });
  }

  @override
  $MoonpayCurrencyCopyWith<$Res> get currency {
    return $MoonpayCurrencyCopyWith<$Res>(_value.currency, (value) {
      return _then(_value.copyWith(currency: value));
    });
  }
}

/// @nodoc
abstract class _$$_MoonpayQuoteDtoCopyWith<$Res>
    implements $MoonpayQuoteDtoCopyWith<$Res> {
  factory _$$_MoonpayQuoteDtoCopyWith(
          _$_MoonpayQuoteDto value, $Res Function(_$_MoonpayQuoteDto) then) =
      __$$_MoonpayQuoteDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String accountId,
      String baseCurrencyCode,
      double baseCurrencyAmount,
      String quoteCurrencyCode,
      double quoteCurrencyAmount,
      double quoteCurrencyPrice,
      double feeAmount,
      double extraFeeAmount,
      double extraFeePercentage,
      double networkFeeAmount,
      bool networkFeeAmountNonRefundable,
      double totalAmount,
      dynamic feeDiscountType,
      dynamic feeAmountDiscount,
      String feeRuleId,
      MoonpayCurrency baseCurrency,
      MoonpayCurrency currency});

  @override
  $MoonpayCurrencyCopyWith<$Res> get baseCurrency;
  @override
  $MoonpayCurrencyCopyWith<$Res> get currency;
}

/// @nodoc
class __$$_MoonpayQuoteDtoCopyWithImpl<$Res>
    extends _$MoonpayQuoteDtoCopyWithImpl<$Res>
    implements _$$_MoonpayQuoteDtoCopyWith<$Res> {
  __$$_MoonpayQuoteDtoCopyWithImpl(
      _$_MoonpayQuoteDto _value, $Res Function(_$_MoonpayQuoteDto) _then)
      : super(_value, (v) => _then(v as _$_MoonpayQuoteDto));

  @override
  _$_MoonpayQuoteDto get _value => super._value as _$_MoonpayQuoteDto;

  @override
  $Res call({
    Object? accountId = freezed,
    Object? baseCurrencyCode = freezed,
    Object? baseCurrencyAmount = freezed,
    Object? quoteCurrencyCode = freezed,
    Object? quoteCurrencyAmount = freezed,
    Object? quoteCurrencyPrice = freezed,
    Object? feeAmount = freezed,
    Object? extraFeeAmount = freezed,
    Object? extraFeePercentage = freezed,
    Object? networkFeeAmount = freezed,
    Object? networkFeeAmountNonRefundable = freezed,
    Object? totalAmount = freezed,
    Object? feeDiscountType = freezed,
    Object? feeAmountDiscount = freezed,
    Object? feeRuleId = freezed,
    Object? baseCurrency = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$_MoonpayQuoteDto(
      accountId: accountId == freezed
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrencyCode: baseCurrencyCode == freezed
          ? _value.baseCurrencyCode
          : baseCurrencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrencyAmount: baseCurrencyAmount == freezed
          ? _value.baseCurrencyAmount
          : baseCurrencyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      quoteCurrencyCode: quoteCurrencyCode == freezed
          ? _value.quoteCurrencyCode
          : quoteCurrencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      quoteCurrencyAmount: quoteCurrencyAmount == freezed
          ? _value.quoteCurrencyAmount
          : quoteCurrencyAmount // ignore: cast_nullable_to_non_nullable
              as double,
      quoteCurrencyPrice: quoteCurrencyPrice == freezed
          ? _value.quoteCurrencyPrice
          : quoteCurrencyPrice // ignore: cast_nullable_to_non_nullable
              as double,
      feeAmount: feeAmount == freezed
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      extraFeeAmount: extraFeeAmount == freezed
          ? _value.extraFeeAmount
          : extraFeeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      extraFeePercentage: extraFeePercentage == freezed
          ? _value.extraFeePercentage
          : extraFeePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      networkFeeAmount: networkFeeAmount == freezed
          ? _value.networkFeeAmount
          : networkFeeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      networkFeeAmountNonRefundable: networkFeeAmountNonRefundable == freezed
          ? _value.networkFeeAmountNonRefundable
          : networkFeeAmountNonRefundable // ignore: cast_nullable_to_non_nullable
              as bool,
      totalAmount: totalAmount == freezed
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      feeDiscountType: feeDiscountType == freezed
          ? _value.feeDiscountType
          : feeDiscountType // ignore: cast_nullable_to_non_nullable
              as dynamic,
      feeAmountDiscount: feeAmountDiscount == freezed
          ? _value.feeAmountDiscount
          : feeAmountDiscount // ignore: cast_nullable_to_non_nullable
              as dynamic,
      feeRuleId: feeRuleId == freezed
          ? _value.feeRuleId
          : feeRuleId // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrency: baseCurrency == freezed
          ? _value.baseCurrency
          : baseCurrency // ignore: cast_nullable_to_non_nullable
              as MoonpayCurrency,
      currency: currency == freezed
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as MoonpayCurrency,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoonpayQuoteDto implements _MoonpayQuoteDto {
  const _$_MoonpayQuoteDto(
      {required this.accountId,
      required this.baseCurrencyCode,
      required this.baseCurrencyAmount,
      required this.quoteCurrencyCode,
      required this.quoteCurrencyAmount,
      required this.quoteCurrencyPrice,
      required this.feeAmount,
      required this.extraFeeAmount,
      required this.extraFeePercentage,
      required this.networkFeeAmount,
      required this.networkFeeAmountNonRefundable,
      required this.totalAmount,
      required this.feeDiscountType,
      required this.feeAmountDiscount,
      required this.feeRuleId,
      required this.baseCurrency,
      required this.currency});

  factory _$_MoonpayQuoteDto.fromJson(Map<String, dynamic> json) =>
      _$$_MoonpayQuoteDtoFromJson(json);

  @override
  final String accountId;
  @override
  final String baseCurrencyCode;
  @override
  final double baseCurrencyAmount;
  @override
  final String quoteCurrencyCode;
  @override
  final double quoteCurrencyAmount;
  @override
  final double quoteCurrencyPrice;
  @override
  final double feeAmount;
  @override
  final double extraFeeAmount;
  @override
  final double extraFeePercentage;
  @override
  final double networkFeeAmount;
  @override
  final bool networkFeeAmountNonRefundable;
  @override
  final double totalAmount;
  @override
  final dynamic feeDiscountType;
  @override
  final dynamic feeAmountDiscount;
  @override
  final String feeRuleId;
  @override
  final MoonpayCurrency baseCurrency;
  @override
  final MoonpayCurrency currency;

  @override
  String toString() {
    return 'MoonpayQuoteDto(accountId: $accountId, baseCurrencyCode: $baseCurrencyCode, baseCurrencyAmount: $baseCurrencyAmount, quoteCurrencyCode: $quoteCurrencyCode, quoteCurrencyAmount: $quoteCurrencyAmount, quoteCurrencyPrice: $quoteCurrencyPrice, feeAmount: $feeAmount, extraFeeAmount: $extraFeeAmount, extraFeePercentage: $extraFeePercentage, networkFeeAmount: $networkFeeAmount, networkFeeAmountNonRefundable: $networkFeeAmountNonRefundable, totalAmount: $totalAmount, feeDiscountType: $feeDiscountType, feeAmountDiscount: $feeAmountDiscount, feeRuleId: $feeRuleId, baseCurrency: $baseCurrency, currency: $currency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoonpayQuoteDto &&
            const DeepCollectionEquality().equals(other.accountId, accountId) &&
            const DeepCollectionEquality()
                .equals(other.baseCurrencyCode, baseCurrencyCode) &&
            const DeepCollectionEquality()
                .equals(other.baseCurrencyAmount, baseCurrencyAmount) &&
            const DeepCollectionEquality()
                .equals(other.quoteCurrencyCode, quoteCurrencyCode) &&
            const DeepCollectionEquality()
                .equals(other.quoteCurrencyAmount, quoteCurrencyAmount) &&
            const DeepCollectionEquality()
                .equals(other.quoteCurrencyPrice, quoteCurrencyPrice) &&
            const DeepCollectionEquality().equals(other.feeAmount, feeAmount) &&
            const DeepCollectionEquality()
                .equals(other.extraFeeAmount, extraFeeAmount) &&
            const DeepCollectionEquality()
                .equals(other.extraFeePercentage, extraFeePercentage) &&
            const DeepCollectionEquality()
                .equals(other.networkFeeAmount, networkFeeAmount) &&
            const DeepCollectionEquality().equals(
                other.networkFeeAmountNonRefundable,
                networkFeeAmountNonRefundable) &&
            const DeepCollectionEquality()
                .equals(other.totalAmount, totalAmount) &&
            const DeepCollectionEquality()
                .equals(other.feeDiscountType, feeDiscountType) &&
            const DeepCollectionEquality()
                .equals(other.feeAmountDiscount, feeAmountDiscount) &&
            const DeepCollectionEquality().equals(other.feeRuleId, feeRuleId) &&
            const DeepCollectionEquality()
                .equals(other.baseCurrency, baseCurrency) &&
            const DeepCollectionEquality().equals(other.currency, currency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(accountId),
      const DeepCollectionEquality().hash(baseCurrencyCode),
      const DeepCollectionEquality().hash(baseCurrencyAmount),
      const DeepCollectionEquality().hash(quoteCurrencyCode),
      const DeepCollectionEquality().hash(quoteCurrencyAmount),
      const DeepCollectionEquality().hash(quoteCurrencyPrice),
      const DeepCollectionEquality().hash(feeAmount),
      const DeepCollectionEquality().hash(extraFeeAmount),
      const DeepCollectionEquality().hash(extraFeePercentage),
      const DeepCollectionEquality().hash(networkFeeAmount),
      const DeepCollectionEquality().hash(networkFeeAmountNonRefundable),
      const DeepCollectionEquality().hash(totalAmount),
      const DeepCollectionEquality().hash(feeDiscountType),
      const DeepCollectionEquality().hash(feeAmountDiscount),
      const DeepCollectionEquality().hash(feeRuleId),
      const DeepCollectionEquality().hash(baseCurrency),
      const DeepCollectionEquality().hash(currency));

  @JsonKey(ignore: true)
  @override
  _$$_MoonpayQuoteDtoCopyWith<_$_MoonpayQuoteDto> get copyWith =>
      __$$_MoonpayQuoteDtoCopyWithImpl<_$_MoonpayQuoteDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoonpayQuoteDtoToJson(
      this,
    );
  }
}

abstract class _MoonpayQuoteDto implements MoonpayQuoteDto {
  const factory _MoonpayQuoteDto(
      {required final String accountId,
      required final String baseCurrencyCode,
      required final double baseCurrencyAmount,
      required final String quoteCurrencyCode,
      required final double quoteCurrencyAmount,
      required final double quoteCurrencyPrice,
      required final double feeAmount,
      required final double extraFeeAmount,
      required final double extraFeePercentage,
      required final double networkFeeAmount,
      required final bool networkFeeAmountNonRefundable,
      required final double totalAmount,
      required final dynamic feeDiscountType,
      required final dynamic feeAmountDiscount,
      required final String feeRuleId,
      required final MoonpayCurrency baseCurrency,
      required final MoonpayCurrency currency}) = _$_MoonpayQuoteDto;

  factory _MoonpayQuoteDto.fromJson(Map<String, dynamic> json) =
      _$_MoonpayQuoteDto.fromJson;

  @override
  String get accountId;
  @override
  String get baseCurrencyCode;
  @override
  double get baseCurrencyAmount;
  @override
  String get quoteCurrencyCode;
  @override
  double get quoteCurrencyAmount;
  @override
  double get quoteCurrencyPrice;
  @override
  double get feeAmount;
  @override
  double get extraFeeAmount;
  @override
  double get extraFeePercentage;
  @override
  double get networkFeeAmount;
  @override
  bool get networkFeeAmountNonRefundable;
  @override
  double get totalAmount;
  @override
  dynamic get feeDiscountType;
  @override
  dynamic get feeAmountDiscount;
  @override
  String get feeRuleId;
  @override
  MoonpayCurrency get baseCurrency;
  @override
  MoonpayCurrency get currency;
  @override
  @JsonKey(ignore: true)
  _$$_MoonpayQuoteDtoCopyWith<_$_MoonpayQuoteDto> get copyWith =>
      throw _privateConstructorUsedError;
}

MoonpayLimitDto _$MoonpayLimitDtoFromJson(Map<String, dynamic> json) {
  return _MoonpayLimitDto.fromJson(json);
}

/// @nodoc
mixin _$MoonpayLimitDto {
  String get paymentMethod => throw _privateConstructorUsedError;
  MoonpayCurrency get baseCurrency => throw _privateConstructorUsedError;
  MoonpayCurrency get quoteCurrency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoonpayLimitDtoCopyWith<MoonpayLimitDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoonpayLimitDtoCopyWith<$Res> {
  factory $MoonpayLimitDtoCopyWith(
          MoonpayLimitDto value, $Res Function(MoonpayLimitDto) then) =
      _$MoonpayLimitDtoCopyWithImpl<$Res>;
  $Res call(
      {String paymentMethod,
      MoonpayCurrency baseCurrency,
      MoonpayCurrency quoteCurrency});

  $MoonpayCurrencyCopyWith<$Res> get baseCurrency;
  $MoonpayCurrencyCopyWith<$Res> get quoteCurrency;
}

/// @nodoc
class _$MoonpayLimitDtoCopyWithImpl<$Res>
    implements $MoonpayLimitDtoCopyWith<$Res> {
  _$MoonpayLimitDtoCopyWithImpl(this._value, this._then);

  final MoonpayLimitDto _value;
  // ignore: unused_field
  final $Res Function(MoonpayLimitDto) _then;

  @override
  $Res call({
    Object? paymentMethod = freezed,
    Object? baseCurrency = freezed,
    Object? quoteCurrency = freezed,
  }) {
    return _then(_value.copyWith(
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrency: baseCurrency == freezed
          ? _value.baseCurrency
          : baseCurrency // ignore: cast_nullable_to_non_nullable
              as MoonpayCurrency,
      quoteCurrency: quoteCurrency == freezed
          ? _value.quoteCurrency
          : quoteCurrency // ignore: cast_nullable_to_non_nullable
              as MoonpayCurrency,
    ));
  }

  @override
  $MoonpayCurrencyCopyWith<$Res> get baseCurrency {
    return $MoonpayCurrencyCopyWith<$Res>(_value.baseCurrency, (value) {
      return _then(_value.copyWith(baseCurrency: value));
    });
  }

  @override
  $MoonpayCurrencyCopyWith<$Res> get quoteCurrency {
    return $MoonpayCurrencyCopyWith<$Res>(_value.quoteCurrency, (value) {
      return _then(_value.copyWith(quoteCurrency: value));
    });
  }
}

/// @nodoc
abstract class _$$_MoonpayLimitDtoCopyWith<$Res>
    implements $MoonpayLimitDtoCopyWith<$Res> {
  factory _$$_MoonpayLimitDtoCopyWith(
          _$_MoonpayLimitDto value, $Res Function(_$_MoonpayLimitDto) then) =
      __$$_MoonpayLimitDtoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String paymentMethod,
      MoonpayCurrency baseCurrency,
      MoonpayCurrency quoteCurrency});

  @override
  $MoonpayCurrencyCopyWith<$Res> get baseCurrency;
  @override
  $MoonpayCurrencyCopyWith<$Res> get quoteCurrency;
}

/// @nodoc
class __$$_MoonpayLimitDtoCopyWithImpl<$Res>
    extends _$MoonpayLimitDtoCopyWithImpl<$Res>
    implements _$$_MoonpayLimitDtoCopyWith<$Res> {
  __$$_MoonpayLimitDtoCopyWithImpl(
      _$_MoonpayLimitDto _value, $Res Function(_$_MoonpayLimitDto) _then)
      : super(_value, (v) => _then(v as _$_MoonpayLimitDto));

  @override
  _$_MoonpayLimitDto get _value => super._value as _$_MoonpayLimitDto;

  @override
  $Res call({
    Object? paymentMethod = freezed,
    Object? baseCurrency = freezed,
    Object? quoteCurrency = freezed,
  }) {
    return _then(_$_MoonpayLimitDto(
      paymentMethod: paymentMethod == freezed
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      baseCurrency: baseCurrency == freezed
          ? _value.baseCurrency
          : baseCurrency // ignore: cast_nullable_to_non_nullable
              as MoonpayCurrency,
      quoteCurrency: quoteCurrency == freezed
          ? _value.quoteCurrency
          : quoteCurrency // ignore: cast_nullable_to_non_nullable
              as MoonpayCurrency,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoonpayLimitDto implements _MoonpayLimitDto {
  const _$_MoonpayLimitDto(
      {required this.paymentMethod,
      required this.baseCurrency,
      required this.quoteCurrency});

  factory _$_MoonpayLimitDto.fromJson(Map<String, dynamic> json) =>
      _$$_MoonpayLimitDtoFromJson(json);

  @override
  final String paymentMethod;
  @override
  final MoonpayCurrency baseCurrency;
  @override
  final MoonpayCurrency quoteCurrency;

  @override
  String toString() {
    return 'MoonpayLimitDto(paymentMethod: $paymentMethod, baseCurrency: $baseCurrency, quoteCurrency: $quoteCurrency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoonpayLimitDto &&
            const DeepCollectionEquality()
                .equals(other.paymentMethod, paymentMethod) &&
            const DeepCollectionEquality()
                .equals(other.baseCurrency, baseCurrency) &&
            const DeepCollectionEquality()
                .equals(other.quoteCurrency, quoteCurrency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(paymentMethod),
      const DeepCollectionEquality().hash(baseCurrency),
      const DeepCollectionEquality().hash(quoteCurrency));

  @JsonKey(ignore: true)
  @override
  _$$_MoonpayLimitDtoCopyWith<_$_MoonpayLimitDto> get copyWith =>
      __$$_MoonpayLimitDtoCopyWithImpl<_$_MoonpayLimitDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoonpayLimitDtoToJson(
      this,
    );
  }
}

abstract class _MoonpayLimitDto implements MoonpayLimitDto {
  const factory _MoonpayLimitDto(
      {required final String paymentMethod,
      required final MoonpayCurrency baseCurrency,
      required final MoonpayCurrency quoteCurrency}) = _$_MoonpayLimitDto;

  factory _MoonpayLimitDto.fromJson(Map<String, dynamic> json) =
      _$_MoonpayLimitDto.fromJson;

  @override
  String get paymentMethod;
  @override
  MoonpayCurrency get baseCurrency;
  @override
  MoonpayCurrency get quoteCurrency;
  @override
  @JsonKey(ignore: true)
  _$$_MoonpayLimitDtoCopyWith<_$_MoonpayLimitDto> get copyWith =>
      throw _privateConstructorUsedError;
}

MoonpayCurrency _$MoonpayCurrencyFromJson(Map<String, dynamic> json) {
  return _MoonpayCurrency.fromJson(json);
}

/// @nodoc
mixin _$MoonpayCurrency {
  String get code => throw _privateConstructorUsedError;
  int get minBuyAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoonpayCurrencyCopyWith<MoonpayCurrency> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoonpayCurrencyCopyWith<$Res> {
  factory $MoonpayCurrencyCopyWith(
          MoonpayCurrency value, $Res Function(MoonpayCurrency) then) =
      _$MoonpayCurrencyCopyWithImpl<$Res>;
  $Res call({String code, int minBuyAmount});
}

/// @nodoc
class _$MoonpayCurrencyCopyWithImpl<$Res>
    implements $MoonpayCurrencyCopyWith<$Res> {
  _$MoonpayCurrencyCopyWithImpl(this._value, this._then);

  final MoonpayCurrency _value;
  // ignore: unused_field
  final $Res Function(MoonpayCurrency) _then;

  @override
  $Res call({
    Object? code = freezed,
    Object? minBuyAmount = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      minBuyAmount: minBuyAmount == freezed
          ? _value.minBuyAmount
          : minBuyAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_MoonpayCurrencyCopyWith<$Res>
    implements $MoonpayCurrencyCopyWith<$Res> {
  factory _$$_MoonpayCurrencyCopyWith(
          _$_MoonpayCurrency value, $Res Function(_$_MoonpayCurrency) then) =
      __$$_MoonpayCurrencyCopyWithImpl<$Res>;
  @override
  $Res call({String code, int minBuyAmount});
}

/// @nodoc
class __$$_MoonpayCurrencyCopyWithImpl<$Res>
    extends _$MoonpayCurrencyCopyWithImpl<$Res>
    implements _$$_MoonpayCurrencyCopyWith<$Res> {
  __$$_MoonpayCurrencyCopyWithImpl(
      _$_MoonpayCurrency _value, $Res Function(_$_MoonpayCurrency) _then)
      : super(_value, (v) => _then(v as _$_MoonpayCurrency));

  @override
  _$_MoonpayCurrency get _value => super._value as _$_MoonpayCurrency;

  @override
  $Res call({
    Object? code = freezed,
    Object? minBuyAmount = freezed,
  }) {
    return _then(_$_MoonpayCurrency(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      minBuyAmount: minBuyAmount == freezed
          ? _value.minBuyAmount
          : minBuyAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoonpayCurrency implements _MoonpayCurrency {
  const _$_MoonpayCurrency({required this.code, required this.minBuyAmount});

  factory _$_MoonpayCurrency.fromJson(Map<String, dynamic> json) =>
      _$$_MoonpayCurrencyFromJson(json);

  @override
  final String code;
  @override
  final int minBuyAmount;

  @override
  String toString() {
    return 'MoonpayCurrency(code: $code, minBuyAmount: $minBuyAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoonpayCurrency &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality()
                .equals(other.minBuyAmount, minBuyAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(minBuyAmount));

  @JsonKey(ignore: true)
  @override
  _$$_MoonpayCurrencyCopyWith<_$_MoonpayCurrency> get copyWith =>
      __$$_MoonpayCurrencyCopyWithImpl<_$_MoonpayCurrency>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoonpayCurrencyToJson(
      this,
    );
  }
}

abstract class _MoonpayCurrency implements MoonpayCurrency {
  const factory _MoonpayCurrency(
      {required final String code,
      required final int minBuyAmount}) = _$_MoonpayCurrency;

  factory _MoonpayCurrency.fromJson(Map<String, dynamic> json) =
      _$_MoonpayCurrency.fromJson;

  @override
  String get code;
  @override
  int get minBuyAmount;
  @override
  @JsonKey(ignore: true)
  _$$_MoonpayCurrencyCopyWith<_$_MoonpayCurrency> get copyWith =>
      throw _privateConstructorUsedError;
}
