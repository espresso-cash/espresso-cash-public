// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

JupiterMarketFee _$JupiterMarketFeeFromJson(Map<String, dynamic> json) {
  return _JupiterMarketFee.fromJson(json);
}

/// @nodoc
mixin _$JupiterMarketFee {
  String? get amount => throw _privateConstructorUsedError;
  num? get feeBps => throw _privateConstructorUsedError;

  /// Serializes this JupiterMarketFee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JupiterMarketFeeCopyWith<JupiterMarketFee> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterMarketFeeCopyWith<$Res> {
  factory $JupiterMarketFeeCopyWith(JupiterMarketFee value, $Res Function(JupiterMarketFee) then) =
      _$JupiterMarketFeeCopyWithImpl<$Res, JupiterMarketFee>;
  @useResult
  $Res call({String? amount, num? feeBps});
}

/// @nodoc
class _$JupiterMarketFeeCopyWithImpl<$Res, $Val extends JupiterMarketFee>
    implements $JupiterMarketFeeCopyWith<$Res> {
  _$JupiterMarketFeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? amount = freezed, Object? feeBps = freezed}) {
    return _then(
      _value.copyWith(
            amount:
                freezed == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as String?,
            feeBps:
                freezed == feeBps
                    ? _value.feeBps
                    : feeBps // ignore: cast_nullable_to_non_nullable
                        as num?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JupiterMarketFeeImplCopyWith<$Res> implements $JupiterMarketFeeCopyWith<$Res> {
  factory _$$JupiterMarketFeeImplCopyWith(
    _$JupiterMarketFeeImpl value,
    $Res Function(_$JupiterMarketFeeImpl) then,
  ) = __$$JupiterMarketFeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? amount, num? feeBps});
}

/// @nodoc
class __$$JupiterMarketFeeImplCopyWithImpl<$Res>
    extends _$JupiterMarketFeeCopyWithImpl<$Res, _$JupiterMarketFeeImpl>
    implements _$$JupiterMarketFeeImplCopyWith<$Res> {
  __$$JupiterMarketFeeImplCopyWithImpl(
    _$JupiterMarketFeeImpl _value,
    $Res Function(_$JupiterMarketFeeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? amount = freezed, Object? feeBps = freezed}) {
    return _then(
      _$JupiterMarketFeeImpl(
        amount:
            freezed == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as String?,
        feeBps:
            freezed == feeBps
                ? _value.feeBps
                : feeBps // ignore: cast_nullable_to_non_nullable
                    as num?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterMarketFeeImpl implements _JupiterMarketFee {
  const _$JupiterMarketFeeImpl({this.amount, this.feeBps});

  factory _$JupiterMarketFeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterMarketFeeImplFromJson(json);

  @override
  final String? amount;
  @override
  final num? feeBps;

  @override
  String toString() {
    return 'JupiterMarketFee(amount: $amount, feeBps: $feeBps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JupiterMarketFeeImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.feeBps, feeBps) || other.feeBps == feeBps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, feeBps);

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterMarketFeeImplCopyWith<_$JupiterMarketFeeImpl> get copyWith =>
      __$$JupiterMarketFeeImplCopyWithImpl<_$JupiterMarketFeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterMarketFeeImplToJson(this);
  }
}

abstract class _JupiterMarketFee implements JupiterMarketFee {
  const factory _JupiterMarketFee({final String? amount, final num? feeBps}) =
      _$JupiterMarketFeeImpl;

  factory _JupiterMarketFee.fromJson(Map<String, dynamic> json) = _$JupiterMarketFeeImpl.fromJson;

  @override
  String? get amount;
  @override
  num? get feeBps;

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JupiterMarketFeeImplCopyWith<_$JupiterMarketFeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoutePlan _$RoutePlanFromJson(Map<String, dynamic> json) {
  return _RoutePlan.fromJson(json);
}

/// @nodoc
mixin _$RoutePlan {
  JupiterSwapInfo get swapInfo => throw _privateConstructorUsedError;
  int get percent => throw _privateConstructorUsedError;

  /// Serializes this RoutePlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoutePlanCopyWith<RoutePlan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoutePlanCopyWith<$Res> {
  factory $RoutePlanCopyWith(RoutePlan value, $Res Function(RoutePlan) then) =
      _$RoutePlanCopyWithImpl<$Res, RoutePlan>;
  @useResult
  $Res call({JupiterSwapInfo swapInfo, int percent});

  $JupiterSwapInfoCopyWith<$Res> get swapInfo;
}

/// @nodoc
class _$RoutePlanCopyWithImpl<$Res, $Val extends RoutePlan> implements $RoutePlanCopyWith<$Res> {
  _$RoutePlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? swapInfo = null, Object? percent = null}) {
    return _then(
      _value.copyWith(
            swapInfo:
                null == swapInfo
                    ? _value.swapInfo
                    : swapInfo // ignore: cast_nullable_to_non_nullable
                        as JupiterSwapInfo,
            percent:
                null == percent
                    ? _value.percent
                    : percent // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JupiterSwapInfoCopyWith<$Res> get swapInfo {
    return $JupiterSwapInfoCopyWith<$Res>(_value.swapInfo, (value) {
      return _then(_value.copyWith(swapInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoutePlanImplCopyWith<$Res> implements $RoutePlanCopyWith<$Res> {
  factory _$$RoutePlanImplCopyWith(_$RoutePlanImpl value, $Res Function(_$RoutePlanImpl) then) =
      __$$RoutePlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({JupiterSwapInfo swapInfo, int percent});

  @override
  $JupiterSwapInfoCopyWith<$Res> get swapInfo;
}

/// @nodoc
class __$$RoutePlanImplCopyWithImpl<$Res> extends _$RoutePlanCopyWithImpl<$Res, _$RoutePlanImpl>
    implements _$$RoutePlanImplCopyWith<$Res> {
  __$$RoutePlanImplCopyWithImpl(_$RoutePlanImpl _value, $Res Function(_$RoutePlanImpl) _then)
    : super(_value, _then);

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? swapInfo = null, Object? percent = null}) {
    return _then(
      _$RoutePlanImpl(
        swapInfo:
            null == swapInfo
                ? _value.swapInfo
                : swapInfo // ignore: cast_nullable_to_non_nullable
                    as JupiterSwapInfo,
        percent:
            null == percent
                ? _value.percent
                : percent // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoutePlanImpl implements _RoutePlan {
  const _$RoutePlanImpl({required this.swapInfo, required this.percent});

  factory _$RoutePlanImpl.fromJson(Map<String, dynamic> json) => _$$RoutePlanImplFromJson(json);

  @override
  final JupiterSwapInfo swapInfo;
  @override
  final int percent;

  @override
  String toString() {
    return 'RoutePlan(swapInfo: $swapInfo, percent: $percent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoutePlanImpl &&
            (identical(other.swapInfo, swapInfo) || other.swapInfo == swapInfo) &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, swapInfo, percent);

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoutePlanImplCopyWith<_$RoutePlanImpl> get copyWith =>
      __$$RoutePlanImplCopyWithImpl<_$RoutePlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoutePlanImplToJson(this);
  }
}

abstract class _RoutePlan implements RoutePlan {
  const factory _RoutePlan({required final JupiterSwapInfo swapInfo, required final int percent}) =
      _$RoutePlanImpl;

  factory _RoutePlan.fromJson(Map<String, dynamic> json) = _$RoutePlanImpl.fromJson;

  @override
  JupiterSwapInfo get swapInfo;
  @override
  int get percent;

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoutePlanImplCopyWith<_$RoutePlanImpl> get copyWith => throw _privateConstructorUsedError;
}

JupiterSwapInfo _$JupiterSwapInfoFromJson(Map<String, dynamic> json) {
  return _JupiterSwapInfo.fromJson(json);
}

/// @nodoc
mixin _$JupiterSwapInfo {
  String get ammKey => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String get inputMint => throw _privateConstructorUsedError;
  String get outputMint => throw _privateConstructorUsedError;
  String get inAmount => throw _privateConstructorUsedError;
  String get outAmount => throw _privateConstructorUsedError;
  String get feeAmount => throw _privateConstructorUsedError;
  String get feeMint => throw _privateConstructorUsedError;

  /// Serializes this JupiterSwapInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JupiterSwapInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JupiterSwapInfoCopyWith<JupiterSwapInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterSwapInfoCopyWith<$Res> {
  factory $JupiterSwapInfoCopyWith(JupiterSwapInfo value, $Res Function(JupiterSwapInfo) then) =
      _$JupiterSwapInfoCopyWithImpl<$Res, JupiterSwapInfo>;
  @useResult
  $Res call({
    String ammKey,
    String? label,
    String inputMint,
    String outputMint,
    String inAmount,
    String outAmount,
    String feeAmount,
    String feeMint,
  });
}

/// @nodoc
class _$JupiterSwapInfoCopyWithImpl<$Res, $Val extends JupiterSwapInfo>
    implements $JupiterSwapInfoCopyWith<$Res> {
  _$JupiterSwapInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JupiterSwapInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ammKey = null,
    Object? label = freezed,
    Object? inputMint = null,
    Object? outputMint = null,
    Object? inAmount = null,
    Object? outAmount = null,
    Object? feeAmount = null,
    Object? feeMint = null,
  }) {
    return _then(
      _value.copyWith(
            ammKey:
                null == ammKey
                    ? _value.ammKey
                    : ammKey // ignore: cast_nullable_to_non_nullable
                        as String,
            label:
                freezed == label
                    ? _value.label
                    : label // ignore: cast_nullable_to_non_nullable
                        as String?,
            inputMint:
                null == inputMint
                    ? _value.inputMint
                    : inputMint // ignore: cast_nullable_to_non_nullable
                        as String,
            outputMint:
                null == outputMint
                    ? _value.outputMint
                    : outputMint // ignore: cast_nullable_to_non_nullable
                        as String,
            inAmount:
                null == inAmount
                    ? _value.inAmount
                    : inAmount // ignore: cast_nullable_to_non_nullable
                        as String,
            outAmount:
                null == outAmount
                    ? _value.outAmount
                    : outAmount // ignore: cast_nullable_to_non_nullable
                        as String,
            feeAmount:
                null == feeAmount
                    ? _value.feeAmount
                    : feeAmount // ignore: cast_nullable_to_non_nullable
                        as String,
            feeMint:
                null == feeMint
                    ? _value.feeMint
                    : feeMint // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$JupiterSwapInfoImplCopyWith<$Res> implements $JupiterSwapInfoCopyWith<$Res> {
  factory _$$JupiterSwapInfoImplCopyWith(
    _$JupiterSwapInfoImpl value,
    $Res Function(_$JupiterSwapInfoImpl) then,
  ) = __$$JupiterSwapInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String ammKey,
    String? label,
    String inputMint,
    String outputMint,
    String inAmount,
    String outAmount,
    String feeAmount,
    String feeMint,
  });
}

/// @nodoc
class __$$JupiterSwapInfoImplCopyWithImpl<$Res>
    extends _$JupiterSwapInfoCopyWithImpl<$Res, _$JupiterSwapInfoImpl>
    implements _$$JupiterSwapInfoImplCopyWith<$Res> {
  __$$JupiterSwapInfoImplCopyWithImpl(
    _$JupiterSwapInfoImpl _value,
    $Res Function(_$JupiterSwapInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JupiterSwapInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ammKey = null,
    Object? label = freezed,
    Object? inputMint = null,
    Object? outputMint = null,
    Object? inAmount = null,
    Object? outAmount = null,
    Object? feeAmount = null,
    Object? feeMint = null,
  }) {
    return _then(
      _$JupiterSwapInfoImpl(
        ammKey:
            null == ammKey
                ? _value.ammKey
                : ammKey // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            freezed == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String?,
        inputMint:
            null == inputMint
                ? _value.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _value.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        inAmount:
            null == inAmount
                ? _value.inAmount
                : inAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        outAmount:
            null == outAmount
                ? _value.outAmount
                : outAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        feeAmount:
            null == feeAmount
                ? _value.feeAmount
                : feeAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        feeMint:
            null == feeMint
                ? _value.feeMint
                : feeMint // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterSwapInfoImpl implements _JupiterSwapInfo {
  const _$JupiterSwapInfoImpl({
    required this.ammKey,
    this.label,
    required this.inputMint,
    required this.outputMint,
    required this.inAmount,
    required this.outAmount,
    required this.feeAmount,
    required this.feeMint,
  });

  factory _$JupiterSwapInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterSwapInfoImplFromJson(json);

  @override
  final String ammKey;
  @override
  final String? label;
  @override
  final String inputMint;
  @override
  final String outputMint;
  @override
  final String inAmount;
  @override
  final String outAmount;
  @override
  final String feeAmount;
  @override
  final String feeMint;

  @override
  String toString() {
    return 'JupiterSwapInfo(ammKey: $ammKey, label: $label, inputMint: $inputMint, outputMint: $outputMint, inAmount: $inAmount, outAmount: $outAmount, feeAmount: $feeAmount, feeMint: $feeMint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JupiterSwapInfoImpl &&
            (identical(other.ammKey, ammKey) || other.ammKey == ammKey) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.inputMint, inputMint) || other.inputMint == inputMint) &&
            (identical(other.outputMint, outputMint) || other.outputMint == outputMint) &&
            (identical(other.inAmount, inAmount) || other.inAmount == inAmount) &&
            (identical(other.outAmount, outAmount) || other.outAmount == outAmount) &&
            (identical(other.feeAmount, feeAmount) || other.feeAmount == feeAmount) &&
            (identical(other.feeMint, feeMint) || other.feeMint == feeMint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ammKey,
    label,
    inputMint,
    outputMint,
    inAmount,
    outAmount,
    feeAmount,
    feeMint,
  );

  /// Create a copy of JupiterSwapInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterSwapInfoImplCopyWith<_$JupiterSwapInfoImpl> get copyWith =>
      __$$JupiterSwapInfoImplCopyWithImpl<_$JupiterSwapInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterSwapInfoImplToJson(this);
  }
}

abstract class _JupiterSwapInfo implements JupiterSwapInfo {
  const factory _JupiterSwapInfo({
    required final String ammKey,
    final String? label,
    required final String inputMint,
    required final String outputMint,
    required final String inAmount,
    required final String outAmount,
    required final String feeAmount,
    required final String feeMint,
  }) = _$JupiterSwapInfoImpl;

  factory _JupiterSwapInfo.fromJson(Map<String, dynamic> json) = _$JupiterSwapInfoImpl.fromJson;

  @override
  String get ammKey;
  @override
  String? get label;
  @override
  String get inputMint;
  @override
  String get outputMint;
  @override
  String get inAmount;
  @override
  String get outAmount;
  @override
  String get feeAmount;
  @override
  String get feeMint;

  /// Create a copy of JupiterSwapInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JupiterSwapInfoImplCopyWith<_$JupiterSwapInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuoteResponseDto _$QuoteResponseDtoFromJson(Map<String, dynamic> json) {
  return _QuoteResponseDto.fromJson(json);
}

/// @nodoc
mixin _$QuoteResponseDto {
  String get inputMint => throw _privateConstructorUsedError;
  String get inAmount => throw _privateConstructorUsedError;
  String get outputMint => throw _privateConstructorUsedError;
  String get outAmount => throw _privateConstructorUsedError;
  String get otherAmountThreshold => throw _privateConstructorUsedError;
  SwapMode get swapMode => throw _privateConstructorUsedError;
  int get slippageBps => throw _privateConstructorUsedError;
  JupiterMarketFee? get platformFee => throw _privateConstructorUsedError;
  String get priceImpactPct => throw _privateConstructorUsedError;
  List<RoutePlan> get routePlan => throw _privateConstructorUsedError;
  num? get contextSlot => throw _privateConstructorUsedError;
  double? get timeTaken => throw _privateConstructorUsedError;

  /// Serializes this QuoteResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteResponseDtoCopyWith<QuoteResponseDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteResponseDtoCopyWith<$Res> {
  factory $QuoteResponseDtoCopyWith(QuoteResponseDto value, $Res Function(QuoteResponseDto) then) =
      _$QuoteResponseDtoCopyWithImpl<$Res, QuoteResponseDto>;
  @useResult
  $Res call({
    String inputMint,
    String inAmount,
    String outputMint,
    String outAmount,
    String otherAmountThreshold,
    SwapMode swapMode,
    int slippageBps,
    JupiterMarketFee? platformFee,
    String priceImpactPct,
    List<RoutePlan> routePlan,
    num? contextSlot,
    double? timeTaken,
  });

  $JupiterMarketFeeCopyWith<$Res>? get platformFee;
}

/// @nodoc
class _$QuoteResponseDtoCopyWithImpl<$Res, $Val extends QuoteResponseDto>
    implements $QuoteResponseDtoCopyWith<$Res> {
  _$QuoteResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = null,
    Object? inAmount = null,
    Object? outputMint = null,
    Object? outAmount = null,
    Object? otherAmountThreshold = null,
    Object? swapMode = null,
    Object? slippageBps = null,
    Object? platformFee = freezed,
    Object? priceImpactPct = null,
    Object? routePlan = null,
    Object? contextSlot = freezed,
    Object? timeTaken = freezed,
  }) {
    return _then(
      _value.copyWith(
            inputMint:
                null == inputMint
                    ? _value.inputMint
                    : inputMint // ignore: cast_nullable_to_non_nullable
                        as String,
            inAmount:
                null == inAmount
                    ? _value.inAmount
                    : inAmount // ignore: cast_nullable_to_non_nullable
                        as String,
            outputMint:
                null == outputMint
                    ? _value.outputMint
                    : outputMint // ignore: cast_nullable_to_non_nullable
                        as String,
            outAmount:
                null == outAmount
                    ? _value.outAmount
                    : outAmount // ignore: cast_nullable_to_non_nullable
                        as String,
            otherAmountThreshold:
                null == otherAmountThreshold
                    ? _value.otherAmountThreshold
                    : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
                        as String,
            swapMode:
                null == swapMode
                    ? _value.swapMode
                    : swapMode // ignore: cast_nullable_to_non_nullable
                        as SwapMode,
            slippageBps:
                null == slippageBps
                    ? _value.slippageBps
                    : slippageBps // ignore: cast_nullable_to_non_nullable
                        as int,
            platformFee:
                freezed == platformFee
                    ? _value.platformFee
                    : platformFee // ignore: cast_nullable_to_non_nullable
                        as JupiterMarketFee?,
            priceImpactPct:
                null == priceImpactPct
                    ? _value.priceImpactPct
                    : priceImpactPct // ignore: cast_nullable_to_non_nullable
                        as String,
            routePlan:
                null == routePlan
                    ? _value.routePlan
                    : routePlan // ignore: cast_nullable_to_non_nullable
                        as List<RoutePlan>,
            contextSlot:
                freezed == contextSlot
                    ? _value.contextSlot
                    : contextSlot // ignore: cast_nullable_to_non_nullable
                        as num?,
            timeTaken:
                freezed == timeTaken
                    ? _value.timeTaken
                    : timeTaken // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JupiterMarketFeeCopyWith<$Res>? get platformFee {
    if (_value.platformFee == null) {
      return null;
    }

    return $JupiterMarketFeeCopyWith<$Res>(_value.platformFee!, (value) {
      return _then(_value.copyWith(platformFee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuoteResponseDtoImplCopyWith<$Res> implements $QuoteResponseDtoCopyWith<$Res> {
  factory _$$QuoteResponseDtoImplCopyWith(
    _$QuoteResponseDtoImpl value,
    $Res Function(_$QuoteResponseDtoImpl) then,
  ) = __$$QuoteResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String inputMint,
    String inAmount,
    String outputMint,
    String outAmount,
    String otherAmountThreshold,
    SwapMode swapMode,
    int slippageBps,
    JupiterMarketFee? platformFee,
    String priceImpactPct,
    List<RoutePlan> routePlan,
    num? contextSlot,
    double? timeTaken,
  });

  @override
  $JupiterMarketFeeCopyWith<$Res>? get platformFee;
}

/// @nodoc
class __$$QuoteResponseDtoImplCopyWithImpl<$Res>
    extends _$QuoteResponseDtoCopyWithImpl<$Res, _$QuoteResponseDtoImpl>
    implements _$$QuoteResponseDtoImplCopyWith<$Res> {
  __$$QuoteResponseDtoImplCopyWithImpl(
    _$QuoteResponseDtoImpl _value,
    $Res Function(_$QuoteResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = null,
    Object? inAmount = null,
    Object? outputMint = null,
    Object? outAmount = null,
    Object? otherAmountThreshold = null,
    Object? swapMode = null,
    Object? slippageBps = null,
    Object? platformFee = freezed,
    Object? priceImpactPct = null,
    Object? routePlan = null,
    Object? contextSlot = freezed,
    Object? timeTaken = freezed,
  }) {
    return _then(
      _$QuoteResponseDtoImpl(
        inputMint:
            null == inputMint
                ? _value.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        inAmount:
            null == inAmount
                ? _value.inAmount
                : inAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _value.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outAmount:
            null == outAmount
                ? _value.outAmount
                : outAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        otherAmountThreshold:
            null == otherAmountThreshold
                ? _value.otherAmountThreshold
                : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
                    as String,
        swapMode:
            null == swapMode
                ? _value.swapMode
                : swapMode // ignore: cast_nullable_to_non_nullable
                    as SwapMode,
        slippageBps:
            null == slippageBps
                ? _value.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int,
        platformFee:
            freezed == platformFee
                ? _value.platformFee
                : platformFee // ignore: cast_nullable_to_non_nullable
                    as JupiterMarketFee?,
        priceImpactPct:
            null == priceImpactPct
                ? _value.priceImpactPct
                : priceImpactPct // ignore: cast_nullable_to_non_nullable
                    as String,
        routePlan:
            null == routePlan
                ? _value._routePlan
                : routePlan // ignore: cast_nullable_to_non_nullable
                    as List<RoutePlan>,
        contextSlot:
            freezed == contextSlot
                ? _value.contextSlot
                : contextSlot // ignore: cast_nullable_to_non_nullable
                    as num?,
        timeTaken:
            freezed == timeTaken
                ? _value.timeTaken
                : timeTaken // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteResponseDtoImpl implements _QuoteResponseDto {
  const _$QuoteResponseDtoImpl({
    required this.inputMint,
    required this.inAmount,
    required this.outputMint,
    required this.outAmount,
    required this.otherAmountThreshold,
    this.swapMode = SwapMode.exactIn,
    required this.slippageBps,
    this.platformFee,
    required this.priceImpactPct,
    required final List<RoutePlan> routePlan,
    this.contextSlot,
    this.timeTaken,
  }) : _routePlan = routePlan;

  factory _$QuoteResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteResponseDtoImplFromJson(json);

  @override
  final String inputMint;
  @override
  final String inAmount;
  @override
  final String outputMint;
  @override
  final String outAmount;
  @override
  final String otherAmountThreshold;
  @override
  @JsonKey()
  final SwapMode swapMode;
  @override
  final int slippageBps;
  @override
  final JupiterMarketFee? platformFee;
  @override
  final String priceImpactPct;
  final List<RoutePlan> _routePlan;
  @override
  List<RoutePlan> get routePlan {
    if (_routePlan is EqualUnmodifiableListView) return _routePlan;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_routePlan);
  }

  @override
  final num? contextSlot;
  @override
  final double? timeTaken;

  @override
  String toString() {
    return 'QuoteResponseDto(inputMint: $inputMint, inAmount: $inAmount, outputMint: $outputMint, outAmount: $outAmount, otherAmountThreshold: $otherAmountThreshold, swapMode: $swapMode, slippageBps: $slippageBps, platformFee: $platformFee, priceImpactPct: $priceImpactPct, routePlan: $routePlan, contextSlot: $contextSlot, timeTaken: $timeTaken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteResponseDtoImpl &&
            (identical(other.inputMint, inputMint) || other.inputMint == inputMint) &&
            (identical(other.inAmount, inAmount) || other.inAmount == inAmount) &&
            (identical(other.outputMint, outputMint) || other.outputMint == outputMint) &&
            (identical(other.outAmount, outAmount) || other.outAmount == outAmount) &&
            (identical(other.otherAmountThreshold, otherAmountThreshold) ||
                other.otherAmountThreshold == otherAmountThreshold) &&
            (identical(other.swapMode, swapMode) || other.swapMode == swapMode) &&
            (identical(other.slippageBps, slippageBps) || other.slippageBps == slippageBps) &&
            (identical(other.platformFee, platformFee) || other.platformFee == platformFee) &&
            (identical(other.priceImpactPct, priceImpactPct) ||
                other.priceImpactPct == priceImpactPct) &&
            const DeepCollectionEquality().equals(other._routePlan, _routePlan) &&
            (identical(other.contextSlot, contextSlot) || other.contextSlot == contextSlot) &&
            (identical(other.timeTaken, timeTaken) || other.timeTaken == timeTaken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    inputMint,
    inAmount,
    outputMint,
    outAmount,
    otherAmountThreshold,
    swapMode,
    slippageBps,
    platformFee,
    priceImpactPct,
    const DeepCollectionEquality().hash(_routePlan),
    contextSlot,
    timeTaken,
  );

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteResponseDtoImplCopyWith<_$QuoteResponseDtoImpl> get copyWith =>
      __$$QuoteResponseDtoImplCopyWithImpl<_$QuoteResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteResponseDtoImplToJson(this);
  }
}

abstract class _QuoteResponseDto implements QuoteResponseDto {
  const factory _QuoteResponseDto({
    required final String inputMint,
    required final String inAmount,
    required final String outputMint,
    required final String outAmount,
    required final String otherAmountThreshold,
    final SwapMode swapMode,
    required final int slippageBps,
    final JupiterMarketFee? platformFee,
    required final String priceImpactPct,
    required final List<RoutePlan> routePlan,
    final num? contextSlot,
    final double? timeTaken,
  }) = _$QuoteResponseDtoImpl;

  factory _QuoteResponseDto.fromJson(Map<String, dynamic> json) = _$QuoteResponseDtoImpl.fromJson;

  @override
  String get inputMint;
  @override
  String get inAmount;
  @override
  String get outputMint;
  @override
  String get outAmount;
  @override
  String get otherAmountThreshold;
  @override
  SwapMode get swapMode;
  @override
  int get slippageBps;
  @override
  JupiterMarketFee? get platformFee;
  @override
  String get priceImpactPct;
  @override
  List<RoutePlan> get routePlan;
  @override
  num? get contextSlot;
  @override
  double? get timeTaken;

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteResponseDtoImplCopyWith<_$QuoteResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuoteRequestDto _$QuoteRequestDtoFromJson(Map<String, dynamic> json) {
  return _QuoteRequestDto.fromJson(json);
}

/// @nodoc
mixin _$QuoteRequestDto {
  String get inputMint => throw _privateConstructorUsedError;
  String get outputMint => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int? get slippageBps => throw _privateConstructorUsedError;
  SwapMode get swapMode => throw _privateConstructorUsedError;
  List<String>? get dexes => throw _privateConstructorUsedError;
  List<String>? get excludeDexes => throw _privateConstructorUsedError;
  bool? get onlyDirectRoutes => throw _privateConstructorUsedError;
  bool? get asLegacyTransaction => throw _privateConstructorUsedError;
  int? get platformFeeBps => throw _privateConstructorUsedError;
  int? get maxAccounts => throw _privateConstructorUsedError;
  bool? get restrictIntermediateTokens => throw _privateConstructorUsedError;
  bool? get autoSlippage => throw _privateConstructorUsedError;
  int? get maxAutoSlippageBps => throw _privateConstructorUsedError;
  int? get autoSlippageCollisionUsdValue => throw _privateConstructorUsedError;

  /// Serializes this QuoteRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteRequestDtoCopyWith<QuoteRequestDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteRequestDtoCopyWith<$Res> {
  factory $QuoteRequestDtoCopyWith(QuoteRequestDto value, $Res Function(QuoteRequestDto) then) =
      _$QuoteRequestDtoCopyWithImpl<$Res, QuoteRequestDto>;
  @useResult
  $Res call({
    String inputMint,
    String outputMint,
    int amount,
    int? slippageBps,
    SwapMode swapMode,
    List<String>? dexes,
    List<String>? excludeDexes,
    bool? onlyDirectRoutes,
    bool? asLegacyTransaction,
    int? platformFeeBps,
    int? maxAccounts,
    bool? restrictIntermediateTokens,
    bool? autoSlippage,
    int? maxAutoSlippageBps,
    int? autoSlippageCollisionUsdValue,
  });
}

/// @nodoc
class _$QuoteRequestDtoCopyWithImpl<$Res, $Val extends QuoteRequestDto>
    implements $QuoteRequestDtoCopyWith<$Res> {
  _$QuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = null,
    Object? outputMint = null,
    Object? amount = null,
    Object? slippageBps = freezed,
    Object? swapMode = null,
    Object? dexes = freezed,
    Object? excludeDexes = freezed,
    Object? onlyDirectRoutes = freezed,
    Object? asLegacyTransaction = freezed,
    Object? platformFeeBps = freezed,
    Object? maxAccounts = freezed,
    Object? restrictIntermediateTokens = freezed,
    Object? autoSlippage = freezed,
    Object? maxAutoSlippageBps = freezed,
    Object? autoSlippageCollisionUsdValue = freezed,
  }) {
    return _then(
      _value.copyWith(
            inputMint:
                null == inputMint
                    ? _value.inputMint
                    : inputMint // ignore: cast_nullable_to_non_nullable
                        as String,
            outputMint:
                null == outputMint
                    ? _value.outputMint
                    : outputMint // ignore: cast_nullable_to_non_nullable
                        as String,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as int,
            slippageBps:
                freezed == slippageBps
                    ? _value.slippageBps
                    : slippageBps // ignore: cast_nullable_to_non_nullable
                        as int?,
            swapMode:
                null == swapMode
                    ? _value.swapMode
                    : swapMode // ignore: cast_nullable_to_non_nullable
                        as SwapMode,
            dexes:
                freezed == dexes
                    ? _value.dexes
                    : dexes // ignore: cast_nullable_to_non_nullable
                        as List<String>?,
            excludeDexes:
                freezed == excludeDexes
                    ? _value.excludeDexes
                    : excludeDexes // ignore: cast_nullable_to_non_nullable
                        as List<String>?,
            onlyDirectRoutes:
                freezed == onlyDirectRoutes
                    ? _value.onlyDirectRoutes
                    : onlyDirectRoutes // ignore: cast_nullable_to_non_nullable
                        as bool?,
            asLegacyTransaction:
                freezed == asLegacyTransaction
                    ? _value.asLegacyTransaction
                    : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
                        as bool?,
            platformFeeBps:
                freezed == platformFeeBps
                    ? _value.platformFeeBps
                    : platformFeeBps // ignore: cast_nullable_to_non_nullable
                        as int?,
            maxAccounts:
                freezed == maxAccounts
                    ? _value.maxAccounts
                    : maxAccounts // ignore: cast_nullable_to_non_nullable
                        as int?,
            restrictIntermediateTokens:
                freezed == restrictIntermediateTokens
                    ? _value.restrictIntermediateTokens
                    : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
                        as bool?,
            autoSlippage:
                freezed == autoSlippage
                    ? _value.autoSlippage
                    : autoSlippage // ignore: cast_nullable_to_non_nullable
                        as bool?,
            maxAutoSlippageBps:
                freezed == maxAutoSlippageBps
                    ? _value.maxAutoSlippageBps
                    : maxAutoSlippageBps // ignore: cast_nullable_to_non_nullable
                        as int?,
            autoSlippageCollisionUsdValue:
                freezed == autoSlippageCollisionUsdValue
                    ? _value.autoSlippageCollisionUsdValue
                    : autoSlippageCollisionUsdValue // ignore: cast_nullable_to_non_nullable
                        as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuoteRequestDtoImplCopyWith<$Res> implements $QuoteRequestDtoCopyWith<$Res> {
  factory _$$QuoteRequestDtoImplCopyWith(
    _$QuoteRequestDtoImpl value,
    $Res Function(_$QuoteRequestDtoImpl) then,
  ) = __$$QuoteRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String inputMint,
    String outputMint,
    int amount,
    int? slippageBps,
    SwapMode swapMode,
    List<String>? dexes,
    List<String>? excludeDexes,
    bool? onlyDirectRoutes,
    bool? asLegacyTransaction,
    int? platformFeeBps,
    int? maxAccounts,
    bool? restrictIntermediateTokens,
    bool? autoSlippage,
    int? maxAutoSlippageBps,
    int? autoSlippageCollisionUsdValue,
  });
}

/// @nodoc
class __$$QuoteRequestDtoImplCopyWithImpl<$Res>
    extends _$QuoteRequestDtoCopyWithImpl<$Res, _$QuoteRequestDtoImpl>
    implements _$$QuoteRequestDtoImplCopyWith<$Res> {
  __$$QuoteRequestDtoImplCopyWithImpl(
    _$QuoteRequestDtoImpl _value,
    $Res Function(_$QuoteRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inputMint = null,
    Object? outputMint = null,
    Object? amount = null,
    Object? slippageBps = freezed,
    Object? swapMode = null,
    Object? dexes = freezed,
    Object? excludeDexes = freezed,
    Object? onlyDirectRoutes = freezed,
    Object? asLegacyTransaction = freezed,
    Object? platformFeeBps = freezed,
    Object? maxAccounts = freezed,
    Object? restrictIntermediateTokens = freezed,
    Object? autoSlippage = freezed,
    Object? maxAutoSlippageBps = freezed,
    Object? autoSlippageCollisionUsdValue = freezed,
  }) {
    return _then(
      _$QuoteRequestDtoImpl(
        inputMint:
            null == inputMint
                ? _value.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _value.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        slippageBps:
            freezed == slippageBps
                ? _value.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        swapMode:
            null == swapMode
                ? _value.swapMode
                : swapMode // ignore: cast_nullable_to_non_nullable
                    as SwapMode,
        dexes:
            freezed == dexes
                ? _value._dexes
                : dexes // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
        excludeDexes:
            freezed == excludeDexes
                ? _value._excludeDexes
                : excludeDexes // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
        onlyDirectRoutes:
            freezed == onlyDirectRoutes
                ? _value.onlyDirectRoutes
                : onlyDirectRoutes // ignore: cast_nullable_to_non_nullable
                    as bool?,
        asLegacyTransaction:
            freezed == asLegacyTransaction
                ? _value.asLegacyTransaction
                : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
                    as bool?,
        platformFeeBps:
            freezed == platformFeeBps
                ? _value.platformFeeBps
                : platformFeeBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        maxAccounts:
            freezed == maxAccounts
                ? _value.maxAccounts
                : maxAccounts // ignore: cast_nullable_to_non_nullable
                    as int?,
        restrictIntermediateTokens:
            freezed == restrictIntermediateTokens
                ? _value.restrictIntermediateTokens
                : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
                    as bool?,
        autoSlippage:
            freezed == autoSlippage
                ? _value.autoSlippage
                : autoSlippage // ignore: cast_nullable_to_non_nullable
                    as bool?,
        maxAutoSlippageBps:
            freezed == maxAutoSlippageBps
                ? _value.maxAutoSlippageBps
                : maxAutoSlippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        autoSlippageCollisionUsdValue:
            freezed == autoSlippageCollisionUsdValue
                ? _value.autoSlippageCollisionUsdValue
                : autoSlippageCollisionUsdValue // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteRequestDtoImpl implements _QuoteRequestDto {
  const _$QuoteRequestDtoImpl({
    required this.inputMint,
    required this.outputMint,
    required this.amount,
    this.slippageBps,
    this.swapMode = SwapMode.exactIn,
    final List<String>? dexes,
    final List<String>? excludeDexes,
    this.onlyDirectRoutes,
    this.asLegacyTransaction,
    this.platformFeeBps,
    this.maxAccounts,
    this.restrictIntermediateTokens,
    this.autoSlippage,
    this.maxAutoSlippageBps,
    this.autoSlippageCollisionUsdValue,
  }) : _dexes = dexes,
       _excludeDexes = excludeDexes;

  factory _$QuoteRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteRequestDtoImplFromJson(json);

  @override
  final String inputMint;
  @override
  final String outputMint;
  @override
  final int amount;
  @override
  final int? slippageBps;
  @override
  @JsonKey()
  final SwapMode swapMode;
  final List<String>? _dexes;
  @override
  List<String>? get dexes {
    final value = _dexes;
    if (value == null) return null;
    if (_dexes is EqualUnmodifiableListView) return _dexes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _excludeDexes;
  @override
  List<String>? get excludeDexes {
    final value = _excludeDexes;
    if (value == null) return null;
    if (_excludeDexes is EqualUnmodifiableListView) return _excludeDexes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? onlyDirectRoutes;
  @override
  final bool? asLegacyTransaction;
  @override
  final int? platformFeeBps;
  @override
  final int? maxAccounts;
  @override
  final bool? restrictIntermediateTokens;
  @override
  final bool? autoSlippage;
  @override
  final int? maxAutoSlippageBps;
  @override
  final int? autoSlippageCollisionUsdValue;

  @override
  String toString() {
    return 'QuoteRequestDto(inputMint: $inputMint, outputMint: $outputMint, amount: $amount, slippageBps: $slippageBps, swapMode: $swapMode, dexes: $dexes, excludeDexes: $excludeDexes, onlyDirectRoutes: $onlyDirectRoutes, asLegacyTransaction: $asLegacyTransaction, platformFeeBps: $platformFeeBps, maxAccounts: $maxAccounts, restrictIntermediateTokens: $restrictIntermediateTokens, autoSlippage: $autoSlippage, maxAutoSlippageBps: $maxAutoSlippageBps, autoSlippageCollisionUsdValue: $autoSlippageCollisionUsdValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteRequestDtoImpl &&
            (identical(other.inputMint, inputMint) || other.inputMint == inputMint) &&
            (identical(other.outputMint, outputMint) || other.outputMint == outputMint) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.slippageBps, slippageBps) || other.slippageBps == slippageBps) &&
            (identical(other.swapMode, swapMode) || other.swapMode == swapMode) &&
            const DeepCollectionEquality().equals(other._dexes, _dexes) &&
            const DeepCollectionEquality().equals(other._excludeDexes, _excludeDexes) &&
            (identical(other.onlyDirectRoutes, onlyDirectRoutes) ||
                other.onlyDirectRoutes == onlyDirectRoutes) &&
            (identical(other.asLegacyTransaction, asLegacyTransaction) ||
                other.asLegacyTransaction == asLegacyTransaction) &&
            (identical(other.platformFeeBps, platformFeeBps) ||
                other.platformFeeBps == platformFeeBps) &&
            (identical(other.maxAccounts, maxAccounts) || other.maxAccounts == maxAccounts) &&
            (identical(other.restrictIntermediateTokens, restrictIntermediateTokens) ||
                other.restrictIntermediateTokens == restrictIntermediateTokens) &&
            (identical(other.autoSlippage, autoSlippage) || other.autoSlippage == autoSlippage) &&
            (identical(other.maxAutoSlippageBps, maxAutoSlippageBps) ||
                other.maxAutoSlippageBps == maxAutoSlippageBps) &&
            (identical(other.autoSlippageCollisionUsdValue, autoSlippageCollisionUsdValue) ||
                other.autoSlippageCollisionUsdValue == autoSlippageCollisionUsdValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    inputMint,
    outputMint,
    amount,
    slippageBps,
    swapMode,
    const DeepCollectionEquality().hash(_dexes),
    const DeepCollectionEquality().hash(_excludeDexes),
    onlyDirectRoutes,
    asLegacyTransaction,
    platformFeeBps,
    maxAccounts,
    restrictIntermediateTokens,
    autoSlippage,
    maxAutoSlippageBps,
    autoSlippageCollisionUsdValue,
  );

  /// Create a copy of QuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteRequestDtoImplCopyWith<_$QuoteRequestDtoImpl> get copyWith =>
      __$$QuoteRequestDtoImplCopyWithImpl<_$QuoteRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteRequestDtoImplToJson(this);
  }
}

abstract class _QuoteRequestDto implements QuoteRequestDto {
  const factory _QuoteRequestDto({
    required final String inputMint,
    required final String outputMint,
    required final int amount,
    final int? slippageBps,
    final SwapMode swapMode,
    final List<String>? dexes,
    final List<String>? excludeDexes,
    final bool? onlyDirectRoutes,
    final bool? asLegacyTransaction,
    final int? platformFeeBps,
    final int? maxAccounts,
    final bool? restrictIntermediateTokens,
    final bool? autoSlippage,
    final int? maxAutoSlippageBps,
    final int? autoSlippageCollisionUsdValue,
  }) = _$QuoteRequestDtoImpl;

  factory _QuoteRequestDto.fromJson(Map<String, dynamic> json) = _$QuoteRequestDtoImpl.fromJson;

  @override
  String get inputMint;
  @override
  String get outputMint;
  @override
  int get amount;
  @override
  int? get slippageBps;
  @override
  SwapMode get swapMode;
  @override
  List<String>? get dexes;
  @override
  List<String>? get excludeDexes;
  @override
  bool? get onlyDirectRoutes;
  @override
  bool? get asLegacyTransaction;
  @override
  int? get platformFeeBps;
  @override
  int? get maxAccounts;
  @override
  bool? get restrictIntermediateTokens;
  @override
  bool? get autoSlippage;
  @override
  int? get maxAutoSlippageBps;
  @override
  int? get autoSlippageCollisionUsdValue;

  /// Create a copy of QuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteRequestDtoImplCopyWith<_$QuoteRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JupiterSwapRequestDto _$JupiterSwapRequestDtoFromJson(Map<String, dynamic> json) {
  return _JupiterSwapRequestDto.fromJson(json);
}

/// @nodoc
mixin _$JupiterSwapRequestDto {
  String get userPublicKey => throw _privateConstructorUsedError;
  QuoteResponseDto get quoteResponse => throw _privateConstructorUsedError;
  bool? get wrapAndUnwrapSol => throw _privateConstructorUsedError;
  bool? get useSharedAccounts => throw _privateConstructorUsedError;
  String? get feeAccount => throw _privateConstructorUsedError;
  int? get computeUnitPriceMicroLamports => throw _privateConstructorUsedError;
  int? get prioritizationFeeLamports => throw _privateConstructorUsedError;
  bool? get asLegacyTransaction => throw _privateConstructorUsedError;
  bool? get restrictIntermediateTokens => throw _privateConstructorUsedError;
  bool? get useTokenLedger => throw _privateConstructorUsedError;
  String? get destinationTokenAccount => throw _privateConstructorUsedError;
  bool? get dynamicComputeUnitLimit => throw _privateConstructorUsedError;
  bool? get skipUserAccountsRpcCalls => throw _privateConstructorUsedError;
  String? get trackingAccount => throw _privateConstructorUsedError;
  DynamicSlippage? get dynamicSlippage => throw _privateConstructorUsedError;

  /// Serializes this JupiterSwapRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JupiterSwapRequestDtoCopyWith<JupiterSwapRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterSwapRequestDtoCopyWith<$Res> {
  factory $JupiterSwapRequestDtoCopyWith(
    JupiterSwapRequestDto value,
    $Res Function(JupiterSwapRequestDto) then,
  ) = _$JupiterSwapRequestDtoCopyWithImpl<$Res, JupiterSwapRequestDto>;
  @useResult
  $Res call({
    String userPublicKey,
    QuoteResponseDto quoteResponse,
    bool? wrapAndUnwrapSol,
    bool? useSharedAccounts,
    String? feeAccount,
    int? computeUnitPriceMicroLamports,
    int? prioritizationFeeLamports,
    bool? asLegacyTransaction,
    bool? restrictIntermediateTokens,
    bool? useTokenLedger,
    String? destinationTokenAccount,
    bool? dynamicComputeUnitLimit,
    bool? skipUserAccountsRpcCalls,
    String? trackingAccount,
    DynamicSlippage? dynamicSlippage,
  });

  $QuoteResponseDtoCopyWith<$Res> get quoteResponse;
  $DynamicSlippageCopyWith<$Res>? get dynamicSlippage;
}

/// @nodoc
class _$JupiterSwapRequestDtoCopyWithImpl<$Res, $Val extends JupiterSwapRequestDto>
    implements $JupiterSwapRequestDtoCopyWith<$Res> {
  _$JupiterSwapRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userPublicKey = null,
    Object? quoteResponse = null,
    Object? wrapAndUnwrapSol = freezed,
    Object? useSharedAccounts = freezed,
    Object? feeAccount = freezed,
    Object? computeUnitPriceMicroLamports = freezed,
    Object? prioritizationFeeLamports = freezed,
    Object? asLegacyTransaction = freezed,
    Object? restrictIntermediateTokens = freezed,
    Object? useTokenLedger = freezed,
    Object? destinationTokenAccount = freezed,
    Object? dynamicComputeUnitLimit = freezed,
    Object? skipUserAccountsRpcCalls = freezed,
    Object? trackingAccount = freezed,
    Object? dynamicSlippage = freezed,
  }) {
    return _then(
      _value.copyWith(
            userPublicKey:
                null == userPublicKey
                    ? _value.userPublicKey
                    : userPublicKey // ignore: cast_nullable_to_non_nullable
                        as String,
            quoteResponse:
                null == quoteResponse
                    ? _value.quoteResponse
                    : quoteResponse // ignore: cast_nullable_to_non_nullable
                        as QuoteResponseDto,
            wrapAndUnwrapSol:
                freezed == wrapAndUnwrapSol
                    ? _value.wrapAndUnwrapSol
                    : wrapAndUnwrapSol // ignore: cast_nullable_to_non_nullable
                        as bool?,
            useSharedAccounts:
                freezed == useSharedAccounts
                    ? _value.useSharedAccounts
                    : useSharedAccounts // ignore: cast_nullable_to_non_nullable
                        as bool?,
            feeAccount:
                freezed == feeAccount
                    ? _value.feeAccount
                    : feeAccount // ignore: cast_nullable_to_non_nullable
                        as String?,
            computeUnitPriceMicroLamports:
                freezed == computeUnitPriceMicroLamports
                    ? _value.computeUnitPriceMicroLamports
                    : computeUnitPriceMicroLamports // ignore: cast_nullable_to_non_nullable
                        as int?,
            prioritizationFeeLamports:
                freezed == prioritizationFeeLamports
                    ? _value.prioritizationFeeLamports
                    : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
                        as int?,
            asLegacyTransaction:
                freezed == asLegacyTransaction
                    ? _value.asLegacyTransaction
                    : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
                        as bool?,
            restrictIntermediateTokens:
                freezed == restrictIntermediateTokens
                    ? _value.restrictIntermediateTokens
                    : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
                        as bool?,
            useTokenLedger:
                freezed == useTokenLedger
                    ? _value.useTokenLedger
                    : useTokenLedger // ignore: cast_nullable_to_non_nullable
                        as bool?,
            destinationTokenAccount:
                freezed == destinationTokenAccount
                    ? _value.destinationTokenAccount
                    : destinationTokenAccount // ignore: cast_nullable_to_non_nullable
                        as String?,
            dynamicComputeUnitLimit:
                freezed == dynamicComputeUnitLimit
                    ? _value.dynamicComputeUnitLimit
                    : dynamicComputeUnitLimit // ignore: cast_nullable_to_non_nullable
                        as bool?,
            skipUserAccountsRpcCalls:
                freezed == skipUserAccountsRpcCalls
                    ? _value.skipUserAccountsRpcCalls
                    : skipUserAccountsRpcCalls // ignore: cast_nullable_to_non_nullable
                        as bool?,
            trackingAccount:
                freezed == trackingAccount
                    ? _value.trackingAccount
                    : trackingAccount // ignore: cast_nullable_to_non_nullable
                        as String?,
            dynamicSlippage:
                freezed == dynamicSlippage
                    ? _value.dynamicSlippage
                    : dynamicSlippage // ignore: cast_nullable_to_non_nullable
                        as DynamicSlippage?,
          )
          as $Val,
    );
  }

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteResponseDtoCopyWith<$Res> get quoteResponse {
    return $QuoteResponseDtoCopyWith<$Res>(_value.quoteResponse, (value) {
      return _then(_value.copyWith(quoteResponse: value) as $Val);
    });
  }

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DynamicSlippageCopyWith<$Res>? get dynamicSlippage {
    if (_value.dynamicSlippage == null) {
      return null;
    }

    return $DynamicSlippageCopyWith<$Res>(_value.dynamicSlippage!, (value) {
      return _then(_value.copyWith(dynamicSlippage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JupiterSwapRequestDtoImplCopyWith<$Res>
    implements $JupiterSwapRequestDtoCopyWith<$Res> {
  factory _$$JupiterSwapRequestDtoImplCopyWith(
    _$JupiterSwapRequestDtoImpl value,
    $Res Function(_$JupiterSwapRequestDtoImpl) then,
  ) = __$$JupiterSwapRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userPublicKey,
    QuoteResponseDto quoteResponse,
    bool? wrapAndUnwrapSol,
    bool? useSharedAccounts,
    String? feeAccount,
    int? computeUnitPriceMicroLamports,
    int? prioritizationFeeLamports,
    bool? asLegacyTransaction,
    bool? restrictIntermediateTokens,
    bool? useTokenLedger,
    String? destinationTokenAccount,
    bool? dynamicComputeUnitLimit,
    bool? skipUserAccountsRpcCalls,
    String? trackingAccount,
    DynamicSlippage? dynamicSlippage,
  });

  @override
  $QuoteResponseDtoCopyWith<$Res> get quoteResponse;
  @override
  $DynamicSlippageCopyWith<$Res>? get dynamicSlippage;
}

/// @nodoc
class __$$JupiterSwapRequestDtoImplCopyWithImpl<$Res>
    extends _$JupiterSwapRequestDtoCopyWithImpl<$Res, _$JupiterSwapRequestDtoImpl>
    implements _$$JupiterSwapRequestDtoImplCopyWith<$Res> {
  __$$JupiterSwapRequestDtoImplCopyWithImpl(
    _$JupiterSwapRequestDtoImpl _value,
    $Res Function(_$JupiterSwapRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userPublicKey = null,
    Object? quoteResponse = null,
    Object? wrapAndUnwrapSol = freezed,
    Object? useSharedAccounts = freezed,
    Object? feeAccount = freezed,
    Object? computeUnitPriceMicroLamports = freezed,
    Object? prioritizationFeeLamports = freezed,
    Object? asLegacyTransaction = freezed,
    Object? restrictIntermediateTokens = freezed,
    Object? useTokenLedger = freezed,
    Object? destinationTokenAccount = freezed,
    Object? dynamicComputeUnitLimit = freezed,
    Object? skipUserAccountsRpcCalls = freezed,
    Object? trackingAccount = freezed,
    Object? dynamicSlippage = freezed,
  }) {
    return _then(
      _$JupiterSwapRequestDtoImpl(
        userPublicKey:
            null == userPublicKey
                ? _value.userPublicKey
                : userPublicKey // ignore: cast_nullable_to_non_nullable
                    as String,
        quoteResponse:
            null == quoteResponse
                ? _value.quoteResponse
                : quoteResponse // ignore: cast_nullable_to_non_nullable
                    as QuoteResponseDto,
        wrapAndUnwrapSol:
            freezed == wrapAndUnwrapSol
                ? _value.wrapAndUnwrapSol
                : wrapAndUnwrapSol // ignore: cast_nullable_to_non_nullable
                    as bool?,
        useSharedAccounts:
            freezed == useSharedAccounts
                ? _value.useSharedAccounts
                : useSharedAccounts // ignore: cast_nullable_to_non_nullable
                    as bool?,
        feeAccount:
            freezed == feeAccount
                ? _value.feeAccount
                : feeAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        computeUnitPriceMicroLamports:
            freezed == computeUnitPriceMicroLamports
                ? _value.computeUnitPriceMicroLamports
                : computeUnitPriceMicroLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        prioritizationFeeLamports:
            freezed == prioritizationFeeLamports
                ? _value.prioritizationFeeLamports
                : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        asLegacyTransaction:
            freezed == asLegacyTransaction
                ? _value.asLegacyTransaction
                : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
                    as bool?,
        restrictIntermediateTokens:
            freezed == restrictIntermediateTokens
                ? _value.restrictIntermediateTokens
                : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
                    as bool?,
        useTokenLedger:
            freezed == useTokenLedger
                ? _value.useTokenLedger
                : useTokenLedger // ignore: cast_nullable_to_non_nullable
                    as bool?,
        destinationTokenAccount:
            freezed == destinationTokenAccount
                ? _value.destinationTokenAccount
                : destinationTokenAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        dynamicComputeUnitLimit:
            freezed == dynamicComputeUnitLimit
                ? _value.dynamicComputeUnitLimit
                : dynamicComputeUnitLimit // ignore: cast_nullable_to_non_nullable
                    as bool?,
        skipUserAccountsRpcCalls:
            freezed == skipUserAccountsRpcCalls
                ? _value.skipUserAccountsRpcCalls
                : skipUserAccountsRpcCalls // ignore: cast_nullable_to_non_nullable
                    as bool?,
        trackingAccount:
            freezed == trackingAccount
                ? _value.trackingAccount
                : trackingAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        dynamicSlippage:
            freezed == dynamicSlippage
                ? _value.dynamicSlippage
                : dynamicSlippage // ignore: cast_nullable_to_non_nullable
                    as DynamicSlippage?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterSwapRequestDtoImpl implements _JupiterSwapRequestDto {
  const _$JupiterSwapRequestDtoImpl({
    required this.userPublicKey,
    required this.quoteResponse,
    this.wrapAndUnwrapSol = true,
    this.useSharedAccounts = true,
    this.feeAccount,
    this.computeUnitPriceMicroLamports,
    this.prioritizationFeeLamports,
    this.asLegacyTransaction,
    this.restrictIntermediateTokens,
    this.useTokenLedger,
    this.destinationTokenAccount,
    this.dynamicComputeUnitLimit,
    this.skipUserAccountsRpcCalls,
    this.trackingAccount,
    this.dynamicSlippage,
  });

  factory _$JupiterSwapRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterSwapRequestDtoImplFromJson(json);

  @override
  final String userPublicKey;
  @override
  final QuoteResponseDto quoteResponse;
  @override
  @JsonKey()
  final bool? wrapAndUnwrapSol;
  @override
  @JsonKey()
  final bool? useSharedAccounts;
  @override
  final String? feeAccount;
  @override
  final int? computeUnitPriceMicroLamports;
  @override
  final int? prioritizationFeeLamports;
  @override
  final bool? asLegacyTransaction;
  @override
  final bool? restrictIntermediateTokens;
  @override
  final bool? useTokenLedger;
  @override
  final String? destinationTokenAccount;
  @override
  final bool? dynamicComputeUnitLimit;
  @override
  final bool? skipUserAccountsRpcCalls;
  @override
  final String? trackingAccount;
  @override
  final DynamicSlippage? dynamicSlippage;

  @override
  String toString() {
    return 'JupiterSwapRequestDto(userPublicKey: $userPublicKey, quoteResponse: $quoteResponse, wrapAndUnwrapSol: $wrapAndUnwrapSol, useSharedAccounts: $useSharedAccounts, feeAccount: $feeAccount, computeUnitPriceMicroLamports: $computeUnitPriceMicroLamports, prioritizationFeeLamports: $prioritizationFeeLamports, asLegacyTransaction: $asLegacyTransaction, restrictIntermediateTokens: $restrictIntermediateTokens, useTokenLedger: $useTokenLedger, destinationTokenAccount: $destinationTokenAccount, dynamicComputeUnitLimit: $dynamicComputeUnitLimit, skipUserAccountsRpcCalls: $skipUserAccountsRpcCalls, trackingAccount: $trackingAccount, dynamicSlippage: $dynamicSlippage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JupiterSwapRequestDtoImpl &&
            (identical(other.userPublicKey, userPublicKey) ||
                other.userPublicKey == userPublicKey) &&
            (identical(other.quoteResponse, quoteResponse) ||
                other.quoteResponse == quoteResponse) &&
            (identical(other.wrapAndUnwrapSol, wrapAndUnwrapSol) ||
                other.wrapAndUnwrapSol == wrapAndUnwrapSol) &&
            (identical(other.useSharedAccounts, useSharedAccounts) ||
                other.useSharedAccounts == useSharedAccounts) &&
            (identical(other.feeAccount, feeAccount) || other.feeAccount == feeAccount) &&
            (identical(other.computeUnitPriceMicroLamports, computeUnitPriceMicroLamports) ||
                other.computeUnitPriceMicroLamports == computeUnitPriceMicroLamports) &&
            (identical(other.prioritizationFeeLamports, prioritizationFeeLamports) ||
                other.prioritizationFeeLamports == prioritizationFeeLamports) &&
            (identical(other.asLegacyTransaction, asLegacyTransaction) ||
                other.asLegacyTransaction == asLegacyTransaction) &&
            (identical(other.restrictIntermediateTokens, restrictIntermediateTokens) ||
                other.restrictIntermediateTokens == restrictIntermediateTokens) &&
            (identical(other.useTokenLedger, useTokenLedger) ||
                other.useTokenLedger == useTokenLedger) &&
            (identical(other.destinationTokenAccount, destinationTokenAccount) ||
                other.destinationTokenAccount == destinationTokenAccount) &&
            (identical(other.dynamicComputeUnitLimit, dynamicComputeUnitLimit) ||
                other.dynamicComputeUnitLimit == dynamicComputeUnitLimit) &&
            (identical(other.skipUserAccountsRpcCalls, skipUserAccountsRpcCalls) ||
                other.skipUserAccountsRpcCalls == skipUserAccountsRpcCalls) &&
            (identical(other.trackingAccount, trackingAccount) ||
                other.trackingAccount == trackingAccount) &&
            (identical(other.dynamicSlippage, dynamicSlippage) ||
                other.dynamicSlippage == dynamicSlippage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userPublicKey,
    quoteResponse,
    wrapAndUnwrapSol,
    useSharedAccounts,
    feeAccount,
    computeUnitPriceMicroLamports,
    prioritizationFeeLamports,
    asLegacyTransaction,
    restrictIntermediateTokens,
    useTokenLedger,
    destinationTokenAccount,
    dynamicComputeUnitLimit,
    skipUserAccountsRpcCalls,
    trackingAccount,
    dynamicSlippage,
  );

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterSwapRequestDtoImplCopyWith<_$JupiterSwapRequestDtoImpl> get copyWith =>
      __$$JupiterSwapRequestDtoImplCopyWithImpl<_$JupiterSwapRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterSwapRequestDtoImplToJson(this);
  }
}

abstract class _JupiterSwapRequestDto implements JupiterSwapRequestDto {
  const factory _JupiterSwapRequestDto({
    required final String userPublicKey,
    required final QuoteResponseDto quoteResponse,
    final bool? wrapAndUnwrapSol,
    final bool? useSharedAccounts,
    final String? feeAccount,
    final int? computeUnitPriceMicroLamports,
    final int? prioritizationFeeLamports,
    final bool? asLegacyTransaction,
    final bool? restrictIntermediateTokens,
    final bool? useTokenLedger,
    final String? destinationTokenAccount,
    final bool? dynamicComputeUnitLimit,
    final bool? skipUserAccountsRpcCalls,
    final String? trackingAccount,
    final DynamicSlippage? dynamicSlippage,
  }) = _$JupiterSwapRequestDtoImpl;

  factory _JupiterSwapRequestDto.fromJson(Map<String, dynamic> json) =
      _$JupiterSwapRequestDtoImpl.fromJson;

  @override
  String get userPublicKey;
  @override
  QuoteResponseDto get quoteResponse;
  @override
  bool? get wrapAndUnwrapSol;
  @override
  bool? get useSharedAccounts;
  @override
  String? get feeAccount;
  @override
  int? get computeUnitPriceMicroLamports;
  @override
  int? get prioritizationFeeLamports;
  @override
  bool? get asLegacyTransaction;
  @override
  bool? get restrictIntermediateTokens;
  @override
  bool? get useTokenLedger;
  @override
  String? get destinationTokenAccount;
  @override
  bool? get dynamicComputeUnitLimit;
  @override
  bool? get skipUserAccountsRpcCalls;
  @override
  String? get trackingAccount;
  @override
  DynamicSlippage? get dynamicSlippage;

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JupiterSwapRequestDtoImplCopyWith<_$JupiterSwapRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DynamicSlippage _$DynamicSlippageFromJson(Map<String, dynamic> json) {
  return _DynamicSlippage.fromJson(json);
}

/// @nodoc
mixin _$DynamicSlippage {
  int get minBps => throw _privateConstructorUsedError;
  int get maxBps => throw _privateConstructorUsedError;

  /// Serializes this DynamicSlippage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DynamicSlippageCopyWith<DynamicSlippage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicSlippageCopyWith<$Res> {
  factory $DynamicSlippageCopyWith(DynamicSlippage value, $Res Function(DynamicSlippage) then) =
      _$DynamicSlippageCopyWithImpl<$Res, DynamicSlippage>;
  @useResult
  $Res call({int minBps, int maxBps});
}

/// @nodoc
class _$DynamicSlippageCopyWithImpl<$Res, $Val extends DynamicSlippage>
    implements $DynamicSlippageCopyWith<$Res> {
  _$DynamicSlippageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? minBps = null, Object? maxBps = null}) {
    return _then(
      _value.copyWith(
            minBps:
                null == minBps
                    ? _value.minBps
                    : minBps // ignore: cast_nullable_to_non_nullable
                        as int,
            maxBps:
                null == maxBps
                    ? _value.maxBps
                    : maxBps // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DynamicSlippageImplCopyWith<$Res> implements $DynamicSlippageCopyWith<$Res> {
  factory _$$DynamicSlippageImplCopyWith(
    _$DynamicSlippageImpl value,
    $Res Function(_$DynamicSlippageImpl) then,
  ) = __$$DynamicSlippageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int minBps, int maxBps});
}

/// @nodoc
class __$$DynamicSlippageImplCopyWithImpl<$Res>
    extends _$DynamicSlippageCopyWithImpl<$Res, _$DynamicSlippageImpl>
    implements _$$DynamicSlippageImplCopyWith<$Res> {
  __$$DynamicSlippageImplCopyWithImpl(
    _$DynamicSlippageImpl _value,
    $Res Function(_$DynamicSlippageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? minBps = null, Object? maxBps = null}) {
    return _then(
      _$DynamicSlippageImpl(
        minBps:
            null == minBps
                ? _value.minBps
                : minBps // ignore: cast_nullable_to_non_nullable
                    as int,
        maxBps:
            null == maxBps
                ? _value.maxBps
                : maxBps // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DynamicSlippageImpl implements _DynamicSlippage {
  const _$DynamicSlippageImpl({required this.minBps, required this.maxBps});

  factory _$DynamicSlippageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DynamicSlippageImplFromJson(json);

  @override
  final int minBps;
  @override
  final int maxBps;

  @override
  String toString() {
    return 'DynamicSlippage(minBps: $minBps, maxBps: $maxBps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DynamicSlippageImpl &&
            (identical(other.minBps, minBps) || other.minBps == minBps) &&
            (identical(other.maxBps, maxBps) || other.maxBps == maxBps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minBps, maxBps);

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DynamicSlippageImplCopyWith<_$DynamicSlippageImpl> get copyWith =>
      __$$DynamicSlippageImplCopyWithImpl<_$DynamicSlippageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DynamicSlippageImplToJson(this);
  }
}

abstract class _DynamicSlippage implements DynamicSlippage {
  const factory _DynamicSlippage({required final int minBps, required final int maxBps}) =
      _$DynamicSlippageImpl;

  factory _DynamicSlippage.fromJson(Map<String, dynamic> json) = _$DynamicSlippageImpl.fromJson;

  @override
  int get minBps;
  @override
  int get maxBps;

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DynamicSlippageImplCopyWith<_$DynamicSlippageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JupiterSwapResponseDto _$JupiterSwapResponseDtoFromJson(Map<String, dynamic> json) {
  return _JupiterSwapResponseDto.fromJson(json);
}

/// @nodoc
mixin _$JupiterSwapResponseDto {
  String get swapTransaction => throw _privateConstructorUsedError;
  int get lastValidBlockHeight => throw _privateConstructorUsedError;
  int? get prioritizationFeeLamports => throw _privateConstructorUsedError;
  DynamicSlippageReport? get dynamicSlippageReport => throw _privateConstructorUsedError;

  /// Serializes this JupiterSwapResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JupiterSwapResponseDtoCopyWith<JupiterSwapResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterSwapResponseDtoCopyWith<$Res> {
  factory $JupiterSwapResponseDtoCopyWith(
    JupiterSwapResponseDto value,
    $Res Function(JupiterSwapResponseDto) then,
  ) = _$JupiterSwapResponseDtoCopyWithImpl<$Res, JupiterSwapResponseDto>;
  @useResult
  $Res call({
    String swapTransaction,
    int lastValidBlockHeight,
    int? prioritizationFeeLamports,
    DynamicSlippageReport? dynamicSlippageReport,
  });

  $DynamicSlippageReportCopyWith<$Res>? get dynamicSlippageReport;
}

/// @nodoc
class _$JupiterSwapResponseDtoCopyWithImpl<$Res, $Val extends JupiterSwapResponseDto>
    implements $JupiterSwapResponseDtoCopyWith<$Res> {
  _$JupiterSwapResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapTransaction = null,
    Object? lastValidBlockHeight = null,
    Object? prioritizationFeeLamports = freezed,
    Object? dynamicSlippageReport = freezed,
  }) {
    return _then(
      _value.copyWith(
            swapTransaction:
                null == swapTransaction
                    ? _value.swapTransaction
                    : swapTransaction // ignore: cast_nullable_to_non_nullable
                        as String,
            lastValidBlockHeight:
                null == lastValidBlockHeight
                    ? _value.lastValidBlockHeight
                    : lastValidBlockHeight // ignore: cast_nullable_to_non_nullable
                        as int,
            prioritizationFeeLamports:
                freezed == prioritizationFeeLamports
                    ? _value.prioritizationFeeLamports
                    : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
                        as int?,
            dynamicSlippageReport:
                freezed == dynamicSlippageReport
                    ? _value.dynamicSlippageReport
                    : dynamicSlippageReport // ignore: cast_nullable_to_non_nullable
                        as DynamicSlippageReport?,
          )
          as $Val,
    );
  }

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DynamicSlippageReportCopyWith<$Res>? get dynamicSlippageReport {
    if (_value.dynamicSlippageReport == null) {
      return null;
    }

    return $DynamicSlippageReportCopyWith<$Res>(_value.dynamicSlippageReport!, (value) {
      return _then(_value.copyWith(dynamicSlippageReport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JupiterSwapResponseDtoImplCopyWith<$Res>
    implements $JupiterSwapResponseDtoCopyWith<$Res> {
  factory _$$JupiterSwapResponseDtoImplCopyWith(
    _$JupiterSwapResponseDtoImpl value,
    $Res Function(_$JupiterSwapResponseDtoImpl) then,
  ) = __$$JupiterSwapResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String swapTransaction,
    int lastValidBlockHeight,
    int? prioritizationFeeLamports,
    DynamicSlippageReport? dynamicSlippageReport,
  });

  @override
  $DynamicSlippageReportCopyWith<$Res>? get dynamicSlippageReport;
}

/// @nodoc
class __$$JupiterSwapResponseDtoImplCopyWithImpl<$Res>
    extends _$JupiterSwapResponseDtoCopyWithImpl<$Res, _$JupiterSwapResponseDtoImpl>
    implements _$$JupiterSwapResponseDtoImplCopyWith<$Res> {
  __$$JupiterSwapResponseDtoImplCopyWithImpl(
    _$JupiterSwapResponseDtoImpl _value,
    $Res Function(_$JupiterSwapResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapTransaction = null,
    Object? lastValidBlockHeight = null,
    Object? prioritizationFeeLamports = freezed,
    Object? dynamicSlippageReport = freezed,
  }) {
    return _then(
      _$JupiterSwapResponseDtoImpl(
        swapTransaction:
            null == swapTransaction
                ? _value.swapTransaction
                : swapTransaction // ignore: cast_nullable_to_non_nullable
                    as String,
        lastValidBlockHeight:
            null == lastValidBlockHeight
                ? _value.lastValidBlockHeight
                : lastValidBlockHeight // ignore: cast_nullable_to_non_nullable
                    as int,
        prioritizationFeeLamports:
            freezed == prioritizationFeeLamports
                ? _value.prioritizationFeeLamports
                : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        dynamicSlippageReport:
            freezed == dynamicSlippageReport
                ? _value.dynamicSlippageReport
                : dynamicSlippageReport // ignore: cast_nullable_to_non_nullable
                    as DynamicSlippageReport?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterSwapResponseDtoImpl implements _JupiterSwapResponseDto {
  const _$JupiterSwapResponseDtoImpl({
    required this.swapTransaction,
    required this.lastValidBlockHeight,
    this.prioritizationFeeLamports,
    this.dynamicSlippageReport,
  });

  factory _$JupiterSwapResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterSwapResponseDtoImplFromJson(json);

  @override
  final String swapTransaction;
  @override
  final int lastValidBlockHeight;
  @override
  final int? prioritizationFeeLamports;
  @override
  final DynamicSlippageReport? dynamicSlippageReport;

  @override
  String toString() {
    return 'JupiterSwapResponseDto(swapTransaction: $swapTransaction, lastValidBlockHeight: $lastValidBlockHeight, prioritizationFeeLamports: $prioritizationFeeLamports, dynamicSlippageReport: $dynamicSlippageReport)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JupiterSwapResponseDtoImpl &&
            (identical(other.swapTransaction, swapTransaction) ||
                other.swapTransaction == swapTransaction) &&
            (identical(other.lastValidBlockHeight, lastValidBlockHeight) ||
                other.lastValidBlockHeight == lastValidBlockHeight) &&
            (identical(other.prioritizationFeeLamports, prioritizationFeeLamports) ||
                other.prioritizationFeeLamports == prioritizationFeeLamports) &&
            (identical(other.dynamicSlippageReport, dynamicSlippageReport) ||
                other.dynamicSlippageReport == dynamicSlippageReport));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    swapTransaction,
    lastValidBlockHeight,
    prioritizationFeeLamports,
    dynamicSlippageReport,
  );

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterSwapResponseDtoImplCopyWith<_$JupiterSwapResponseDtoImpl> get copyWith =>
      __$$JupiterSwapResponseDtoImplCopyWithImpl<_$JupiterSwapResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterSwapResponseDtoImplToJson(this);
  }
}

abstract class _JupiterSwapResponseDto implements JupiterSwapResponseDto {
  const factory _JupiterSwapResponseDto({
    required final String swapTransaction,
    required final int lastValidBlockHeight,
    final int? prioritizationFeeLamports,
    final DynamicSlippageReport? dynamicSlippageReport,
  }) = _$JupiterSwapResponseDtoImpl;

  factory _JupiterSwapResponseDto.fromJson(Map<String, dynamic> json) =
      _$JupiterSwapResponseDtoImpl.fromJson;

  @override
  String get swapTransaction;
  @override
  int get lastValidBlockHeight;
  @override
  int? get prioritizationFeeLamports;
  @override
  DynamicSlippageReport? get dynamicSlippageReport;

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JupiterSwapResponseDtoImplCopyWith<_$JupiterSwapResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DynamicSlippageReport _$DynamicSlippageReportFromJson(Map<String, dynamic> json) {
  return _DynamicSlippageReport.fromJson(json);
}

/// @nodoc
mixin _$DynamicSlippageReport {
  int? get slippageBps => throw _privateConstructorUsedError;
  int? get otherAmount => throw _privateConstructorUsedError;
  int? get simulatedIncurredSlippageBps => throw _privateConstructorUsedError;
  String? get amplificationRatio => throw _privateConstructorUsedError;

  /// Serializes this DynamicSlippageReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DynamicSlippageReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DynamicSlippageReportCopyWith<DynamicSlippageReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicSlippageReportCopyWith<$Res> {
  factory $DynamicSlippageReportCopyWith(
    DynamicSlippageReport value,
    $Res Function(DynamicSlippageReport) then,
  ) = _$DynamicSlippageReportCopyWithImpl<$Res, DynamicSlippageReport>;
  @useResult
  $Res call({
    int? slippageBps,
    int? otherAmount,
    int? simulatedIncurredSlippageBps,
    String? amplificationRatio,
  });
}

/// @nodoc
class _$DynamicSlippageReportCopyWithImpl<$Res, $Val extends DynamicSlippageReport>
    implements $DynamicSlippageReportCopyWith<$Res> {
  _$DynamicSlippageReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DynamicSlippageReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slippageBps = freezed,
    Object? otherAmount = freezed,
    Object? simulatedIncurredSlippageBps = freezed,
    Object? amplificationRatio = freezed,
  }) {
    return _then(
      _value.copyWith(
            slippageBps:
                freezed == slippageBps
                    ? _value.slippageBps
                    : slippageBps // ignore: cast_nullable_to_non_nullable
                        as int?,
            otherAmount:
                freezed == otherAmount
                    ? _value.otherAmount
                    : otherAmount // ignore: cast_nullable_to_non_nullable
                        as int?,
            simulatedIncurredSlippageBps:
                freezed == simulatedIncurredSlippageBps
                    ? _value.simulatedIncurredSlippageBps
                    : simulatedIncurredSlippageBps // ignore: cast_nullable_to_non_nullable
                        as int?,
            amplificationRatio:
                freezed == amplificationRatio
                    ? _value.amplificationRatio
                    : amplificationRatio // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DynamicSlippageReportImplCopyWith<$Res>
    implements $DynamicSlippageReportCopyWith<$Res> {
  factory _$$DynamicSlippageReportImplCopyWith(
    _$DynamicSlippageReportImpl value,
    $Res Function(_$DynamicSlippageReportImpl) then,
  ) = __$$DynamicSlippageReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? slippageBps,
    int? otherAmount,
    int? simulatedIncurredSlippageBps,
    String? amplificationRatio,
  });
}

/// @nodoc
class __$$DynamicSlippageReportImplCopyWithImpl<$Res>
    extends _$DynamicSlippageReportCopyWithImpl<$Res, _$DynamicSlippageReportImpl>
    implements _$$DynamicSlippageReportImplCopyWith<$Res> {
  __$$DynamicSlippageReportImplCopyWithImpl(
    _$DynamicSlippageReportImpl _value,
    $Res Function(_$DynamicSlippageReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DynamicSlippageReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slippageBps = freezed,
    Object? otherAmount = freezed,
    Object? simulatedIncurredSlippageBps = freezed,
    Object? amplificationRatio = freezed,
  }) {
    return _then(
      _$DynamicSlippageReportImpl(
        slippageBps:
            freezed == slippageBps
                ? _value.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        otherAmount:
            freezed == otherAmount
                ? _value.otherAmount
                : otherAmount // ignore: cast_nullable_to_non_nullable
                    as int?,
        simulatedIncurredSlippageBps:
            freezed == simulatedIncurredSlippageBps
                ? _value.simulatedIncurredSlippageBps
                : simulatedIncurredSlippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        amplificationRatio:
            freezed == amplificationRatio
                ? _value.amplificationRatio
                : amplificationRatio // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DynamicSlippageReportImpl implements _DynamicSlippageReport {
  const _$DynamicSlippageReportImpl({
    this.slippageBps,
    this.otherAmount,
    this.simulatedIncurredSlippageBps,
    this.amplificationRatio,
  });

  factory _$DynamicSlippageReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$DynamicSlippageReportImplFromJson(json);

  @override
  final int? slippageBps;
  @override
  final int? otherAmount;
  @override
  final int? simulatedIncurredSlippageBps;
  @override
  final String? amplificationRatio;

  @override
  String toString() {
    return 'DynamicSlippageReport(slippageBps: $slippageBps, otherAmount: $otherAmount, simulatedIncurredSlippageBps: $simulatedIncurredSlippageBps, amplificationRatio: $amplificationRatio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DynamicSlippageReportImpl &&
            (identical(other.slippageBps, slippageBps) || other.slippageBps == slippageBps) &&
            (identical(other.otherAmount, otherAmount) || other.otherAmount == otherAmount) &&
            (identical(other.simulatedIncurredSlippageBps, simulatedIncurredSlippageBps) ||
                other.simulatedIncurredSlippageBps == simulatedIncurredSlippageBps) &&
            (identical(other.amplificationRatio, amplificationRatio) ||
                other.amplificationRatio == amplificationRatio));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    slippageBps,
    otherAmount,
    simulatedIncurredSlippageBps,
    amplificationRatio,
  );

  /// Create a copy of DynamicSlippageReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DynamicSlippageReportImplCopyWith<_$DynamicSlippageReportImpl> get copyWith =>
      __$$DynamicSlippageReportImplCopyWithImpl<_$DynamicSlippageReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DynamicSlippageReportImplToJson(this);
  }
}

abstract class _DynamicSlippageReport implements DynamicSlippageReport {
  const factory _DynamicSlippageReport({
    final int? slippageBps,
    final int? otherAmount,
    final int? simulatedIncurredSlippageBps,
    final String? amplificationRatio,
  }) = _$DynamicSlippageReportImpl;

  factory _DynamicSlippageReport.fromJson(Map<String, dynamic> json) =
      _$DynamicSlippageReportImpl.fromJson;

  @override
  int? get slippageBps;
  @override
  int? get otherAmount;
  @override
  int? get simulatedIncurredSlippageBps;
  @override
  String? get amplificationRatio;

  /// Create a copy of DynamicSlippageReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DynamicSlippageReportImplCopyWith<_$DynamicSlippageReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceRequestDto _$PriceRequestDtoFromJson(Map<String, dynamic> json) {
  return _PriceRequestDto.fromJson(json);
}

/// @nodoc
mixin _$PriceRequestDto {
  @JsonKey(toJson: _listToString)
  List<String> get ids => throw _privateConstructorUsedError;

  /// Serializes this PriceRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceRequestDtoCopyWith<PriceRequestDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceRequestDtoCopyWith<$Res> {
  factory $PriceRequestDtoCopyWith(PriceRequestDto value, $Res Function(PriceRequestDto) then) =
      _$PriceRequestDtoCopyWithImpl<$Res, PriceRequestDto>;
  @useResult
  $Res call({@JsonKey(toJson: _listToString) List<String> ids});
}

/// @nodoc
class _$PriceRequestDtoCopyWithImpl<$Res, $Val extends PriceRequestDto>
    implements $PriceRequestDtoCopyWith<$Res> {
  _$PriceRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ids = null}) {
    return _then(
      _value.copyWith(
            ids:
                null == ids
                    ? _value.ids
                    : ids // ignore: cast_nullable_to_non_nullable
                        as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceRequestDtoImplCopyWith<$Res> implements $PriceRequestDtoCopyWith<$Res> {
  factory _$$PriceRequestDtoImplCopyWith(
    _$PriceRequestDtoImpl value,
    $Res Function(_$PriceRequestDtoImpl) then,
  ) = __$$PriceRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(toJson: _listToString) List<String> ids});
}

/// @nodoc
class __$$PriceRequestDtoImplCopyWithImpl<$Res>
    extends _$PriceRequestDtoCopyWithImpl<$Res, _$PriceRequestDtoImpl>
    implements _$$PriceRequestDtoImplCopyWith<$Res> {
  __$$PriceRequestDtoImplCopyWithImpl(
    _$PriceRequestDtoImpl _value,
    $Res Function(_$PriceRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ids = null}) {
    return _then(
      _$PriceRequestDtoImpl(
        ids:
            null == ids
                ? _value._ids
                : ids // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceRequestDtoImpl implements _PriceRequestDto {
  const _$PriceRequestDtoImpl({@JsonKey(toJson: _listToString) required final List<String> ids})
    : _ids = ids;

  factory _$PriceRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceRequestDtoImplFromJson(json);

  final List<String> _ids;
  @override
  @JsonKey(toJson: _listToString)
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  @override
  String toString() {
    return 'PriceRequestDto(ids: $ids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceRequestDtoImpl &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceRequestDtoImplCopyWith<_$PriceRequestDtoImpl> get copyWith =>
      __$$PriceRequestDtoImplCopyWithImpl<_$PriceRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceRequestDtoImplToJson(this);
  }
}

abstract class _PriceRequestDto implements PriceRequestDto {
  const factory _PriceRequestDto({
    @JsonKey(toJson: _listToString) required final List<String> ids,
  }) = _$PriceRequestDtoImpl;

  factory _PriceRequestDto.fromJson(Map<String, dynamic> json) = _$PriceRequestDtoImpl.fromJson;

  @override
  @JsonKey(toJson: _listToString)
  List<String> get ids;

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceRequestDtoImplCopyWith<_$PriceRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceResponseDto _$PriceResponseDtoFromJson(Map<String, dynamic> json) {
  return _PriceResponseDto.fromJson(json);
}

/// @nodoc
mixin _$PriceResponseDto {
  Map<String, PriceDto> get data => throw _privateConstructorUsedError;

  /// Serializes this PriceResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceResponseDtoCopyWith<PriceResponseDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceResponseDtoCopyWith<$Res> {
  factory $PriceResponseDtoCopyWith(PriceResponseDto value, $Res Function(PriceResponseDto) then) =
      _$PriceResponseDtoCopyWithImpl<$Res, PriceResponseDto>;
  @useResult
  $Res call({Map<String, PriceDto> data});
}

/// @nodoc
class _$PriceResponseDtoCopyWithImpl<$Res, $Val extends PriceResponseDto>
    implements $PriceResponseDtoCopyWith<$Res> {
  _$PriceResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _value.copyWith(
            data:
                null == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as Map<String, PriceDto>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceResponseDtoImplCopyWith<$Res> implements $PriceResponseDtoCopyWith<$Res> {
  factory _$$PriceResponseDtoImplCopyWith(
    _$PriceResponseDtoImpl value,
    $Res Function(_$PriceResponseDtoImpl) then,
  ) = __$$PriceResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, PriceDto> data});
}

/// @nodoc
class __$$PriceResponseDtoImplCopyWithImpl<$Res>
    extends _$PriceResponseDtoCopyWithImpl<$Res, _$PriceResponseDtoImpl>
    implements _$$PriceResponseDtoImplCopyWith<$Res> {
  __$$PriceResponseDtoImplCopyWithImpl(
    _$PriceResponseDtoImpl _value,
    $Res Function(_$PriceResponseDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$PriceResponseDtoImpl(
        data:
            null == data
                ? _value._data
                : data // ignore: cast_nullable_to_non_nullable
                    as Map<String, PriceDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceResponseDtoImpl implements _PriceResponseDto {
  const _$PriceResponseDtoImpl({required final Map<String, PriceDto> data}) : _data = data;

  factory _$PriceResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceResponseDtoImplFromJson(json);

  final Map<String, PriceDto> _data;
  @override
  Map<String, PriceDto> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'PriceResponseDto(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceResponseDtoImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceResponseDtoImplCopyWith<_$PriceResponseDtoImpl> get copyWith =>
      __$$PriceResponseDtoImplCopyWithImpl<_$PriceResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceResponseDtoImplToJson(this);
  }
}

abstract class _PriceResponseDto implements PriceResponseDto {
  const factory _PriceResponseDto({required final Map<String, PriceDto> data}) =
      _$PriceResponseDtoImpl;

  factory _PriceResponseDto.fromJson(Map<String, dynamic> json) = _$PriceResponseDtoImpl.fromJson;

  @override
  Map<String, PriceDto> get data;

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceResponseDtoImplCopyWith<_$PriceResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceDto _$PriceDtoFromJson(Map<String, dynamic> json) {
  return _PriceDto.fromJson(json);
}

/// @nodoc
mixin _$PriceDto {
  String? get price => throw _privateConstructorUsedError;

  /// Serializes this PriceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceDtoCopyWith<PriceDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceDtoCopyWith<$Res> {
  factory $PriceDtoCopyWith(PriceDto value, $Res Function(PriceDto) then) =
      _$PriceDtoCopyWithImpl<$Res, PriceDto>;
  @useResult
  $Res call({String? price});
}

/// @nodoc
class _$PriceDtoCopyWithImpl<$Res, $Val extends PriceDto> implements $PriceDtoCopyWith<$Res> {
  _$PriceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? price = freezed}) {
    return _then(
      _value.copyWith(
            price:
                freezed == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PriceDtoImplCopyWith<$Res> implements $PriceDtoCopyWith<$Res> {
  factory _$$PriceDtoImplCopyWith(_$PriceDtoImpl value, $Res Function(_$PriceDtoImpl) then) =
      __$$PriceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? price});
}

/// @nodoc
class __$$PriceDtoImplCopyWithImpl<$Res> extends _$PriceDtoCopyWithImpl<$Res, _$PriceDtoImpl>
    implements _$$PriceDtoImplCopyWith<$Res> {
  __$$PriceDtoImplCopyWithImpl(_$PriceDtoImpl _value, $Res Function(_$PriceDtoImpl) _then)
    : super(_value, _then);

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? price = freezed}) {
    return _then(
      _$PriceDtoImpl(
        price:
            freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceDtoImpl implements _PriceDto {
  const _$PriceDtoImpl({required this.price});

  factory _$PriceDtoImpl.fromJson(Map<String, dynamic> json) => _$$PriceDtoImplFromJson(json);

  @override
  final String? price;

  @override
  String toString() {
    return 'PriceDto(price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceDtoImpl &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, price);

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceDtoImplCopyWith<_$PriceDtoImpl> get copyWith =>
      __$$PriceDtoImplCopyWithImpl<_$PriceDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceDtoImplToJson(this);
  }
}

abstract class _PriceDto implements PriceDto {
  const factory _PriceDto({required final String? price}) = _$PriceDtoImpl;

  factory _PriceDto.fromJson(Map<String, dynamic> json) = _$PriceDtoImpl.fromJson;

  @override
  String? get price;

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceDtoImplCopyWith<_$PriceDtoImpl> get copyWith => throw _privateConstructorUsedError;
}
