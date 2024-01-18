// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DlnQuoteRequestDto _$DlnQuoteRequestDtoFromJson(Map<String, dynamic> json) {
  return _DlnQuoteRequestDto.fromJson(json);
}

/// @nodoc
mixin _$DlnQuoteRequestDto {
  String get srcChainId => throw _privateConstructorUsedError;
  String get srcChainTokenIn => throw _privateConstructorUsedError;
  String get srcChainTokenInAmount => throw _privateConstructorUsedError;
  String get dstChainId => throw _privateConstructorUsedError;
  String get dstChainTokenOut => throw _privateConstructorUsedError;
  String? get dstChainTokenOutAmount => throw _privateConstructorUsedError;
  int? get additionalTakerRewardBps => throw _privateConstructorUsedError;
  String? get srcIntermediaryTokenAddress => throw _privateConstructorUsedError;
  String? get dstIntermediaryTokenAddress => throw _privateConstructorUsedError;
  String? get dstIntermediaryTokenSpenderAddress =>
      throw _privateConstructorUsedError;
  int? get intermediaryTokenUSDPrice => throw _privateConstructorUsedError;
  int? get slippage => throw _privateConstructorUsedError;
  double? get affiliateFeePercent => throw _privateConstructorUsedError;
  bool? get prependOperatingExpenses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DlnQuoteRequestDtoCopyWith<DlnQuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DlnQuoteRequestDtoCopyWith<$Res> {
  factory $DlnQuoteRequestDtoCopyWith(
          DlnQuoteRequestDto value, $Res Function(DlnQuoteRequestDto) then) =
      _$DlnQuoteRequestDtoCopyWithImpl<$Res, DlnQuoteRequestDto>;
  @useResult
  $Res call(
      {String srcChainId,
      String srcChainTokenIn,
      String srcChainTokenInAmount,
      String dstChainId,
      String dstChainTokenOut,
      String? dstChainTokenOutAmount,
      int? additionalTakerRewardBps,
      String? srcIntermediaryTokenAddress,
      String? dstIntermediaryTokenAddress,
      String? dstIntermediaryTokenSpenderAddress,
      int? intermediaryTokenUSDPrice,
      int? slippage,
      double? affiliateFeePercent,
      bool? prependOperatingExpenses});
}

/// @nodoc
class _$DlnQuoteRequestDtoCopyWithImpl<$Res, $Val extends DlnQuoteRequestDto>
    implements $DlnQuoteRequestDtoCopyWith<$Res> {
  _$DlnQuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcChainId = null,
    Object? srcChainTokenIn = null,
    Object? srcChainTokenInAmount = null,
    Object? dstChainId = null,
    Object? dstChainTokenOut = null,
    Object? dstChainTokenOutAmount = freezed,
    Object? additionalTakerRewardBps = freezed,
    Object? srcIntermediaryTokenAddress = freezed,
    Object? dstIntermediaryTokenAddress = freezed,
    Object? dstIntermediaryTokenSpenderAddress = freezed,
    Object? intermediaryTokenUSDPrice = freezed,
    Object? slippage = freezed,
    Object? affiliateFeePercent = freezed,
    Object? prependOperatingExpenses = freezed,
  }) {
    return _then(_value.copyWith(
      srcChainId: null == srcChainId
          ? _value.srcChainId
          : srcChainId // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainTokenIn: null == srcChainTokenIn
          ? _value.srcChainTokenIn
          : srcChainTokenIn // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainTokenInAmount: null == srcChainTokenInAmount
          ? _value.srcChainTokenInAmount
          : srcChainTokenInAmount // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainId: null == dstChainId
          ? _value.dstChainId
          : dstChainId // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOut: null == dstChainTokenOut
          ? _value.dstChainTokenOut
          : dstChainTokenOut // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOutAmount: freezed == dstChainTokenOutAmount
          ? _value.dstChainTokenOutAmount
          : dstChainTokenOutAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalTakerRewardBps: freezed == additionalTakerRewardBps
          ? _value.additionalTakerRewardBps
          : additionalTakerRewardBps // ignore: cast_nullable_to_non_nullable
              as int?,
      srcIntermediaryTokenAddress: freezed == srcIntermediaryTokenAddress
          ? _value.srcIntermediaryTokenAddress
          : srcIntermediaryTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      dstIntermediaryTokenAddress: freezed == dstIntermediaryTokenAddress
          ? _value.dstIntermediaryTokenAddress
          : dstIntermediaryTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      dstIntermediaryTokenSpenderAddress: freezed ==
              dstIntermediaryTokenSpenderAddress
          ? _value.dstIntermediaryTokenSpenderAddress
          : dstIntermediaryTokenSpenderAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      intermediaryTokenUSDPrice: freezed == intermediaryTokenUSDPrice
          ? _value.intermediaryTokenUSDPrice
          : intermediaryTokenUSDPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      slippage: freezed == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as int?,
      affiliateFeePercent: freezed == affiliateFeePercent
          ? _value.affiliateFeePercent
          : affiliateFeePercent // ignore: cast_nullable_to_non_nullable
              as double?,
      prependOperatingExpenses: freezed == prependOperatingExpenses
          ? _value.prependOperatingExpenses
          : prependOperatingExpenses // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DlnQuoteRequestDtoImplCopyWith<$Res>
    implements $DlnQuoteRequestDtoCopyWith<$Res> {
  factory _$$DlnQuoteRequestDtoImplCopyWith(_$DlnQuoteRequestDtoImpl value,
          $Res Function(_$DlnQuoteRequestDtoImpl) then) =
      __$$DlnQuoteRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String srcChainId,
      String srcChainTokenIn,
      String srcChainTokenInAmount,
      String dstChainId,
      String dstChainTokenOut,
      String? dstChainTokenOutAmount,
      int? additionalTakerRewardBps,
      String? srcIntermediaryTokenAddress,
      String? dstIntermediaryTokenAddress,
      String? dstIntermediaryTokenSpenderAddress,
      int? intermediaryTokenUSDPrice,
      int? slippage,
      double? affiliateFeePercent,
      bool? prependOperatingExpenses});
}

/// @nodoc
class __$$DlnQuoteRequestDtoImplCopyWithImpl<$Res>
    extends _$DlnQuoteRequestDtoCopyWithImpl<$Res, _$DlnQuoteRequestDtoImpl>
    implements _$$DlnQuoteRequestDtoImplCopyWith<$Res> {
  __$$DlnQuoteRequestDtoImplCopyWithImpl(_$DlnQuoteRequestDtoImpl _value,
      $Res Function(_$DlnQuoteRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcChainId = null,
    Object? srcChainTokenIn = null,
    Object? srcChainTokenInAmount = null,
    Object? dstChainId = null,
    Object? dstChainTokenOut = null,
    Object? dstChainTokenOutAmount = freezed,
    Object? additionalTakerRewardBps = freezed,
    Object? srcIntermediaryTokenAddress = freezed,
    Object? dstIntermediaryTokenAddress = freezed,
    Object? dstIntermediaryTokenSpenderAddress = freezed,
    Object? intermediaryTokenUSDPrice = freezed,
    Object? slippage = freezed,
    Object? affiliateFeePercent = freezed,
    Object? prependOperatingExpenses = freezed,
  }) {
    return _then(_$DlnQuoteRequestDtoImpl(
      srcChainId: null == srcChainId
          ? _value.srcChainId
          : srcChainId // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainTokenIn: null == srcChainTokenIn
          ? _value.srcChainTokenIn
          : srcChainTokenIn // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainTokenInAmount: null == srcChainTokenInAmount
          ? _value.srcChainTokenInAmount
          : srcChainTokenInAmount // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainId: null == dstChainId
          ? _value.dstChainId
          : dstChainId // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOut: null == dstChainTokenOut
          ? _value.dstChainTokenOut
          : dstChainTokenOut // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOutAmount: freezed == dstChainTokenOutAmount
          ? _value.dstChainTokenOutAmount
          : dstChainTokenOutAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalTakerRewardBps: freezed == additionalTakerRewardBps
          ? _value.additionalTakerRewardBps
          : additionalTakerRewardBps // ignore: cast_nullable_to_non_nullable
              as int?,
      srcIntermediaryTokenAddress: freezed == srcIntermediaryTokenAddress
          ? _value.srcIntermediaryTokenAddress
          : srcIntermediaryTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      dstIntermediaryTokenAddress: freezed == dstIntermediaryTokenAddress
          ? _value.dstIntermediaryTokenAddress
          : dstIntermediaryTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      dstIntermediaryTokenSpenderAddress: freezed ==
              dstIntermediaryTokenSpenderAddress
          ? _value.dstIntermediaryTokenSpenderAddress
          : dstIntermediaryTokenSpenderAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      intermediaryTokenUSDPrice: freezed == intermediaryTokenUSDPrice
          ? _value.intermediaryTokenUSDPrice
          : intermediaryTokenUSDPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      slippage: freezed == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as int?,
      affiliateFeePercent: freezed == affiliateFeePercent
          ? _value.affiliateFeePercent
          : affiliateFeePercent // ignore: cast_nullable_to_non_nullable
              as double?,
      prependOperatingExpenses: freezed == prependOperatingExpenses
          ? _value.prependOperatingExpenses
          : prependOperatingExpenses // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DlnQuoteRequestDtoImpl implements _DlnQuoteRequestDto {
  const _$DlnQuoteRequestDtoImpl(
      {required this.srcChainId,
      required this.srcChainTokenIn,
      required this.srcChainTokenInAmount,
      required this.dstChainId,
      required this.dstChainTokenOut,
      this.dstChainTokenOutAmount,
      this.additionalTakerRewardBps,
      this.srcIntermediaryTokenAddress,
      this.dstIntermediaryTokenAddress,
      this.dstIntermediaryTokenSpenderAddress,
      this.intermediaryTokenUSDPrice,
      this.slippage,
      this.affiliateFeePercent,
      this.prependOperatingExpenses});

  factory _$DlnQuoteRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DlnQuoteRequestDtoImplFromJson(json);

  @override
  final String srcChainId;
  @override
  final String srcChainTokenIn;
  @override
  final String srcChainTokenInAmount;
  @override
  final String dstChainId;
  @override
  final String dstChainTokenOut;
  @override
  final String? dstChainTokenOutAmount;
  @override
  final int? additionalTakerRewardBps;
  @override
  final String? srcIntermediaryTokenAddress;
  @override
  final String? dstIntermediaryTokenAddress;
  @override
  final String? dstIntermediaryTokenSpenderAddress;
  @override
  final int? intermediaryTokenUSDPrice;
  @override
  final int? slippage;
  @override
  final double? affiliateFeePercent;
  @override
  final bool? prependOperatingExpenses;

  @override
  String toString() {
    return 'DlnQuoteRequestDto(srcChainId: $srcChainId, srcChainTokenIn: $srcChainTokenIn, srcChainTokenInAmount: $srcChainTokenInAmount, dstChainId: $dstChainId, dstChainTokenOut: $dstChainTokenOut, dstChainTokenOutAmount: $dstChainTokenOutAmount, additionalTakerRewardBps: $additionalTakerRewardBps, srcIntermediaryTokenAddress: $srcIntermediaryTokenAddress, dstIntermediaryTokenAddress: $dstIntermediaryTokenAddress, dstIntermediaryTokenSpenderAddress: $dstIntermediaryTokenSpenderAddress, intermediaryTokenUSDPrice: $intermediaryTokenUSDPrice, slippage: $slippage, affiliateFeePercent: $affiliateFeePercent, prependOperatingExpenses: $prependOperatingExpenses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DlnQuoteRequestDtoImpl &&
            (identical(other.srcChainId, srcChainId) ||
                other.srcChainId == srcChainId) &&
            (identical(other.srcChainTokenIn, srcChainTokenIn) ||
                other.srcChainTokenIn == srcChainTokenIn) &&
            (identical(other.srcChainTokenInAmount, srcChainTokenInAmount) ||
                other.srcChainTokenInAmount == srcChainTokenInAmount) &&
            (identical(other.dstChainId, dstChainId) ||
                other.dstChainId == dstChainId) &&
            (identical(other.dstChainTokenOut, dstChainTokenOut) ||
                other.dstChainTokenOut == dstChainTokenOut) &&
            (identical(other.dstChainTokenOutAmount, dstChainTokenOutAmount) ||
                other.dstChainTokenOutAmount == dstChainTokenOutAmount) &&
            (identical(other.additionalTakerRewardBps, additionalTakerRewardBps) ||
                other.additionalTakerRewardBps == additionalTakerRewardBps) &&
            (identical(other.srcIntermediaryTokenAddress,
                    srcIntermediaryTokenAddress) ||
                other.srcIntermediaryTokenAddress ==
                    srcIntermediaryTokenAddress) &&
            (identical(other.dstIntermediaryTokenAddress,
                    dstIntermediaryTokenAddress) ||
                other.dstIntermediaryTokenAddress ==
                    dstIntermediaryTokenAddress) &&
            (identical(other.dstIntermediaryTokenSpenderAddress,
                    dstIntermediaryTokenSpenderAddress) ||
                other.dstIntermediaryTokenSpenderAddress ==
                    dstIntermediaryTokenSpenderAddress) &&
            (identical(other.intermediaryTokenUSDPrice,
                    intermediaryTokenUSDPrice) ||
                other.intermediaryTokenUSDPrice == intermediaryTokenUSDPrice) &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
            (identical(other.affiliateFeePercent, affiliateFeePercent) ||
                other.affiliateFeePercent == affiliateFeePercent) &&
            (identical(other.prependOperatingExpenses, prependOperatingExpenses) ||
                other.prependOperatingExpenses == prependOperatingExpenses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      srcChainId,
      srcChainTokenIn,
      srcChainTokenInAmount,
      dstChainId,
      dstChainTokenOut,
      dstChainTokenOutAmount,
      additionalTakerRewardBps,
      srcIntermediaryTokenAddress,
      dstIntermediaryTokenAddress,
      dstIntermediaryTokenSpenderAddress,
      intermediaryTokenUSDPrice,
      slippage,
      affiliateFeePercent,
      prependOperatingExpenses);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DlnQuoteRequestDtoImplCopyWith<_$DlnQuoteRequestDtoImpl> get copyWith =>
      __$$DlnQuoteRequestDtoImplCopyWithImpl<_$DlnQuoteRequestDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DlnQuoteRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _DlnQuoteRequestDto implements DlnQuoteRequestDto {
  const factory _DlnQuoteRequestDto(
      {required final String srcChainId,
      required final String srcChainTokenIn,
      required final String srcChainTokenInAmount,
      required final String dstChainId,
      required final String dstChainTokenOut,
      final String? dstChainTokenOutAmount,
      final int? additionalTakerRewardBps,
      final String? srcIntermediaryTokenAddress,
      final String? dstIntermediaryTokenAddress,
      final String? dstIntermediaryTokenSpenderAddress,
      final int? intermediaryTokenUSDPrice,
      final int? slippage,
      final double? affiliateFeePercent,
      final bool? prependOperatingExpenses}) = _$DlnQuoteRequestDtoImpl;

  factory _DlnQuoteRequestDto.fromJson(Map<String, dynamic> json) =
      _$DlnQuoteRequestDtoImpl.fromJson;

  @override
  String get srcChainId;
  @override
  String get srcChainTokenIn;
  @override
  String get srcChainTokenInAmount;
  @override
  String get dstChainId;
  @override
  String get dstChainTokenOut;
  @override
  String? get dstChainTokenOutAmount;
  @override
  int? get additionalTakerRewardBps;
  @override
  String? get srcIntermediaryTokenAddress;
  @override
  String? get dstIntermediaryTokenAddress;
  @override
  String? get dstIntermediaryTokenSpenderAddress;
  @override
  int? get intermediaryTokenUSDPrice;
  @override
  int? get slippage;
  @override
  double? get affiliateFeePercent;
  @override
  bool? get prependOperatingExpenses;
  @override
  @JsonKey(ignore: true)
  _$$DlnQuoteRequestDtoImplCopyWith<_$DlnQuoteRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DlnQuoteResponseDto _$DlnQuoteResponseDtoFromJson(Map<String, dynamic> json) {
  return _DlnQuoteResponseDto.fromJson(json);
}

/// @nodoc
mixin _$DlnQuoteResponseDto {
  OrderEstimation get estimation => throw _privateConstructorUsedError;
  String? get prependedOperatingExpenseCost =>
      throw _privateConstructorUsedError;
  TxQuote? get tx => throw _privateConstructorUsedError;
  Order get order => throw _privateConstructorUsedError;
  String get fixFee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DlnQuoteResponseDtoCopyWith<DlnQuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DlnQuoteResponseDtoCopyWith<$Res> {
  factory $DlnQuoteResponseDtoCopyWith(
          DlnQuoteResponseDto value, $Res Function(DlnQuoteResponseDto) then) =
      _$DlnQuoteResponseDtoCopyWithImpl<$Res, DlnQuoteResponseDto>;
  @useResult
  $Res call(
      {OrderEstimation estimation,
      String? prependedOperatingExpenseCost,
      TxQuote? tx,
      Order order,
      String fixFee});

  $OrderEstimationCopyWith<$Res> get estimation;
  $TxQuoteCopyWith<$Res>? get tx;
  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class _$DlnQuoteResponseDtoCopyWithImpl<$Res, $Val extends DlnQuoteResponseDto>
    implements $DlnQuoteResponseDtoCopyWith<$Res> {
  _$DlnQuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? estimation = null,
    Object? prependedOperatingExpenseCost = freezed,
    Object? tx = freezed,
    Object? order = null,
    Object? fixFee = null,
  }) {
    return _then(_value.copyWith(
      estimation: null == estimation
          ? _value.estimation
          : estimation // ignore: cast_nullable_to_non_nullable
              as OrderEstimation,
      prependedOperatingExpenseCost: freezed == prependedOperatingExpenseCost
          ? _value.prependedOperatingExpenseCost
          : prependedOperatingExpenseCost // ignore: cast_nullable_to_non_nullable
              as String?,
      tx: freezed == tx
          ? _value.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as TxQuote?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
      fixFee: null == fixFee
          ? _value.fixFee
          : fixFee // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderEstimationCopyWith<$Res> get estimation {
    return $OrderEstimationCopyWith<$Res>(_value.estimation, (value) {
      return _then(_value.copyWith(estimation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TxQuoteCopyWith<$Res>? get tx {
    if (_value.tx == null) {
      return null;
    }

    return $TxQuoteCopyWith<$Res>(_value.tx!, (value) {
      return _then(_value.copyWith(tx: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderCopyWith<$Res> get order {
    return $OrderCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DlnQuoteResponseDtoImplCopyWith<$Res>
    implements $DlnQuoteResponseDtoCopyWith<$Res> {
  factory _$$DlnQuoteResponseDtoImplCopyWith(_$DlnQuoteResponseDtoImpl value,
          $Res Function(_$DlnQuoteResponseDtoImpl) then) =
      __$$DlnQuoteResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OrderEstimation estimation,
      String? prependedOperatingExpenseCost,
      TxQuote? tx,
      Order order,
      String fixFee});

  @override
  $OrderEstimationCopyWith<$Res> get estimation;
  @override
  $TxQuoteCopyWith<$Res>? get tx;
  @override
  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class __$$DlnQuoteResponseDtoImplCopyWithImpl<$Res>
    extends _$DlnQuoteResponseDtoCopyWithImpl<$Res, _$DlnQuoteResponseDtoImpl>
    implements _$$DlnQuoteResponseDtoImplCopyWith<$Res> {
  __$$DlnQuoteResponseDtoImplCopyWithImpl(_$DlnQuoteResponseDtoImpl _value,
      $Res Function(_$DlnQuoteResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? estimation = null,
    Object? prependedOperatingExpenseCost = freezed,
    Object? tx = freezed,
    Object? order = null,
    Object? fixFee = null,
  }) {
    return _then(_$DlnQuoteResponseDtoImpl(
      estimation: null == estimation
          ? _value.estimation
          : estimation // ignore: cast_nullable_to_non_nullable
              as OrderEstimation,
      prependedOperatingExpenseCost: freezed == prependedOperatingExpenseCost
          ? _value.prependedOperatingExpenseCost
          : prependedOperatingExpenseCost // ignore: cast_nullable_to_non_nullable
              as String?,
      tx: freezed == tx
          ? _value.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as TxQuote?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
      fixFee: null == fixFee
          ? _value.fixFee
          : fixFee // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DlnQuoteResponseDtoImpl implements _DlnQuoteResponseDto {
  const _$DlnQuoteResponseDtoImpl(
      {required this.estimation,
      this.prependedOperatingExpenseCost,
      this.tx,
      required this.order,
      required this.fixFee});

  factory _$DlnQuoteResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DlnQuoteResponseDtoImplFromJson(json);

  @override
  final OrderEstimation estimation;
  @override
  final String? prependedOperatingExpenseCost;
  @override
  final TxQuote? tx;
  @override
  final Order order;
  @override
  final String fixFee;

  @override
  String toString() {
    return 'DlnQuoteResponseDto(estimation: $estimation, prependedOperatingExpenseCost: $prependedOperatingExpenseCost, tx: $tx, order: $order, fixFee: $fixFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DlnQuoteResponseDtoImpl &&
            (identical(other.estimation, estimation) ||
                other.estimation == estimation) &&
            (identical(other.prependedOperatingExpenseCost,
                    prependedOperatingExpenseCost) ||
                other.prependedOperatingExpenseCost ==
                    prependedOperatingExpenseCost) &&
            (identical(other.tx, tx) || other.tx == tx) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.fixFee, fixFee) || other.fixFee == fixFee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, estimation,
      prependedOperatingExpenseCost, tx, order, fixFee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DlnQuoteResponseDtoImplCopyWith<_$DlnQuoteResponseDtoImpl> get copyWith =>
      __$$DlnQuoteResponseDtoImplCopyWithImpl<_$DlnQuoteResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DlnQuoteResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _DlnQuoteResponseDto implements DlnQuoteResponseDto {
  const factory _DlnQuoteResponseDto(
      {required final OrderEstimation estimation,
      final String? prependedOperatingExpenseCost,
      final TxQuote? tx,
      required final Order order,
      required final String fixFee}) = _$DlnQuoteResponseDtoImpl;

  factory _DlnQuoteResponseDto.fromJson(Map<String, dynamic> json) =
      _$DlnQuoteResponseDtoImpl.fromJson;

  @override
  OrderEstimation get estimation;
  @override
  String? get prependedOperatingExpenseCost;
  @override
  TxQuote? get tx;
  @override
  Order get order;
  @override
  String get fixFee;
  @override
  @JsonKey(ignore: true)
  _$$DlnQuoteResponseDtoImplCopyWith<_$DlnQuoteResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateTxRequestDto _$CreateTxRequestDtoFromJson(Map<String, dynamic> json) {
  return _CreateTxRequestDto.fromJson(json);
}

/// @nodoc
mixin _$CreateTxRequestDto {
  String get srcChainId => throw _privateConstructorUsedError;
  String get srcChainTokenIn => throw _privateConstructorUsedError;
  String get srcChainTokenInAmount => throw _privateConstructorUsedError;
  String get dstChainId => throw _privateConstructorUsedError;
  String get dstChainTokenOut => throw _privateConstructorUsedError;
  String get dstChainTokenOutRecipient => throw _privateConstructorUsedError;
  String get srcChainOrderAuthorityAddress =>
      throw _privateConstructorUsedError;
  String get dstChainOrderAuthorityAddress =>
      throw _privateConstructorUsedError;
  String? get dstChainTokenOutAmount => throw _privateConstructorUsedError;
  double? get additionalTakerRewardBps => throw _privateConstructorUsedError;
  String? get srcIntermediaryTokenAddress => throw _privateConstructorUsedError;
  String? get dstIntermediaryTokenAddress => throw _privateConstructorUsedError;
  String? get dstIntermediaryTokenSpenderAddress =>
      throw _privateConstructorUsedError;
  double? get intermediaryTokenUSDPrice => throw _privateConstructorUsedError;
  double? get slippage => throw _privateConstructorUsedError;
  String? get senderAddress => throw _privateConstructorUsedError;
  double? get referralCode => throw _privateConstructorUsedError;
  double? get affiliateFeePercent => throw _privateConstructorUsedError;
  String? get affiliateFeeRecipient => throw _privateConstructorUsedError;
  String? get srcChainTokenInSenderPermit => throw _privateConstructorUsedError;
  bool? get enableEstimate => throw _privateConstructorUsedError;
  String? get allowedTaker => throw _privateConstructorUsedError;
  String? get externalCall => throw _privateConstructorUsedError;
  bool? get prependOperatingExpenses => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateTxRequestDtoCopyWith<CreateTxRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTxRequestDtoCopyWith<$Res> {
  factory $CreateTxRequestDtoCopyWith(
          CreateTxRequestDto value, $Res Function(CreateTxRequestDto) then) =
      _$CreateTxRequestDtoCopyWithImpl<$Res, CreateTxRequestDto>;
  @useResult
  $Res call(
      {String srcChainId,
      String srcChainTokenIn,
      String srcChainTokenInAmount,
      String dstChainId,
      String dstChainTokenOut,
      String dstChainTokenOutRecipient,
      String srcChainOrderAuthorityAddress,
      String dstChainOrderAuthorityAddress,
      String? dstChainTokenOutAmount,
      double? additionalTakerRewardBps,
      String? srcIntermediaryTokenAddress,
      String? dstIntermediaryTokenAddress,
      String? dstIntermediaryTokenSpenderAddress,
      double? intermediaryTokenUSDPrice,
      double? slippage,
      String? senderAddress,
      double? referralCode,
      double? affiliateFeePercent,
      String? affiliateFeeRecipient,
      String? srcChainTokenInSenderPermit,
      bool? enableEstimate,
      String? allowedTaker,
      String? externalCall,
      bool? prependOperatingExpenses});
}

/// @nodoc
class _$CreateTxRequestDtoCopyWithImpl<$Res, $Val extends CreateTxRequestDto>
    implements $CreateTxRequestDtoCopyWith<$Res> {
  _$CreateTxRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcChainId = null,
    Object? srcChainTokenIn = null,
    Object? srcChainTokenInAmount = null,
    Object? dstChainId = null,
    Object? dstChainTokenOut = null,
    Object? dstChainTokenOutRecipient = null,
    Object? srcChainOrderAuthorityAddress = null,
    Object? dstChainOrderAuthorityAddress = null,
    Object? dstChainTokenOutAmount = freezed,
    Object? additionalTakerRewardBps = freezed,
    Object? srcIntermediaryTokenAddress = freezed,
    Object? dstIntermediaryTokenAddress = freezed,
    Object? dstIntermediaryTokenSpenderAddress = freezed,
    Object? intermediaryTokenUSDPrice = freezed,
    Object? slippage = freezed,
    Object? senderAddress = freezed,
    Object? referralCode = freezed,
    Object? affiliateFeePercent = freezed,
    Object? affiliateFeeRecipient = freezed,
    Object? srcChainTokenInSenderPermit = freezed,
    Object? enableEstimate = freezed,
    Object? allowedTaker = freezed,
    Object? externalCall = freezed,
    Object? prependOperatingExpenses = freezed,
  }) {
    return _then(_value.copyWith(
      srcChainId: null == srcChainId
          ? _value.srcChainId
          : srcChainId // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainTokenIn: null == srcChainTokenIn
          ? _value.srcChainTokenIn
          : srcChainTokenIn // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainTokenInAmount: null == srcChainTokenInAmount
          ? _value.srcChainTokenInAmount
          : srcChainTokenInAmount // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainId: null == dstChainId
          ? _value.dstChainId
          : dstChainId // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOut: null == dstChainTokenOut
          ? _value.dstChainTokenOut
          : dstChainTokenOut // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOutRecipient: null == dstChainTokenOutRecipient
          ? _value.dstChainTokenOutRecipient
          : dstChainTokenOutRecipient // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainOrderAuthorityAddress: null == srcChainOrderAuthorityAddress
          ? _value.srcChainOrderAuthorityAddress
          : srcChainOrderAuthorityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainOrderAuthorityAddress: null == dstChainOrderAuthorityAddress
          ? _value.dstChainOrderAuthorityAddress
          : dstChainOrderAuthorityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOutAmount: freezed == dstChainTokenOutAmount
          ? _value.dstChainTokenOutAmount
          : dstChainTokenOutAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalTakerRewardBps: freezed == additionalTakerRewardBps
          ? _value.additionalTakerRewardBps
          : additionalTakerRewardBps // ignore: cast_nullable_to_non_nullable
              as double?,
      srcIntermediaryTokenAddress: freezed == srcIntermediaryTokenAddress
          ? _value.srcIntermediaryTokenAddress
          : srcIntermediaryTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      dstIntermediaryTokenAddress: freezed == dstIntermediaryTokenAddress
          ? _value.dstIntermediaryTokenAddress
          : dstIntermediaryTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      dstIntermediaryTokenSpenderAddress: freezed ==
              dstIntermediaryTokenSpenderAddress
          ? _value.dstIntermediaryTokenSpenderAddress
          : dstIntermediaryTokenSpenderAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      intermediaryTokenUSDPrice: freezed == intermediaryTokenUSDPrice
          ? _value.intermediaryTokenUSDPrice
          : intermediaryTokenUSDPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      slippage: freezed == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as double?,
      senderAddress: freezed == senderAddress
          ? _value.senderAddress
          : senderAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as double?,
      affiliateFeePercent: freezed == affiliateFeePercent
          ? _value.affiliateFeePercent
          : affiliateFeePercent // ignore: cast_nullable_to_non_nullable
              as double?,
      affiliateFeeRecipient: freezed == affiliateFeeRecipient
          ? _value.affiliateFeeRecipient
          : affiliateFeeRecipient // ignore: cast_nullable_to_non_nullable
              as String?,
      srcChainTokenInSenderPermit: freezed == srcChainTokenInSenderPermit
          ? _value.srcChainTokenInSenderPermit
          : srcChainTokenInSenderPermit // ignore: cast_nullable_to_non_nullable
              as String?,
      enableEstimate: freezed == enableEstimate
          ? _value.enableEstimate
          : enableEstimate // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowedTaker: freezed == allowedTaker
          ? _value.allowedTaker
          : allowedTaker // ignore: cast_nullable_to_non_nullable
              as String?,
      externalCall: freezed == externalCall
          ? _value.externalCall
          : externalCall // ignore: cast_nullable_to_non_nullable
              as String?,
      prependOperatingExpenses: freezed == prependOperatingExpenses
          ? _value.prependOperatingExpenses
          : prependOperatingExpenses // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateTxRequestDtoImplCopyWith<$Res>
    implements $CreateTxRequestDtoCopyWith<$Res> {
  factory _$$CreateTxRequestDtoImplCopyWith(_$CreateTxRequestDtoImpl value,
          $Res Function(_$CreateTxRequestDtoImpl) then) =
      __$$CreateTxRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String srcChainId,
      String srcChainTokenIn,
      String srcChainTokenInAmount,
      String dstChainId,
      String dstChainTokenOut,
      String dstChainTokenOutRecipient,
      String srcChainOrderAuthorityAddress,
      String dstChainOrderAuthorityAddress,
      String? dstChainTokenOutAmount,
      double? additionalTakerRewardBps,
      String? srcIntermediaryTokenAddress,
      String? dstIntermediaryTokenAddress,
      String? dstIntermediaryTokenSpenderAddress,
      double? intermediaryTokenUSDPrice,
      double? slippage,
      String? senderAddress,
      double? referralCode,
      double? affiliateFeePercent,
      String? affiliateFeeRecipient,
      String? srcChainTokenInSenderPermit,
      bool? enableEstimate,
      String? allowedTaker,
      String? externalCall,
      bool? prependOperatingExpenses});
}

/// @nodoc
class __$$CreateTxRequestDtoImplCopyWithImpl<$Res>
    extends _$CreateTxRequestDtoCopyWithImpl<$Res, _$CreateTxRequestDtoImpl>
    implements _$$CreateTxRequestDtoImplCopyWith<$Res> {
  __$$CreateTxRequestDtoImplCopyWithImpl(_$CreateTxRequestDtoImpl _value,
      $Res Function(_$CreateTxRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcChainId = null,
    Object? srcChainTokenIn = null,
    Object? srcChainTokenInAmount = null,
    Object? dstChainId = null,
    Object? dstChainTokenOut = null,
    Object? dstChainTokenOutRecipient = null,
    Object? srcChainOrderAuthorityAddress = null,
    Object? dstChainOrderAuthorityAddress = null,
    Object? dstChainTokenOutAmount = freezed,
    Object? additionalTakerRewardBps = freezed,
    Object? srcIntermediaryTokenAddress = freezed,
    Object? dstIntermediaryTokenAddress = freezed,
    Object? dstIntermediaryTokenSpenderAddress = freezed,
    Object? intermediaryTokenUSDPrice = freezed,
    Object? slippage = freezed,
    Object? senderAddress = freezed,
    Object? referralCode = freezed,
    Object? affiliateFeePercent = freezed,
    Object? affiliateFeeRecipient = freezed,
    Object? srcChainTokenInSenderPermit = freezed,
    Object? enableEstimate = freezed,
    Object? allowedTaker = freezed,
    Object? externalCall = freezed,
    Object? prependOperatingExpenses = freezed,
  }) {
    return _then(_$CreateTxRequestDtoImpl(
      srcChainId: null == srcChainId
          ? _value.srcChainId
          : srcChainId // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainTokenIn: null == srcChainTokenIn
          ? _value.srcChainTokenIn
          : srcChainTokenIn // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainTokenInAmount: null == srcChainTokenInAmount
          ? _value.srcChainTokenInAmount
          : srcChainTokenInAmount // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainId: null == dstChainId
          ? _value.dstChainId
          : dstChainId // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOut: null == dstChainTokenOut
          ? _value.dstChainTokenOut
          : dstChainTokenOut // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOutRecipient: null == dstChainTokenOutRecipient
          ? _value.dstChainTokenOutRecipient
          : dstChainTokenOutRecipient // ignore: cast_nullable_to_non_nullable
              as String,
      srcChainOrderAuthorityAddress: null == srcChainOrderAuthorityAddress
          ? _value.srcChainOrderAuthorityAddress
          : srcChainOrderAuthorityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainOrderAuthorityAddress: null == dstChainOrderAuthorityAddress
          ? _value.dstChainOrderAuthorityAddress
          : dstChainOrderAuthorityAddress // ignore: cast_nullable_to_non_nullable
              as String,
      dstChainTokenOutAmount: freezed == dstChainTokenOutAmount
          ? _value.dstChainTokenOutAmount
          : dstChainTokenOutAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalTakerRewardBps: freezed == additionalTakerRewardBps
          ? _value.additionalTakerRewardBps
          : additionalTakerRewardBps // ignore: cast_nullable_to_non_nullable
              as double?,
      srcIntermediaryTokenAddress: freezed == srcIntermediaryTokenAddress
          ? _value.srcIntermediaryTokenAddress
          : srcIntermediaryTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      dstIntermediaryTokenAddress: freezed == dstIntermediaryTokenAddress
          ? _value.dstIntermediaryTokenAddress
          : dstIntermediaryTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      dstIntermediaryTokenSpenderAddress: freezed ==
              dstIntermediaryTokenSpenderAddress
          ? _value.dstIntermediaryTokenSpenderAddress
          : dstIntermediaryTokenSpenderAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      intermediaryTokenUSDPrice: freezed == intermediaryTokenUSDPrice
          ? _value.intermediaryTokenUSDPrice
          : intermediaryTokenUSDPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      slippage: freezed == slippage
          ? _value.slippage
          : slippage // ignore: cast_nullable_to_non_nullable
              as double?,
      senderAddress: freezed == senderAddress
          ? _value.senderAddress
          : senderAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as double?,
      affiliateFeePercent: freezed == affiliateFeePercent
          ? _value.affiliateFeePercent
          : affiliateFeePercent // ignore: cast_nullable_to_non_nullable
              as double?,
      affiliateFeeRecipient: freezed == affiliateFeeRecipient
          ? _value.affiliateFeeRecipient
          : affiliateFeeRecipient // ignore: cast_nullable_to_non_nullable
              as String?,
      srcChainTokenInSenderPermit: freezed == srcChainTokenInSenderPermit
          ? _value.srcChainTokenInSenderPermit
          : srcChainTokenInSenderPermit // ignore: cast_nullable_to_non_nullable
              as String?,
      enableEstimate: freezed == enableEstimate
          ? _value.enableEstimate
          : enableEstimate // ignore: cast_nullable_to_non_nullable
              as bool?,
      allowedTaker: freezed == allowedTaker
          ? _value.allowedTaker
          : allowedTaker // ignore: cast_nullable_to_non_nullable
              as String?,
      externalCall: freezed == externalCall
          ? _value.externalCall
          : externalCall // ignore: cast_nullable_to_non_nullable
              as String?,
      prependOperatingExpenses: freezed == prependOperatingExpenses
          ? _value.prependOperatingExpenses
          : prependOperatingExpenses // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTxRequestDtoImpl implements _CreateTxRequestDto {
  const _$CreateTxRequestDtoImpl(
      {required this.srcChainId,
      required this.srcChainTokenIn,
      required this.srcChainTokenInAmount,
      required this.dstChainId,
      required this.dstChainTokenOut,
      required this.dstChainTokenOutRecipient,
      required this.srcChainOrderAuthorityAddress,
      required this.dstChainOrderAuthorityAddress,
      this.dstChainTokenOutAmount,
      this.additionalTakerRewardBps,
      this.srcIntermediaryTokenAddress,
      this.dstIntermediaryTokenAddress,
      this.dstIntermediaryTokenSpenderAddress,
      this.intermediaryTokenUSDPrice,
      this.slippage,
      this.senderAddress,
      this.referralCode,
      this.affiliateFeePercent,
      this.affiliateFeeRecipient,
      this.srcChainTokenInSenderPermit,
      this.enableEstimate,
      this.allowedTaker,
      this.externalCall,
      this.prependOperatingExpenses});

  factory _$CreateTxRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTxRequestDtoImplFromJson(json);

  @override
  final String srcChainId;
  @override
  final String srcChainTokenIn;
  @override
  final String srcChainTokenInAmount;
  @override
  final String dstChainId;
  @override
  final String dstChainTokenOut;
  @override
  final String dstChainTokenOutRecipient;
  @override
  final String srcChainOrderAuthorityAddress;
  @override
  final String dstChainOrderAuthorityAddress;
  @override
  final String? dstChainTokenOutAmount;
  @override
  final double? additionalTakerRewardBps;
  @override
  final String? srcIntermediaryTokenAddress;
  @override
  final String? dstIntermediaryTokenAddress;
  @override
  final String? dstIntermediaryTokenSpenderAddress;
  @override
  final double? intermediaryTokenUSDPrice;
  @override
  final double? slippage;
  @override
  final String? senderAddress;
  @override
  final double? referralCode;
  @override
  final double? affiliateFeePercent;
  @override
  final String? affiliateFeeRecipient;
  @override
  final String? srcChainTokenInSenderPermit;
  @override
  final bool? enableEstimate;
  @override
  final String? allowedTaker;
  @override
  final String? externalCall;
  @override
  final bool? prependOperatingExpenses;

  @override
  String toString() {
    return 'CreateTxRequestDto(srcChainId: $srcChainId, srcChainTokenIn: $srcChainTokenIn, srcChainTokenInAmount: $srcChainTokenInAmount, dstChainId: $dstChainId, dstChainTokenOut: $dstChainTokenOut, dstChainTokenOutRecipient: $dstChainTokenOutRecipient, srcChainOrderAuthorityAddress: $srcChainOrderAuthorityAddress, dstChainOrderAuthorityAddress: $dstChainOrderAuthorityAddress, dstChainTokenOutAmount: $dstChainTokenOutAmount, additionalTakerRewardBps: $additionalTakerRewardBps, srcIntermediaryTokenAddress: $srcIntermediaryTokenAddress, dstIntermediaryTokenAddress: $dstIntermediaryTokenAddress, dstIntermediaryTokenSpenderAddress: $dstIntermediaryTokenSpenderAddress, intermediaryTokenUSDPrice: $intermediaryTokenUSDPrice, slippage: $slippage, senderAddress: $senderAddress, referralCode: $referralCode, affiliateFeePercent: $affiliateFeePercent, affiliateFeeRecipient: $affiliateFeeRecipient, srcChainTokenInSenderPermit: $srcChainTokenInSenderPermit, enableEstimate: $enableEstimate, allowedTaker: $allowedTaker, externalCall: $externalCall, prependOperatingExpenses: $prependOperatingExpenses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTxRequestDtoImpl &&
            (identical(other.srcChainId, srcChainId) ||
                other.srcChainId == srcChainId) &&
            (identical(other.srcChainTokenIn, srcChainTokenIn) ||
                other.srcChainTokenIn == srcChainTokenIn) &&
            (identical(other.srcChainTokenInAmount, srcChainTokenInAmount) ||
                other.srcChainTokenInAmount == srcChainTokenInAmount) &&
            (identical(other.dstChainId, dstChainId) ||
                other.dstChainId == dstChainId) &&
            (identical(other.dstChainTokenOut, dstChainTokenOut) ||
                other.dstChainTokenOut == dstChainTokenOut) &&
            (identical(other.dstChainTokenOutRecipient, dstChainTokenOutRecipient) ||
                other.dstChainTokenOutRecipient == dstChainTokenOutRecipient) &&
            (identical(other.srcChainOrderAuthorityAddress, srcChainOrderAuthorityAddress) ||
                other.srcChainOrderAuthorityAddress ==
                    srcChainOrderAuthorityAddress) &&
            (identical(other.dstChainOrderAuthorityAddress, dstChainOrderAuthorityAddress) ||
                other.dstChainOrderAuthorityAddress ==
                    dstChainOrderAuthorityAddress) &&
            (identical(other.dstChainTokenOutAmount, dstChainTokenOutAmount) ||
                other.dstChainTokenOutAmount == dstChainTokenOutAmount) &&
            (identical(other.additionalTakerRewardBps, additionalTakerRewardBps) ||
                other.additionalTakerRewardBps == additionalTakerRewardBps) &&
            (identical(other.srcIntermediaryTokenAddress, srcIntermediaryTokenAddress) ||
                other.srcIntermediaryTokenAddress ==
                    srcIntermediaryTokenAddress) &&
            (identical(other.dstIntermediaryTokenAddress, dstIntermediaryTokenAddress) ||
                other.dstIntermediaryTokenAddress ==
                    dstIntermediaryTokenAddress) &&
            (identical(other.dstIntermediaryTokenSpenderAddress, dstIntermediaryTokenSpenderAddress) ||
                other.dstIntermediaryTokenSpenderAddress ==
                    dstIntermediaryTokenSpenderAddress) &&
            (identical(other.intermediaryTokenUSDPrice, intermediaryTokenUSDPrice) ||
                other.intermediaryTokenUSDPrice == intermediaryTokenUSDPrice) &&
            (identical(other.slippage, slippage) ||
                other.slippage == slippage) &&
            (identical(other.senderAddress, senderAddress) ||
                other.senderAddress == senderAddress) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.affiliateFeePercent, affiliateFeePercent) ||
                other.affiliateFeePercent == affiliateFeePercent) &&
            (identical(other.affiliateFeeRecipient, affiliateFeeRecipient) ||
                other.affiliateFeeRecipient == affiliateFeeRecipient) &&
            (identical(other.srcChainTokenInSenderPermit, srcChainTokenInSenderPermit) ||
                other.srcChainTokenInSenderPermit ==
                    srcChainTokenInSenderPermit) &&
            (identical(other.enableEstimate, enableEstimate) || other.enableEstimate == enableEstimate) &&
            (identical(other.allowedTaker, allowedTaker) || other.allowedTaker == allowedTaker) &&
            (identical(other.externalCall, externalCall) || other.externalCall == externalCall) &&
            (identical(other.prependOperatingExpenses, prependOperatingExpenses) || other.prependOperatingExpenses == prependOperatingExpenses));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        srcChainId,
        srcChainTokenIn,
        srcChainTokenInAmount,
        dstChainId,
        dstChainTokenOut,
        dstChainTokenOutRecipient,
        srcChainOrderAuthorityAddress,
        dstChainOrderAuthorityAddress,
        dstChainTokenOutAmount,
        additionalTakerRewardBps,
        srcIntermediaryTokenAddress,
        dstIntermediaryTokenAddress,
        dstIntermediaryTokenSpenderAddress,
        intermediaryTokenUSDPrice,
        slippage,
        senderAddress,
        referralCode,
        affiliateFeePercent,
        affiliateFeeRecipient,
        srcChainTokenInSenderPermit,
        enableEstimate,
        allowedTaker,
        externalCall,
        prependOperatingExpenses
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTxRequestDtoImplCopyWith<_$CreateTxRequestDtoImpl> get copyWith =>
      __$$CreateTxRequestDtoImplCopyWithImpl<_$CreateTxRequestDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTxRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateTxRequestDto implements CreateTxRequestDto {
  const factory _CreateTxRequestDto(
      {required final String srcChainId,
      required final String srcChainTokenIn,
      required final String srcChainTokenInAmount,
      required final String dstChainId,
      required final String dstChainTokenOut,
      required final String dstChainTokenOutRecipient,
      required final String srcChainOrderAuthorityAddress,
      required final String dstChainOrderAuthorityAddress,
      final String? dstChainTokenOutAmount,
      final double? additionalTakerRewardBps,
      final String? srcIntermediaryTokenAddress,
      final String? dstIntermediaryTokenAddress,
      final String? dstIntermediaryTokenSpenderAddress,
      final double? intermediaryTokenUSDPrice,
      final double? slippage,
      final String? senderAddress,
      final double? referralCode,
      final double? affiliateFeePercent,
      final String? affiliateFeeRecipient,
      final String? srcChainTokenInSenderPermit,
      final bool? enableEstimate,
      final String? allowedTaker,
      final String? externalCall,
      final bool? prependOperatingExpenses}) = _$CreateTxRequestDtoImpl;

  factory _CreateTxRequestDto.fromJson(Map<String, dynamic> json) =
      _$CreateTxRequestDtoImpl.fromJson;

  @override
  String get srcChainId;
  @override
  String get srcChainTokenIn;
  @override
  String get srcChainTokenInAmount;
  @override
  String get dstChainId;
  @override
  String get dstChainTokenOut;
  @override
  String get dstChainTokenOutRecipient;
  @override
  String get srcChainOrderAuthorityAddress;
  @override
  String get dstChainOrderAuthorityAddress;
  @override
  String? get dstChainTokenOutAmount;
  @override
  double? get additionalTakerRewardBps;
  @override
  String? get srcIntermediaryTokenAddress;
  @override
  String? get dstIntermediaryTokenAddress;
  @override
  String? get dstIntermediaryTokenSpenderAddress;
  @override
  double? get intermediaryTokenUSDPrice;
  @override
  double? get slippage;
  @override
  String? get senderAddress;
  @override
  double? get referralCode;
  @override
  double? get affiliateFeePercent;
  @override
  String? get affiliateFeeRecipient;
  @override
  String? get srcChainTokenInSenderPermit;
  @override
  bool? get enableEstimate;
  @override
  String? get allowedTaker;
  @override
  String? get externalCall;
  @override
  bool? get prependOperatingExpenses;
  @override
  @JsonKey(ignore: true)
  _$$CreateTxRequestDtoImplCopyWith<_$CreateTxRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateTxResponseDto _$CreateTxResponseDtoFromJson(Map<String, dynamic> json) {
  return _CreateTxResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CreateTxResponseDto {
  OrderEstimation get estimation => throw _privateConstructorUsedError;
  DlnTx get tx => throw _privateConstructorUsedError;
  String? get prependedOperatingExpenseCost =>
      throw _privateConstructorUsedError;
  Order get order => throw _privateConstructorUsedError;
  String get fixFee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateTxResponseDtoCopyWith<CreateTxResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTxResponseDtoCopyWith<$Res> {
  factory $CreateTxResponseDtoCopyWith(
          CreateTxResponseDto value, $Res Function(CreateTxResponseDto) then) =
      _$CreateTxResponseDtoCopyWithImpl<$Res, CreateTxResponseDto>;
  @useResult
  $Res call(
      {OrderEstimation estimation,
      DlnTx tx,
      String? prependedOperatingExpenseCost,
      Order order,
      String fixFee});

  $OrderEstimationCopyWith<$Res> get estimation;
  $DlnTxCopyWith<$Res> get tx;
  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class _$CreateTxResponseDtoCopyWithImpl<$Res, $Val extends CreateTxResponseDto>
    implements $CreateTxResponseDtoCopyWith<$Res> {
  _$CreateTxResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? estimation = null,
    Object? tx = null,
    Object? prependedOperatingExpenseCost = freezed,
    Object? order = null,
    Object? fixFee = null,
  }) {
    return _then(_value.copyWith(
      estimation: null == estimation
          ? _value.estimation
          : estimation // ignore: cast_nullable_to_non_nullable
              as OrderEstimation,
      tx: null == tx
          ? _value.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as DlnTx,
      prependedOperatingExpenseCost: freezed == prependedOperatingExpenseCost
          ? _value.prependedOperatingExpenseCost
          : prependedOperatingExpenseCost // ignore: cast_nullable_to_non_nullable
              as String?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
      fixFee: null == fixFee
          ? _value.fixFee
          : fixFee // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderEstimationCopyWith<$Res> get estimation {
    return $OrderEstimationCopyWith<$Res>(_value.estimation, (value) {
      return _then(_value.copyWith(estimation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DlnTxCopyWith<$Res> get tx {
    return $DlnTxCopyWith<$Res>(_value.tx, (value) {
      return _then(_value.copyWith(tx: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderCopyWith<$Res> get order {
    return $OrderCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateTxResponseDtoImplCopyWith<$Res>
    implements $CreateTxResponseDtoCopyWith<$Res> {
  factory _$$CreateTxResponseDtoImplCopyWith(_$CreateTxResponseDtoImpl value,
          $Res Function(_$CreateTxResponseDtoImpl) then) =
      __$$CreateTxResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OrderEstimation estimation,
      DlnTx tx,
      String? prependedOperatingExpenseCost,
      Order order,
      String fixFee});

  @override
  $OrderEstimationCopyWith<$Res> get estimation;
  @override
  $DlnTxCopyWith<$Res> get tx;
  @override
  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class __$$CreateTxResponseDtoImplCopyWithImpl<$Res>
    extends _$CreateTxResponseDtoCopyWithImpl<$Res, _$CreateTxResponseDtoImpl>
    implements _$$CreateTxResponseDtoImplCopyWith<$Res> {
  __$$CreateTxResponseDtoImplCopyWithImpl(_$CreateTxResponseDtoImpl _value,
      $Res Function(_$CreateTxResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? estimation = null,
    Object? tx = null,
    Object? prependedOperatingExpenseCost = freezed,
    Object? order = null,
    Object? fixFee = null,
  }) {
    return _then(_$CreateTxResponseDtoImpl(
      estimation: null == estimation
          ? _value.estimation
          : estimation // ignore: cast_nullable_to_non_nullable
              as OrderEstimation,
      tx: null == tx
          ? _value.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as DlnTx,
      prependedOperatingExpenseCost: freezed == prependedOperatingExpenseCost
          ? _value.prependedOperatingExpenseCost
          : prependedOperatingExpenseCost // ignore: cast_nullable_to_non_nullable
              as String?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
      fixFee: null == fixFee
          ? _value.fixFee
          : fixFee // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTxResponseDtoImpl implements _CreateTxResponseDto {
  const _$CreateTxResponseDtoImpl(
      {required this.estimation,
      required this.tx,
      this.prependedOperatingExpenseCost,
      required this.order,
      required this.fixFee});

  factory _$CreateTxResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTxResponseDtoImplFromJson(json);

  @override
  final OrderEstimation estimation;
  @override
  final DlnTx tx;
  @override
  final String? prependedOperatingExpenseCost;
  @override
  final Order order;
  @override
  final String fixFee;

  @override
  String toString() {
    return 'CreateTxResponseDto(estimation: $estimation, tx: $tx, prependedOperatingExpenseCost: $prependedOperatingExpenseCost, order: $order, fixFee: $fixFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTxResponseDtoImpl &&
            (identical(other.estimation, estimation) ||
                other.estimation == estimation) &&
            (identical(other.tx, tx) || other.tx == tx) &&
            (identical(other.prependedOperatingExpenseCost,
                    prependedOperatingExpenseCost) ||
                other.prependedOperatingExpenseCost ==
                    prependedOperatingExpenseCost) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.fixFee, fixFee) || other.fixFee == fixFee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, estimation, tx,
      prependedOperatingExpenseCost, order, fixFee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTxResponseDtoImplCopyWith<_$CreateTxResponseDtoImpl> get copyWith =>
      __$$CreateTxResponseDtoImplCopyWithImpl<_$CreateTxResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTxResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateTxResponseDto implements CreateTxResponseDto {
  const factory _CreateTxResponseDto(
      {required final OrderEstimation estimation,
      required final DlnTx tx,
      final String? prependedOperatingExpenseCost,
      required final Order order,
      required final String fixFee}) = _$CreateTxResponseDtoImpl;

  factory _CreateTxResponseDto.fromJson(Map<String, dynamic> json) =
      _$CreateTxResponseDtoImpl.fromJson;

  @override
  OrderEstimation get estimation;
  @override
  DlnTx get tx;
  @override
  String? get prependedOperatingExpenseCost;
  @override
  Order get order;
  @override
  String get fixFee;
  @override
  @JsonKey(ignore: true)
  _$$CreateTxResponseDtoImplCopyWith<_$CreateTxResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderResponseDto _$OrderResponseDtoFromJson(Map<String, dynamic> json) {
  return _OrderResponseDto.fromJson(json);
}

/// @nodoc
mixin _$OrderResponseDto {
  String get orderId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get externalCallState => throw _privateConstructorUsedError;
  OrderStruct get orderStruct => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderResponseDtoCopyWith<OrderResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderResponseDtoCopyWith<$Res> {
  factory $OrderResponseDtoCopyWith(
          OrderResponseDto value, $Res Function(OrderResponseDto) then) =
      _$OrderResponseDtoCopyWithImpl<$Res, OrderResponseDto>;
  @useResult
  $Res call(
      {String orderId,
      String status,
      String externalCallState,
      OrderStruct orderStruct});

  $OrderStructCopyWith<$Res> get orderStruct;
}

/// @nodoc
class _$OrderResponseDtoCopyWithImpl<$Res, $Val extends OrderResponseDto>
    implements $OrderResponseDtoCopyWith<$Res> {
  _$OrderResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? status = null,
    Object? externalCallState = null,
    Object? orderStruct = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      externalCallState: null == externalCallState
          ? _value.externalCallState
          : externalCallState // ignore: cast_nullable_to_non_nullable
              as String,
      orderStruct: null == orderStruct
          ? _value.orderStruct
          : orderStruct // ignore: cast_nullable_to_non_nullable
              as OrderStruct,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderStructCopyWith<$Res> get orderStruct {
    return $OrderStructCopyWith<$Res>(_value.orderStruct, (value) {
      return _then(_value.copyWith(orderStruct: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderResponseDtoImplCopyWith<$Res>
    implements $OrderResponseDtoCopyWith<$Res> {
  factory _$$OrderResponseDtoImplCopyWith(_$OrderResponseDtoImpl value,
          $Res Function(_$OrderResponseDtoImpl) then) =
      __$$OrderResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String orderId,
      String status,
      String externalCallState,
      OrderStruct orderStruct});

  @override
  $OrderStructCopyWith<$Res> get orderStruct;
}

/// @nodoc
class __$$OrderResponseDtoImplCopyWithImpl<$Res>
    extends _$OrderResponseDtoCopyWithImpl<$Res, _$OrderResponseDtoImpl>
    implements _$$OrderResponseDtoImplCopyWith<$Res> {
  __$$OrderResponseDtoImplCopyWithImpl(_$OrderResponseDtoImpl _value,
      $Res Function(_$OrderResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? status = null,
    Object? externalCallState = null,
    Object? orderStruct = null,
  }) {
    return _then(_$OrderResponseDtoImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      externalCallState: null == externalCallState
          ? _value.externalCallState
          : externalCallState // ignore: cast_nullable_to_non_nullable
              as String,
      orderStruct: null == orderStruct
          ? _value.orderStruct
          : orderStruct // ignore: cast_nullable_to_non_nullable
              as OrderStruct,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderResponseDtoImpl implements _OrderResponseDto {
  const _$OrderResponseDtoImpl(
      {required this.orderId,
      required this.status,
      required this.externalCallState,
      required this.orderStruct});

  factory _$OrderResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderResponseDtoImplFromJson(json);

  @override
  final String orderId;
  @override
  final String status;
  @override
  final String externalCallState;
  @override
  final OrderStruct orderStruct;

  @override
  String toString() {
    return 'OrderResponseDto(orderId: $orderId, status: $status, externalCallState: $externalCallState, orderStruct: $orderStruct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderResponseDtoImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.externalCallState, externalCallState) ||
                other.externalCallState == externalCallState) &&
            (identical(other.orderStruct, orderStruct) ||
                other.orderStruct == orderStruct));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, orderId, status, externalCallState, orderStruct);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderResponseDtoImplCopyWith<_$OrderResponseDtoImpl> get copyWith =>
      __$$OrderResponseDtoImplCopyWithImpl<_$OrderResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderResponseDto implements OrderResponseDto {
  const factory _OrderResponseDto(
      {required final String orderId,
      required final String status,
      required final String externalCallState,
      required final OrderStruct orderStruct}) = _$OrderResponseDtoImpl;

  factory _OrderResponseDto.fromJson(Map<String, dynamic> json) =
      _$OrderResponseDtoImpl.fromJson;

  @override
  String get orderId;
  @override
  String get status;
  @override
  String get externalCallState;
  @override
  OrderStruct get orderStruct;
  @override
  @JsonKey(ignore: true)
  _$$OrderResponseDtoImplCopyWith<_$OrderResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderStatusResponseDto _$OrderStatusResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _OrderStatusResponseDto.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusResponseDto {
  String get orderId => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: OrderStatus.unknown)
  OrderStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatusResponseDtoCopyWith<OrderStatusResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusResponseDtoCopyWith<$Res> {
  factory $OrderStatusResponseDtoCopyWith(OrderStatusResponseDto value,
          $Res Function(OrderStatusResponseDto) then) =
      _$OrderStatusResponseDtoCopyWithImpl<$Res, OrderStatusResponseDto>;
  @useResult
  $Res call(
      {String orderId,
      @JsonKey(unknownEnumValue: OrderStatus.unknown) OrderStatus status});
}

/// @nodoc
class _$OrderStatusResponseDtoCopyWithImpl<$Res,
        $Val extends OrderStatusResponseDto>
    implements $OrderStatusResponseDtoCopyWith<$Res> {
  _$OrderStatusResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderStatusResponseDtoImplCopyWith<$Res>
    implements $OrderStatusResponseDtoCopyWith<$Res> {
  factory _$$OrderStatusResponseDtoImplCopyWith(
          _$OrderStatusResponseDtoImpl value,
          $Res Function(_$OrderStatusResponseDtoImpl) then) =
      __$$OrderStatusResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String orderId,
      @JsonKey(unknownEnumValue: OrderStatus.unknown) OrderStatus status});
}

/// @nodoc
class __$$OrderStatusResponseDtoImplCopyWithImpl<$Res>
    extends _$OrderStatusResponseDtoCopyWithImpl<$Res,
        _$OrderStatusResponseDtoImpl>
    implements _$$OrderStatusResponseDtoImplCopyWith<$Res> {
  __$$OrderStatusResponseDtoImplCopyWithImpl(
      _$OrderStatusResponseDtoImpl _value,
      $Res Function(_$OrderStatusResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? status = null,
  }) {
    return _then(_$OrderStatusResponseDtoImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStatusResponseDtoImpl implements _OrderStatusResponseDto {
  const _$OrderStatusResponseDtoImpl(
      {required this.orderId,
      @JsonKey(unknownEnumValue: OrderStatus.unknown) required this.status});

  factory _$OrderStatusResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStatusResponseDtoImplFromJson(json);

  @override
  final String orderId;
  @override
  @JsonKey(unknownEnumValue: OrderStatus.unknown)
  final OrderStatus status;

  @override
  String toString() {
    return 'OrderStatusResponseDto(orderId: $orderId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStatusResponseDtoImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, orderId, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStatusResponseDtoImplCopyWith<_$OrderStatusResponseDtoImpl>
      get copyWith => __$$OrderStatusResponseDtoImplCopyWithImpl<
          _$OrderStatusResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStatusResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderStatusResponseDto implements OrderStatusResponseDto {
  const factory _OrderStatusResponseDto(
      {required final String orderId,
      @JsonKey(unknownEnumValue: OrderStatus.unknown)
      required final OrderStatus status}) = _$OrderStatusResponseDtoImpl;

  factory _OrderStatusResponseDto.fromJson(Map<String, dynamic> json) =
      _$OrderStatusResponseDtoImpl.fromJson;

  @override
  String get orderId;
  @override
  @JsonKey(unknownEnumValue: OrderStatus.unknown)
  OrderStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$OrderStatusResponseDtoImplCopyWith<_$OrderStatusResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrderIdTxResponseDto _$OrderIdTxResponseDtoFromJson(Map<String, dynamic> json) {
  return _OrderIdTxResponseDto.fromJson(json);
}

/// @nodoc
mixin _$OrderIdTxResponseDto {
  List<String> get orderIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderIdTxResponseDtoCopyWith<OrderIdTxResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderIdTxResponseDtoCopyWith<$Res> {
  factory $OrderIdTxResponseDtoCopyWith(OrderIdTxResponseDto value,
          $Res Function(OrderIdTxResponseDto) then) =
      _$OrderIdTxResponseDtoCopyWithImpl<$Res, OrderIdTxResponseDto>;
  @useResult
  $Res call({List<String> orderIds});
}

/// @nodoc
class _$OrderIdTxResponseDtoCopyWithImpl<$Res,
        $Val extends OrderIdTxResponseDto>
    implements $OrderIdTxResponseDtoCopyWith<$Res> {
  _$OrderIdTxResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderIds = null,
  }) {
    return _then(_value.copyWith(
      orderIds: null == orderIds
          ? _value.orderIds
          : orderIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderIdTxResponseDtoImplCopyWith<$Res>
    implements $OrderIdTxResponseDtoCopyWith<$Res> {
  factory _$$OrderIdTxResponseDtoImplCopyWith(_$OrderIdTxResponseDtoImpl value,
          $Res Function(_$OrderIdTxResponseDtoImpl) then) =
      __$$OrderIdTxResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> orderIds});
}

/// @nodoc
class __$$OrderIdTxResponseDtoImplCopyWithImpl<$Res>
    extends _$OrderIdTxResponseDtoCopyWithImpl<$Res, _$OrderIdTxResponseDtoImpl>
    implements _$$OrderIdTxResponseDtoImplCopyWith<$Res> {
  __$$OrderIdTxResponseDtoImplCopyWithImpl(_$OrderIdTxResponseDtoImpl _value,
      $Res Function(_$OrderIdTxResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderIds = null,
  }) {
    return _then(_$OrderIdTxResponseDtoImpl(
      orderIds: null == orderIds
          ? _value._orderIds
          : orderIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderIdTxResponseDtoImpl implements _OrderIdTxResponseDto {
  const _$OrderIdTxResponseDtoImpl({required final List<String> orderIds})
      : _orderIds = orderIds;

  factory _$OrderIdTxResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderIdTxResponseDtoImplFromJson(json);

  final List<String> _orderIds;
  @override
  List<String> get orderIds {
    if (_orderIds is EqualUnmodifiableListView) return _orderIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderIds);
  }

  @override
  String toString() {
    return 'OrderIdTxResponseDto(orderIds: $orderIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderIdTxResponseDtoImpl &&
            const DeepCollectionEquality().equals(other._orderIds, _orderIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orderIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderIdTxResponseDtoImplCopyWith<_$OrderIdTxResponseDtoImpl>
      get copyWith =>
          __$$OrderIdTxResponseDtoImplCopyWithImpl<_$OrderIdTxResponseDtoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderIdTxResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _OrderIdTxResponseDto implements OrderIdTxResponseDto {
  const factory _OrderIdTxResponseDto({required final List<String> orderIds}) =
      _$OrderIdTxResponseDtoImpl;

  factory _OrderIdTxResponseDto.fromJson(Map<String, dynamic> json) =
      _$OrderIdTxResponseDtoImpl.fromJson;

  @override
  List<String> get orderIds;
  @override
  @JsonKey(ignore: true)
  _$$OrderIdTxResponseDtoImplCopyWith<_$OrderIdTxResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CancelTxResponseDto _$CancelTxResponseDtoFromJson(Map<String, dynamic> json) {
  return _CancelTxResponseDto.fromJson(json);
}

/// @nodoc
mixin _$CancelTxResponseDto {
  String get to => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  double get chainId => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String? get cancelBeneficiary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CancelTxResponseDtoCopyWith<CancelTxResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CancelTxResponseDtoCopyWith<$Res> {
  factory $CancelTxResponseDtoCopyWith(
          CancelTxResponseDto value, $Res Function(CancelTxResponseDto) then) =
      _$CancelTxResponseDtoCopyWithImpl<$Res, CancelTxResponseDto>;
  @useResult
  $Res call(
      {String to,
      String data,
      String value,
      double chainId,
      String from,
      String? cancelBeneficiary});
}

/// @nodoc
class _$CancelTxResponseDtoCopyWithImpl<$Res, $Val extends CancelTxResponseDto>
    implements $CancelTxResponseDtoCopyWith<$Res> {
  _$CancelTxResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? data = null,
    Object? value = null,
    Object? chainId = null,
    Object? from = null,
    Object? cancelBeneficiary = freezed,
  }) {
    return _then(_value.copyWith(
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as double,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      cancelBeneficiary: freezed == cancelBeneficiary
          ? _value.cancelBeneficiary
          : cancelBeneficiary // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CancelTxResponseDtoImplCopyWith<$Res>
    implements $CancelTxResponseDtoCopyWith<$Res> {
  factory _$$CancelTxResponseDtoImplCopyWith(_$CancelTxResponseDtoImpl value,
          $Res Function(_$CancelTxResponseDtoImpl) then) =
      __$$CancelTxResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String to,
      String data,
      String value,
      double chainId,
      String from,
      String? cancelBeneficiary});
}

/// @nodoc
class __$$CancelTxResponseDtoImplCopyWithImpl<$Res>
    extends _$CancelTxResponseDtoCopyWithImpl<$Res, _$CancelTxResponseDtoImpl>
    implements _$$CancelTxResponseDtoImplCopyWith<$Res> {
  __$$CancelTxResponseDtoImplCopyWithImpl(_$CancelTxResponseDtoImpl _value,
      $Res Function(_$CancelTxResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? data = null,
    Object? value = null,
    Object? chainId = null,
    Object? from = null,
    Object? cancelBeneficiary = freezed,
  }) {
    return _then(_$CancelTxResponseDtoImpl(
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as double,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      cancelBeneficiary: freezed == cancelBeneficiary
          ? _value.cancelBeneficiary
          : cancelBeneficiary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CancelTxResponseDtoImpl implements _CancelTxResponseDto {
  const _$CancelTxResponseDtoImpl(
      {required this.to,
      required this.data,
      required this.value,
      required this.chainId,
      required this.from,
      this.cancelBeneficiary});

  factory _$CancelTxResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CancelTxResponseDtoImplFromJson(json);

  @override
  final String to;
  @override
  final String data;
  @override
  final String value;
  @override
  final double chainId;
  @override
  final String from;
  @override
  final String? cancelBeneficiary;

  @override
  String toString() {
    return 'CancelTxResponseDto(to: $to, data: $data, value: $value, chainId: $chainId, from: $from, cancelBeneficiary: $cancelBeneficiary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CancelTxResponseDtoImpl &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.cancelBeneficiary, cancelBeneficiary) ||
                other.cancelBeneficiary == cancelBeneficiary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, to, data, value, chainId, from, cancelBeneficiary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CancelTxResponseDtoImplCopyWith<_$CancelTxResponseDtoImpl> get copyWith =>
      __$$CancelTxResponseDtoImplCopyWithImpl<_$CancelTxResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CancelTxResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _CancelTxResponseDto implements CancelTxResponseDto {
  const factory _CancelTxResponseDto(
      {required final String to,
      required final String data,
      required final String value,
      required final double chainId,
      required final String from,
      final String? cancelBeneficiary}) = _$CancelTxResponseDtoImpl;

  factory _CancelTxResponseDto.fromJson(Map<String, dynamic> json) =
      _$CancelTxResponseDtoImpl.fromJson;

  @override
  String get to;
  @override
  String get data;
  @override
  String get value;
  @override
  double get chainId;
  @override
  String get from;
  @override
  String? get cancelBeneficiary;
  @override
  @JsonKey(ignore: true)
  _$$CancelTxResponseDtoImplCopyWith<_$CancelTxResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
