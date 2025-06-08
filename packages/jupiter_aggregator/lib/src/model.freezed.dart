// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JupiterMarketFee {
  String? get amount;
  num? get feeBps;

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JupiterMarketFeeCopyWith<JupiterMarketFee> get copyWith =>
      _$JupiterMarketFeeCopyWithImpl<JupiterMarketFee>(this as JupiterMarketFee, _$identity);

  /// Serializes this JupiterMarketFee to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JupiterMarketFee &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.feeBps, feeBps) || other.feeBps == feeBps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, feeBps);

  @override
  String toString() {
    return 'JupiterMarketFee(amount: $amount, feeBps: $feeBps)';
  }
}

/// @nodoc
abstract mixin class $JupiterMarketFeeCopyWith<$Res> {
  factory $JupiterMarketFeeCopyWith(JupiterMarketFee value, $Res Function(JupiterMarketFee) _then) =
      _$JupiterMarketFeeCopyWithImpl;
  @useResult
  $Res call({String? amount, num? feeBps});
}

/// @nodoc
class _$JupiterMarketFeeCopyWithImpl<$Res> implements $JupiterMarketFeeCopyWith<$Res> {
  _$JupiterMarketFeeCopyWithImpl(this._self, this._then);

  final JupiterMarketFee _self;
  final $Res Function(JupiterMarketFee) _then;

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? amount = freezed, Object? feeBps = freezed}) {
    return _then(
      _self.copyWith(
        amount:
            freezed == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as String?,
        feeBps:
            freezed == feeBps
                ? _self.feeBps
                : feeBps // ignore: cast_nullable_to_non_nullable
                    as num?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _JupiterMarketFee implements JupiterMarketFee {
  const _JupiterMarketFee({this.amount, this.feeBps});
  factory _JupiterMarketFee.fromJson(Map<String, dynamic> json) => _$JupiterMarketFeeFromJson(json);

  @override
  final String? amount;
  @override
  final num? feeBps;

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JupiterMarketFeeCopyWith<_JupiterMarketFee> get copyWith =>
      __$JupiterMarketFeeCopyWithImpl<_JupiterMarketFee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JupiterMarketFeeToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JupiterMarketFee &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.feeBps, feeBps) || other.feeBps == feeBps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, feeBps);

  @override
  String toString() {
    return 'JupiterMarketFee(amount: $amount, feeBps: $feeBps)';
  }
}

/// @nodoc
abstract mixin class _$JupiterMarketFeeCopyWith<$Res> implements $JupiterMarketFeeCopyWith<$Res> {
  factory _$JupiterMarketFeeCopyWith(
    _JupiterMarketFee value,
    $Res Function(_JupiterMarketFee) _then,
  ) = __$JupiterMarketFeeCopyWithImpl;
  @override
  @useResult
  $Res call({String? amount, num? feeBps});
}

/// @nodoc
class __$JupiterMarketFeeCopyWithImpl<$Res> implements _$JupiterMarketFeeCopyWith<$Res> {
  __$JupiterMarketFeeCopyWithImpl(this._self, this._then);

  final _JupiterMarketFee _self;
  final $Res Function(_JupiterMarketFee) _then;

  /// Create a copy of JupiterMarketFee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? amount = freezed, Object? feeBps = freezed}) {
    return _then(
      _JupiterMarketFee(
        amount:
            freezed == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as String?,
        feeBps:
            freezed == feeBps
                ? _self.feeBps
                : feeBps // ignore: cast_nullable_to_non_nullable
                    as num?,
      ),
    );
  }
}

/// @nodoc
mixin _$RoutePlan {
  JupiterSwapInfo get swapInfo;
  int get percent;

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RoutePlanCopyWith<RoutePlan> get copyWith =>
      _$RoutePlanCopyWithImpl<RoutePlan>(this as RoutePlan, _$identity);

  /// Serializes this RoutePlan to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RoutePlan &&
            (identical(other.swapInfo, swapInfo) || other.swapInfo == swapInfo) &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, swapInfo, percent);

  @override
  String toString() {
    return 'RoutePlan(swapInfo: $swapInfo, percent: $percent)';
  }
}

/// @nodoc
abstract mixin class $RoutePlanCopyWith<$Res> {
  factory $RoutePlanCopyWith(RoutePlan value, $Res Function(RoutePlan) _then) =
      _$RoutePlanCopyWithImpl;
  @useResult
  $Res call({JupiterSwapInfo swapInfo, int percent});

  $JupiterSwapInfoCopyWith<$Res> get swapInfo;
}

/// @nodoc
class _$RoutePlanCopyWithImpl<$Res> implements $RoutePlanCopyWith<$Res> {
  _$RoutePlanCopyWithImpl(this._self, this._then);

  final RoutePlan _self;
  final $Res Function(RoutePlan) _then;

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? swapInfo = null, Object? percent = null}) {
    return _then(
      _self.copyWith(
        swapInfo:
            null == swapInfo
                ? _self.swapInfo
                : swapInfo // ignore: cast_nullable_to_non_nullable
                    as JupiterSwapInfo,
        percent:
            null == percent
                ? _self.percent
                : percent // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JupiterSwapInfoCopyWith<$Res> get swapInfo {
    return $JupiterSwapInfoCopyWith<$Res>(_self.swapInfo, (value) {
      return _then(_self.copyWith(swapInfo: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _RoutePlan implements RoutePlan {
  const _RoutePlan({required this.swapInfo, required this.percent});
  factory _RoutePlan.fromJson(Map<String, dynamic> json) => _$RoutePlanFromJson(json);

  @override
  final JupiterSwapInfo swapInfo;
  @override
  final int percent;

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RoutePlanCopyWith<_RoutePlan> get copyWith =>
      __$RoutePlanCopyWithImpl<_RoutePlan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RoutePlanToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RoutePlan &&
            (identical(other.swapInfo, swapInfo) || other.swapInfo == swapInfo) &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, swapInfo, percent);

  @override
  String toString() {
    return 'RoutePlan(swapInfo: $swapInfo, percent: $percent)';
  }
}

/// @nodoc
abstract mixin class _$RoutePlanCopyWith<$Res> implements $RoutePlanCopyWith<$Res> {
  factory _$RoutePlanCopyWith(_RoutePlan value, $Res Function(_RoutePlan) _then) =
      __$RoutePlanCopyWithImpl;
  @override
  @useResult
  $Res call({JupiterSwapInfo swapInfo, int percent});

  @override
  $JupiterSwapInfoCopyWith<$Res> get swapInfo;
}

/// @nodoc
class __$RoutePlanCopyWithImpl<$Res> implements _$RoutePlanCopyWith<$Res> {
  __$RoutePlanCopyWithImpl(this._self, this._then);

  final _RoutePlan _self;
  final $Res Function(_RoutePlan) _then;

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? swapInfo = null, Object? percent = null}) {
    return _then(
      _RoutePlan(
        swapInfo:
            null == swapInfo
                ? _self.swapInfo
                : swapInfo // ignore: cast_nullable_to_non_nullable
                    as JupiterSwapInfo,
        percent:
            null == percent
                ? _self.percent
                : percent // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }

  /// Create a copy of RoutePlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JupiterSwapInfoCopyWith<$Res> get swapInfo {
    return $JupiterSwapInfoCopyWith<$Res>(_self.swapInfo, (value) {
      return _then(_self.copyWith(swapInfo: value));
    });
  }
}

/// @nodoc
mixin _$JupiterSwapInfo {
  String get ammKey;
  String? get label;
  String get inputMint;
  String get outputMint;
  String get inAmount;
  String get outAmount;
  String get feeAmount;
  String get feeMint;

  /// Create a copy of JupiterSwapInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JupiterSwapInfoCopyWith<JupiterSwapInfo> get copyWith =>
      _$JupiterSwapInfoCopyWithImpl<JupiterSwapInfo>(this as JupiterSwapInfo, _$identity);

  /// Serializes this JupiterSwapInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JupiterSwapInfo &&
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

  @override
  String toString() {
    return 'JupiterSwapInfo(ammKey: $ammKey, label: $label, inputMint: $inputMint, outputMint: $outputMint, inAmount: $inAmount, outAmount: $outAmount, feeAmount: $feeAmount, feeMint: $feeMint)';
  }
}

/// @nodoc
abstract mixin class $JupiterSwapInfoCopyWith<$Res> {
  factory $JupiterSwapInfoCopyWith(JupiterSwapInfo value, $Res Function(JupiterSwapInfo) _then) =
      _$JupiterSwapInfoCopyWithImpl;
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
class _$JupiterSwapInfoCopyWithImpl<$Res> implements $JupiterSwapInfoCopyWith<$Res> {
  _$JupiterSwapInfoCopyWithImpl(this._self, this._then);

  final JupiterSwapInfo _self;
  final $Res Function(JupiterSwapInfo) _then;

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
      _self.copyWith(
        ammKey:
            null == ammKey
                ? _self.ammKey
                : ammKey // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            freezed == label
                ? _self.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String?,
        inputMint:
            null == inputMint
                ? _self.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _self.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        inAmount:
            null == inAmount
                ? _self.inAmount
                : inAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        outAmount:
            null == outAmount
                ? _self.outAmount
                : outAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        feeAmount:
            null == feeAmount
                ? _self.feeAmount
                : feeAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        feeMint:
            null == feeMint
                ? _self.feeMint
                : feeMint // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _JupiterSwapInfo implements JupiterSwapInfo {
  const _JupiterSwapInfo({
    required this.ammKey,
    this.label,
    required this.inputMint,
    required this.outputMint,
    required this.inAmount,
    required this.outAmount,
    required this.feeAmount,
    required this.feeMint,
  });
  factory _JupiterSwapInfo.fromJson(Map<String, dynamic> json) => _$JupiterSwapInfoFromJson(json);

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

  /// Create a copy of JupiterSwapInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JupiterSwapInfoCopyWith<_JupiterSwapInfo> get copyWith =>
      __$JupiterSwapInfoCopyWithImpl<_JupiterSwapInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JupiterSwapInfoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JupiterSwapInfo &&
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

  @override
  String toString() {
    return 'JupiterSwapInfo(ammKey: $ammKey, label: $label, inputMint: $inputMint, outputMint: $outputMint, inAmount: $inAmount, outAmount: $outAmount, feeAmount: $feeAmount, feeMint: $feeMint)';
  }
}

/// @nodoc
abstract mixin class _$JupiterSwapInfoCopyWith<$Res> implements $JupiterSwapInfoCopyWith<$Res> {
  factory _$JupiterSwapInfoCopyWith(_JupiterSwapInfo value, $Res Function(_JupiterSwapInfo) _then) =
      __$JupiterSwapInfoCopyWithImpl;
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
class __$JupiterSwapInfoCopyWithImpl<$Res> implements _$JupiterSwapInfoCopyWith<$Res> {
  __$JupiterSwapInfoCopyWithImpl(this._self, this._then);

  final _JupiterSwapInfo _self;
  final $Res Function(_JupiterSwapInfo) _then;

  /// Create a copy of JupiterSwapInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
      _JupiterSwapInfo(
        ammKey:
            null == ammKey
                ? _self.ammKey
                : ammKey // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            freezed == label
                ? _self.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String?,
        inputMint:
            null == inputMint
                ? _self.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _self.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        inAmount:
            null == inAmount
                ? _self.inAmount
                : inAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        outAmount:
            null == outAmount
                ? _self.outAmount
                : outAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        feeAmount:
            null == feeAmount
                ? _self.feeAmount
                : feeAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        feeMint:
            null == feeMint
                ? _self.feeMint
                : feeMint // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
mixin _$QuoteResponseDto {
  String get inputMint;
  String get inAmount;
  String get outputMint;
  String get outAmount;
  String get otherAmountThreshold;
  SwapMode get swapMode;
  int get slippageBps;
  JupiterMarketFee? get platformFee;
  String get priceImpactPct;
  List<RoutePlan> get routePlan;
  num? get contextSlot;
  double? get timeTaken;

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteResponseDtoCopyWith<QuoteResponseDto> get copyWith =>
      _$QuoteResponseDtoCopyWithImpl<QuoteResponseDto>(this as QuoteResponseDto, _$identity);

  /// Serializes this QuoteResponseDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuoteResponseDto &&
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
            const DeepCollectionEquality().equals(other.routePlan, routePlan) &&
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
    const DeepCollectionEquality().hash(routePlan),
    contextSlot,
    timeTaken,
  );

  @override
  String toString() {
    return 'QuoteResponseDto(inputMint: $inputMint, inAmount: $inAmount, outputMint: $outputMint, outAmount: $outAmount, otherAmountThreshold: $otherAmountThreshold, swapMode: $swapMode, slippageBps: $slippageBps, platformFee: $platformFee, priceImpactPct: $priceImpactPct, routePlan: $routePlan, contextSlot: $contextSlot, timeTaken: $timeTaken)';
  }
}

/// @nodoc
abstract mixin class $QuoteResponseDtoCopyWith<$Res> {
  factory $QuoteResponseDtoCopyWith(QuoteResponseDto value, $Res Function(QuoteResponseDto) _then) =
      _$QuoteResponseDtoCopyWithImpl;
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
class _$QuoteResponseDtoCopyWithImpl<$Res> implements $QuoteResponseDtoCopyWith<$Res> {
  _$QuoteResponseDtoCopyWithImpl(this._self, this._then);

  final QuoteResponseDto _self;
  final $Res Function(QuoteResponseDto) _then;

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
      _self.copyWith(
        inputMint:
            null == inputMint
                ? _self.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        inAmount:
            null == inAmount
                ? _self.inAmount
                : inAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _self.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outAmount:
            null == outAmount
                ? _self.outAmount
                : outAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        otherAmountThreshold:
            null == otherAmountThreshold
                ? _self.otherAmountThreshold
                : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
                    as String,
        swapMode:
            null == swapMode
                ? _self.swapMode
                : swapMode // ignore: cast_nullable_to_non_nullable
                    as SwapMode,
        slippageBps:
            null == slippageBps
                ? _self.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int,
        platformFee:
            freezed == platformFee
                ? _self.platformFee
                : platformFee // ignore: cast_nullable_to_non_nullable
                    as JupiterMarketFee?,
        priceImpactPct:
            null == priceImpactPct
                ? _self.priceImpactPct
                : priceImpactPct // ignore: cast_nullable_to_non_nullable
                    as String,
        routePlan:
            null == routePlan
                ? _self.routePlan
                : routePlan // ignore: cast_nullable_to_non_nullable
                    as List<RoutePlan>,
        contextSlot:
            freezed == contextSlot
                ? _self.contextSlot
                : contextSlot // ignore: cast_nullable_to_non_nullable
                    as num?,
        timeTaken:
            freezed == timeTaken
                ? _self.timeTaken
                : timeTaken // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JupiterMarketFeeCopyWith<$Res>? get platformFee {
    if (_self.platformFee == null) {
      return null;
    }

    return $JupiterMarketFeeCopyWith<$Res>(_self.platformFee!, (value) {
      return _then(_self.copyWith(platformFee: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _QuoteResponseDto implements QuoteResponseDto {
  const _QuoteResponseDto({
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
  factory _QuoteResponseDto.fromJson(Map<String, dynamic> json) => _$QuoteResponseDtoFromJson(json);

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

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteResponseDtoCopyWith<_QuoteResponseDto> get copyWith =>
      __$QuoteResponseDtoCopyWithImpl<_QuoteResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuoteResponseDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuoteResponseDto &&
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

  @override
  String toString() {
    return 'QuoteResponseDto(inputMint: $inputMint, inAmount: $inAmount, outputMint: $outputMint, outAmount: $outAmount, otherAmountThreshold: $otherAmountThreshold, swapMode: $swapMode, slippageBps: $slippageBps, platformFee: $platformFee, priceImpactPct: $priceImpactPct, routePlan: $routePlan, contextSlot: $contextSlot, timeTaken: $timeTaken)';
  }
}

/// @nodoc
abstract mixin class _$QuoteResponseDtoCopyWith<$Res> implements $QuoteResponseDtoCopyWith<$Res> {
  factory _$QuoteResponseDtoCopyWith(
    _QuoteResponseDto value,
    $Res Function(_QuoteResponseDto) _then,
  ) = __$QuoteResponseDtoCopyWithImpl;
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
class __$QuoteResponseDtoCopyWithImpl<$Res> implements _$QuoteResponseDtoCopyWith<$Res> {
  __$QuoteResponseDtoCopyWithImpl(this._self, this._then);

  final _QuoteResponseDto _self;
  final $Res Function(_QuoteResponseDto) _then;

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
      _QuoteResponseDto(
        inputMint:
            null == inputMint
                ? _self.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        inAmount:
            null == inAmount
                ? _self.inAmount
                : inAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _self.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outAmount:
            null == outAmount
                ? _self.outAmount
                : outAmount // ignore: cast_nullable_to_non_nullable
                    as String,
        otherAmountThreshold:
            null == otherAmountThreshold
                ? _self.otherAmountThreshold
                : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
                    as String,
        swapMode:
            null == swapMode
                ? _self.swapMode
                : swapMode // ignore: cast_nullable_to_non_nullable
                    as SwapMode,
        slippageBps:
            null == slippageBps
                ? _self.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int,
        platformFee:
            freezed == platformFee
                ? _self.platformFee
                : platformFee // ignore: cast_nullable_to_non_nullable
                    as JupiterMarketFee?,
        priceImpactPct:
            null == priceImpactPct
                ? _self.priceImpactPct
                : priceImpactPct // ignore: cast_nullable_to_non_nullable
                    as String,
        routePlan:
            null == routePlan
                ? _self._routePlan
                : routePlan // ignore: cast_nullable_to_non_nullable
                    as List<RoutePlan>,
        contextSlot:
            freezed == contextSlot
                ? _self.contextSlot
                : contextSlot // ignore: cast_nullable_to_non_nullable
                    as num?,
        timeTaken:
            freezed == timeTaken
                ? _self.timeTaken
                : timeTaken // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }

  /// Create a copy of QuoteResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JupiterMarketFeeCopyWith<$Res>? get platformFee {
    if (_self.platformFee == null) {
      return null;
    }

    return $JupiterMarketFeeCopyWith<$Res>(_self.platformFee!, (value) {
      return _then(_self.copyWith(platformFee: value));
    });
  }
}

/// @nodoc
mixin _$QuoteRequestDto {
  String get inputMint;
  String get outputMint;
  int get amount;
  int? get slippageBps;
  SwapMode get swapMode;
  List<String>? get dexes;
  List<String>? get excludeDexes;
  bool? get onlyDirectRoutes;
  bool? get asLegacyTransaction;
  int? get platformFeeBps;
  int? get maxAccounts;
  bool? get restrictIntermediateTokens;
  bool? get autoSlippage;
  int? get maxAutoSlippageBps;
  int? get autoSlippageCollisionUsdValue;

  /// Create a copy of QuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteRequestDtoCopyWith<QuoteRequestDto> get copyWith =>
      _$QuoteRequestDtoCopyWithImpl<QuoteRequestDto>(this as QuoteRequestDto, _$identity);

  /// Serializes this QuoteRequestDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuoteRequestDto &&
            (identical(other.inputMint, inputMint) || other.inputMint == inputMint) &&
            (identical(other.outputMint, outputMint) || other.outputMint == outputMint) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.slippageBps, slippageBps) || other.slippageBps == slippageBps) &&
            (identical(other.swapMode, swapMode) || other.swapMode == swapMode) &&
            const DeepCollectionEquality().equals(other.dexes, dexes) &&
            const DeepCollectionEquality().equals(other.excludeDexes, excludeDexes) &&
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
    const DeepCollectionEquality().hash(dexes),
    const DeepCollectionEquality().hash(excludeDexes),
    onlyDirectRoutes,
    asLegacyTransaction,
    platformFeeBps,
    maxAccounts,
    restrictIntermediateTokens,
    autoSlippage,
    maxAutoSlippageBps,
    autoSlippageCollisionUsdValue,
  );

  @override
  String toString() {
    return 'QuoteRequestDto(inputMint: $inputMint, outputMint: $outputMint, amount: $amount, slippageBps: $slippageBps, swapMode: $swapMode, dexes: $dexes, excludeDexes: $excludeDexes, onlyDirectRoutes: $onlyDirectRoutes, asLegacyTransaction: $asLegacyTransaction, platformFeeBps: $platformFeeBps, maxAccounts: $maxAccounts, restrictIntermediateTokens: $restrictIntermediateTokens, autoSlippage: $autoSlippage, maxAutoSlippageBps: $maxAutoSlippageBps, autoSlippageCollisionUsdValue: $autoSlippageCollisionUsdValue)';
  }
}

/// @nodoc
abstract mixin class $QuoteRequestDtoCopyWith<$Res> {
  factory $QuoteRequestDtoCopyWith(QuoteRequestDto value, $Res Function(QuoteRequestDto) _then) =
      _$QuoteRequestDtoCopyWithImpl;
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
class _$QuoteRequestDtoCopyWithImpl<$Res> implements $QuoteRequestDtoCopyWith<$Res> {
  _$QuoteRequestDtoCopyWithImpl(this._self, this._then);

  final QuoteRequestDto _self;
  final $Res Function(QuoteRequestDto) _then;

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
      _self.copyWith(
        inputMint:
            null == inputMint
                ? _self.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _self.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        slippageBps:
            freezed == slippageBps
                ? _self.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        swapMode:
            null == swapMode
                ? _self.swapMode
                : swapMode // ignore: cast_nullable_to_non_nullable
                    as SwapMode,
        dexes:
            freezed == dexes
                ? _self.dexes
                : dexes // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
        excludeDexes:
            freezed == excludeDexes
                ? _self.excludeDexes
                : excludeDexes // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
        onlyDirectRoutes:
            freezed == onlyDirectRoutes
                ? _self.onlyDirectRoutes
                : onlyDirectRoutes // ignore: cast_nullable_to_non_nullable
                    as bool?,
        asLegacyTransaction:
            freezed == asLegacyTransaction
                ? _self.asLegacyTransaction
                : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
                    as bool?,
        platformFeeBps:
            freezed == platformFeeBps
                ? _self.platformFeeBps
                : platformFeeBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        maxAccounts:
            freezed == maxAccounts
                ? _self.maxAccounts
                : maxAccounts // ignore: cast_nullable_to_non_nullable
                    as int?,
        restrictIntermediateTokens:
            freezed == restrictIntermediateTokens
                ? _self.restrictIntermediateTokens
                : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
                    as bool?,
        autoSlippage:
            freezed == autoSlippage
                ? _self.autoSlippage
                : autoSlippage // ignore: cast_nullable_to_non_nullable
                    as bool?,
        maxAutoSlippageBps:
            freezed == maxAutoSlippageBps
                ? _self.maxAutoSlippageBps
                : maxAutoSlippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        autoSlippageCollisionUsdValue:
            freezed == autoSlippageCollisionUsdValue
                ? _self.autoSlippageCollisionUsdValue
                : autoSlippageCollisionUsdValue // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _QuoteRequestDto implements QuoteRequestDto {
  const _QuoteRequestDto({
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
  factory _QuoteRequestDto.fromJson(Map<String, dynamic> json) => _$QuoteRequestDtoFromJson(json);

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

  /// Create a copy of QuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteRequestDtoCopyWith<_QuoteRequestDto> get copyWith =>
      __$QuoteRequestDtoCopyWithImpl<_QuoteRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuoteRequestDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuoteRequestDto &&
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

  @override
  String toString() {
    return 'QuoteRequestDto(inputMint: $inputMint, outputMint: $outputMint, amount: $amount, slippageBps: $slippageBps, swapMode: $swapMode, dexes: $dexes, excludeDexes: $excludeDexes, onlyDirectRoutes: $onlyDirectRoutes, asLegacyTransaction: $asLegacyTransaction, platformFeeBps: $platformFeeBps, maxAccounts: $maxAccounts, restrictIntermediateTokens: $restrictIntermediateTokens, autoSlippage: $autoSlippage, maxAutoSlippageBps: $maxAutoSlippageBps, autoSlippageCollisionUsdValue: $autoSlippageCollisionUsdValue)';
  }
}

/// @nodoc
abstract mixin class _$QuoteRequestDtoCopyWith<$Res> implements $QuoteRequestDtoCopyWith<$Res> {
  factory _$QuoteRequestDtoCopyWith(_QuoteRequestDto value, $Res Function(_QuoteRequestDto) _then) =
      __$QuoteRequestDtoCopyWithImpl;
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
class __$QuoteRequestDtoCopyWithImpl<$Res> implements _$QuoteRequestDtoCopyWith<$Res> {
  __$QuoteRequestDtoCopyWithImpl(this._self, this._then);

  final _QuoteRequestDto _self;
  final $Res Function(_QuoteRequestDto) _then;

  /// Create a copy of QuoteRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
      _QuoteRequestDto(
        inputMint:
            null == inputMint
                ? _self.inputMint
                : inputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        outputMint:
            null == outputMint
                ? _self.outputMint
                : outputMint // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _self.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as int,
        slippageBps:
            freezed == slippageBps
                ? _self.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        swapMode:
            null == swapMode
                ? _self.swapMode
                : swapMode // ignore: cast_nullable_to_non_nullable
                    as SwapMode,
        dexes:
            freezed == dexes
                ? _self._dexes
                : dexes // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
        excludeDexes:
            freezed == excludeDexes
                ? _self._excludeDexes
                : excludeDexes // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
        onlyDirectRoutes:
            freezed == onlyDirectRoutes
                ? _self.onlyDirectRoutes
                : onlyDirectRoutes // ignore: cast_nullable_to_non_nullable
                    as bool?,
        asLegacyTransaction:
            freezed == asLegacyTransaction
                ? _self.asLegacyTransaction
                : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
                    as bool?,
        platformFeeBps:
            freezed == platformFeeBps
                ? _self.platformFeeBps
                : platformFeeBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        maxAccounts:
            freezed == maxAccounts
                ? _self.maxAccounts
                : maxAccounts // ignore: cast_nullable_to_non_nullable
                    as int?,
        restrictIntermediateTokens:
            freezed == restrictIntermediateTokens
                ? _self.restrictIntermediateTokens
                : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
                    as bool?,
        autoSlippage:
            freezed == autoSlippage
                ? _self.autoSlippage
                : autoSlippage // ignore: cast_nullable_to_non_nullable
                    as bool?,
        maxAutoSlippageBps:
            freezed == maxAutoSlippageBps
                ? _self.maxAutoSlippageBps
                : maxAutoSlippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        autoSlippageCollisionUsdValue:
            freezed == autoSlippageCollisionUsdValue
                ? _self.autoSlippageCollisionUsdValue
                : autoSlippageCollisionUsdValue // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
mixin _$JupiterSwapRequestDto {
  String get userPublicKey;
  QuoteResponseDto get quoteResponse;
  bool? get wrapAndUnwrapSol;
  bool? get useSharedAccounts;
  String? get feeAccount;
  int? get computeUnitPriceMicroLamports;
  int? get prioritizationFeeLamports;
  bool? get asLegacyTransaction;
  bool? get restrictIntermediateTokens;
  bool? get useTokenLedger;
  String? get destinationTokenAccount;
  bool? get dynamicComputeUnitLimit;
  bool? get skipUserAccountsRpcCalls;
  String? get trackingAccount;
  DynamicSlippage? get dynamicSlippage;

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JupiterSwapRequestDtoCopyWith<JupiterSwapRequestDto> get copyWith =>
      _$JupiterSwapRequestDtoCopyWithImpl<JupiterSwapRequestDto>(
        this as JupiterSwapRequestDto,
        _$identity,
      );

  /// Serializes this JupiterSwapRequestDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JupiterSwapRequestDto &&
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

  @override
  String toString() {
    return 'JupiterSwapRequestDto(userPublicKey: $userPublicKey, quoteResponse: $quoteResponse, wrapAndUnwrapSol: $wrapAndUnwrapSol, useSharedAccounts: $useSharedAccounts, feeAccount: $feeAccount, computeUnitPriceMicroLamports: $computeUnitPriceMicroLamports, prioritizationFeeLamports: $prioritizationFeeLamports, asLegacyTransaction: $asLegacyTransaction, restrictIntermediateTokens: $restrictIntermediateTokens, useTokenLedger: $useTokenLedger, destinationTokenAccount: $destinationTokenAccount, dynamicComputeUnitLimit: $dynamicComputeUnitLimit, skipUserAccountsRpcCalls: $skipUserAccountsRpcCalls, trackingAccount: $trackingAccount, dynamicSlippage: $dynamicSlippage)';
  }
}

/// @nodoc
abstract mixin class $JupiterSwapRequestDtoCopyWith<$Res> {
  factory $JupiterSwapRequestDtoCopyWith(
    JupiterSwapRequestDto value,
    $Res Function(JupiterSwapRequestDto) _then,
  ) = _$JupiterSwapRequestDtoCopyWithImpl;
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
class _$JupiterSwapRequestDtoCopyWithImpl<$Res> implements $JupiterSwapRequestDtoCopyWith<$Res> {
  _$JupiterSwapRequestDtoCopyWithImpl(this._self, this._then);

  final JupiterSwapRequestDto _self;
  final $Res Function(JupiterSwapRequestDto) _then;

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
      _self.copyWith(
        userPublicKey:
            null == userPublicKey
                ? _self.userPublicKey
                : userPublicKey // ignore: cast_nullable_to_non_nullable
                    as String,
        quoteResponse:
            null == quoteResponse
                ? _self.quoteResponse
                : quoteResponse // ignore: cast_nullable_to_non_nullable
                    as QuoteResponseDto,
        wrapAndUnwrapSol:
            freezed == wrapAndUnwrapSol
                ? _self.wrapAndUnwrapSol
                : wrapAndUnwrapSol // ignore: cast_nullable_to_non_nullable
                    as bool?,
        useSharedAccounts:
            freezed == useSharedAccounts
                ? _self.useSharedAccounts
                : useSharedAccounts // ignore: cast_nullable_to_non_nullable
                    as bool?,
        feeAccount:
            freezed == feeAccount
                ? _self.feeAccount
                : feeAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        computeUnitPriceMicroLamports:
            freezed == computeUnitPriceMicroLamports
                ? _self.computeUnitPriceMicroLamports
                : computeUnitPriceMicroLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        prioritizationFeeLamports:
            freezed == prioritizationFeeLamports
                ? _self.prioritizationFeeLamports
                : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        asLegacyTransaction:
            freezed == asLegacyTransaction
                ? _self.asLegacyTransaction
                : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
                    as bool?,
        restrictIntermediateTokens:
            freezed == restrictIntermediateTokens
                ? _self.restrictIntermediateTokens
                : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
                    as bool?,
        useTokenLedger:
            freezed == useTokenLedger
                ? _self.useTokenLedger
                : useTokenLedger // ignore: cast_nullable_to_non_nullable
                    as bool?,
        destinationTokenAccount:
            freezed == destinationTokenAccount
                ? _self.destinationTokenAccount
                : destinationTokenAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        dynamicComputeUnitLimit:
            freezed == dynamicComputeUnitLimit
                ? _self.dynamicComputeUnitLimit
                : dynamicComputeUnitLimit // ignore: cast_nullable_to_non_nullable
                    as bool?,
        skipUserAccountsRpcCalls:
            freezed == skipUserAccountsRpcCalls
                ? _self.skipUserAccountsRpcCalls
                : skipUserAccountsRpcCalls // ignore: cast_nullable_to_non_nullable
                    as bool?,
        trackingAccount:
            freezed == trackingAccount
                ? _self.trackingAccount
                : trackingAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        dynamicSlippage:
            freezed == dynamicSlippage
                ? _self.dynamicSlippage
                : dynamicSlippage // ignore: cast_nullable_to_non_nullable
                    as DynamicSlippage?,
      ),
    );
  }

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteResponseDtoCopyWith<$Res> get quoteResponse {
    return $QuoteResponseDtoCopyWith<$Res>(_self.quoteResponse, (value) {
      return _then(_self.copyWith(quoteResponse: value));
    });
  }

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DynamicSlippageCopyWith<$Res>? get dynamicSlippage {
    if (_self.dynamicSlippage == null) {
      return null;
    }

    return $DynamicSlippageCopyWith<$Res>(_self.dynamicSlippage!, (value) {
      return _then(_self.copyWith(dynamicSlippage: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _JupiterSwapRequestDto implements JupiterSwapRequestDto {
  const _JupiterSwapRequestDto({
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
  factory _JupiterSwapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$JupiterSwapRequestDtoFromJson(json);

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

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JupiterSwapRequestDtoCopyWith<_JupiterSwapRequestDto> get copyWith =>
      __$JupiterSwapRequestDtoCopyWithImpl<_JupiterSwapRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JupiterSwapRequestDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JupiterSwapRequestDto &&
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

  @override
  String toString() {
    return 'JupiterSwapRequestDto(userPublicKey: $userPublicKey, quoteResponse: $quoteResponse, wrapAndUnwrapSol: $wrapAndUnwrapSol, useSharedAccounts: $useSharedAccounts, feeAccount: $feeAccount, computeUnitPriceMicroLamports: $computeUnitPriceMicroLamports, prioritizationFeeLamports: $prioritizationFeeLamports, asLegacyTransaction: $asLegacyTransaction, restrictIntermediateTokens: $restrictIntermediateTokens, useTokenLedger: $useTokenLedger, destinationTokenAccount: $destinationTokenAccount, dynamicComputeUnitLimit: $dynamicComputeUnitLimit, skipUserAccountsRpcCalls: $skipUserAccountsRpcCalls, trackingAccount: $trackingAccount, dynamicSlippage: $dynamicSlippage)';
  }
}

/// @nodoc
abstract mixin class _$JupiterSwapRequestDtoCopyWith<$Res>
    implements $JupiterSwapRequestDtoCopyWith<$Res> {
  factory _$JupiterSwapRequestDtoCopyWith(
    _JupiterSwapRequestDto value,
    $Res Function(_JupiterSwapRequestDto) _then,
  ) = __$JupiterSwapRequestDtoCopyWithImpl;
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
class __$JupiterSwapRequestDtoCopyWithImpl<$Res> implements _$JupiterSwapRequestDtoCopyWith<$Res> {
  __$JupiterSwapRequestDtoCopyWithImpl(this._self, this._then);

  final _JupiterSwapRequestDto _self;
  final $Res Function(_JupiterSwapRequestDto) _then;

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
      _JupiterSwapRequestDto(
        userPublicKey:
            null == userPublicKey
                ? _self.userPublicKey
                : userPublicKey // ignore: cast_nullable_to_non_nullable
                    as String,
        quoteResponse:
            null == quoteResponse
                ? _self.quoteResponse
                : quoteResponse // ignore: cast_nullable_to_non_nullable
                    as QuoteResponseDto,
        wrapAndUnwrapSol:
            freezed == wrapAndUnwrapSol
                ? _self.wrapAndUnwrapSol
                : wrapAndUnwrapSol // ignore: cast_nullable_to_non_nullable
                    as bool?,
        useSharedAccounts:
            freezed == useSharedAccounts
                ? _self.useSharedAccounts
                : useSharedAccounts // ignore: cast_nullable_to_non_nullable
                    as bool?,
        feeAccount:
            freezed == feeAccount
                ? _self.feeAccount
                : feeAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        computeUnitPriceMicroLamports:
            freezed == computeUnitPriceMicroLamports
                ? _self.computeUnitPriceMicroLamports
                : computeUnitPriceMicroLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        prioritizationFeeLamports:
            freezed == prioritizationFeeLamports
                ? _self.prioritizationFeeLamports
                : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        asLegacyTransaction:
            freezed == asLegacyTransaction
                ? _self.asLegacyTransaction
                : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
                    as bool?,
        restrictIntermediateTokens:
            freezed == restrictIntermediateTokens
                ? _self.restrictIntermediateTokens
                : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
                    as bool?,
        useTokenLedger:
            freezed == useTokenLedger
                ? _self.useTokenLedger
                : useTokenLedger // ignore: cast_nullable_to_non_nullable
                    as bool?,
        destinationTokenAccount:
            freezed == destinationTokenAccount
                ? _self.destinationTokenAccount
                : destinationTokenAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        dynamicComputeUnitLimit:
            freezed == dynamicComputeUnitLimit
                ? _self.dynamicComputeUnitLimit
                : dynamicComputeUnitLimit // ignore: cast_nullable_to_non_nullable
                    as bool?,
        skipUserAccountsRpcCalls:
            freezed == skipUserAccountsRpcCalls
                ? _self.skipUserAccountsRpcCalls
                : skipUserAccountsRpcCalls // ignore: cast_nullable_to_non_nullable
                    as bool?,
        trackingAccount:
            freezed == trackingAccount
                ? _self.trackingAccount
                : trackingAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        dynamicSlippage:
            freezed == dynamicSlippage
                ? _self.dynamicSlippage
                : dynamicSlippage // ignore: cast_nullable_to_non_nullable
                    as DynamicSlippage?,
      ),
    );
  }

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuoteResponseDtoCopyWith<$Res> get quoteResponse {
    return $QuoteResponseDtoCopyWith<$Res>(_self.quoteResponse, (value) {
      return _then(_self.copyWith(quoteResponse: value));
    });
  }

  /// Create a copy of JupiterSwapRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DynamicSlippageCopyWith<$Res>? get dynamicSlippage {
    if (_self.dynamicSlippage == null) {
      return null;
    }

    return $DynamicSlippageCopyWith<$Res>(_self.dynamicSlippage!, (value) {
      return _then(_self.copyWith(dynamicSlippage: value));
    });
  }
}

/// @nodoc
mixin _$DynamicSlippage {
  int get minBps;
  int get maxBps;

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DynamicSlippageCopyWith<DynamicSlippage> get copyWith =>
      _$DynamicSlippageCopyWithImpl<DynamicSlippage>(this as DynamicSlippage, _$identity);

  /// Serializes this DynamicSlippage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DynamicSlippage &&
            (identical(other.minBps, minBps) || other.minBps == minBps) &&
            (identical(other.maxBps, maxBps) || other.maxBps == maxBps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minBps, maxBps);

  @override
  String toString() {
    return 'DynamicSlippage(minBps: $minBps, maxBps: $maxBps)';
  }
}

/// @nodoc
abstract mixin class $DynamicSlippageCopyWith<$Res> {
  factory $DynamicSlippageCopyWith(DynamicSlippage value, $Res Function(DynamicSlippage) _then) =
      _$DynamicSlippageCopyWithImpl;
  @useResult
  $Res call({int minBps, int maxBps});
}

/// @nodoc
class _$DynamicSlippageCopyWithImpl<$Res> implements $DynamicSlippageCopyWith<$Res> {
  _$DynamicSlippageCopyWithImpl(this._self, this._then);

  final DynamicSlippage _self;
  final $Res Function(DynamicSlippage) _then;

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? minBps = null, Object? maxBps = null}) {
    return _then(
      _self.copyWith(
        minBps:
            null == minBps
                ? _self.minBps
                : minBps // ignore: cast_nullable_to_non_nullable
                    as int,
        maxBps:
            null == maxBps
                ? _self.maxBps
                : maxBps // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _DynamicSlippage implements DynamicSlippage {
  const _DynamicSlippage({required this.minBps, required this.maxBps});
  factory _DynamicSlippage.fromJson(Map<String, dynamic> json) => _$DynamicSlippageFromJson(json);

  @override
  final int minBps;
  @override
  final int maxBps;

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DynamicSlippageCopyWith<_DynamicSlippage> get copyWith =>
      __$DynamicSlippageCopyWithImpl<_DynamicSlippage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DynamicSlippageToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DynamicSlippage &&
            (identical(other.minBps, minBps) || other.minBps == minBps) &&
            (identical(other.maxBps, maxBps) || other.maxBps == maxBps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minBps, maxBps);

  @override
  String toString() {
    return 'DynamicSlippage(minBps: $minBps, maxBps: $maxBps)';
  }
}

/// @nodoc
abstract mixin class _$DynamicSlippageCopyWith<$Res> implements $DynamicSlippageCopyWith<$Res> {
  factory _$DynamicSlippageCopyWith(_DynamicSlippage value, $Res Function(_DynamicSlippage) _then) =
      __$DynamicSlippageCopyWithImpl;
  @override
  @useResult
  $Res call({int minBps, int maxBps});
}

/// @nodoc
class __$DynamicSlippageCopyWithImpl<$Res> implements _$DynamicSlippageCopyWith<$Res> {
  __$DynamicSlippageCopyWithImpl(this._self, this._then);

  final _DynamicSlippage _self;
  final $Res Function(_DynamicSlippage) _then;

  /// Create a copy of DynamicSlippage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? minBps = null, Object? maxBps = null}) {
    return _then(
      _DynamicSlippage(
        minBps:
            null == minBps
                ? _self.minBps
                : minBps // ignore: cast_nullable_to_non_nullable
                    as int,
        maxBps:
            null == maxBps
                ? _self.maxBps
                : maxBps // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$JupiterSwapResponseDto {
  String get swapTransaction;
  int get lastValidBlockHeight;
  int? get prioritizationFeeLamports;
  DynamicSlippageReport? get dynamicSlippageReport;

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JupiterSwapResponseDtoCopyWith<JupiterSwapResponseDto> get copyWith =>
      _$JupiterSwapResponseDtoCopyWithImpl<JupiterSwapResponseDto>(
        this as JupiterSwapResponseDto,
        _$identity,
      );

  /// Serializes this JupiterSwapResponseDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JupiterSwapResponseDto &&
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

  @override
  String toString() {
    return 'JupiterSwapResponseDto(swapTransaction: $swapTransaction, lastValidBlockHeight: $lastValidBlockHeight, prioritizationFeeLamports: $prioritizationFeeLamports, dynamicSlippageReport: $dynamicSlippageReport)';
  }
}

/// @nodoc
abstract mixin class $JupiterSwapResponseDtoCopyWith<$Res> {
  factory $JupiterSwapResponseDtoCopyWith(
    JupiterSwapResponseDto value,
    $Res Function(JupiterSwapResponseDto) _then,
  ) = _$JupiterSwapResponseDtoCopyWithImpl;
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
class _$JupiterSwapResponseDtoCopyWithImpl<$Res> implements $JupiterSwapResponseDtoCopyWith<$Res> {
  _$JupiterSwapResponseDtoCopyWithImpl(this._self, this._then);

  final JupiterSwapResponseDto _self;
  final $Res Function(JupiterSwapResponseDto) _then;

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
      _self.copyWith(
        swapTransaction:
            null == swapTransaction
                ? _self.swapTransaction
                : swapTransaction // ignore: cast_nullable_to_non_nullable
                    as String,
        lastValidBlockHeight:
            null == lastValidBlockHeight
                ? _self.lastValidBlockHeight
                : lastValidBlockHeight // ignore: cast_nullable_to_non_nullable
                    as int,
        prioritizationFeeLamports:
            freezed == prioritizationFeeLamports
                ? _self.prioritizationFeeLamports
                : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        dynamicSlippageReport:
            freezed == dynamicSlippageReport
                ? _self.dynamicSlippageReport
                : dynamicSlippageReport // ignore: cast_nullable_to_non_nullable
                    as DynamicSlippageReport?,
      ),
    );
  }

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DynamicSlippageReportCopyWith<$Res>? get dynamicSlippageReport {
    if (_self.dynamicSlippageReport == null) {
      return null;
    }

    return $DynamicSlippageReportCopyWith<$Res>(_self.dynamicSlippageReport!, (value) {
      return _then(_self.copyWith(dynamicSlippageReport: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _JupiterSwapResponseDto implements JupiterSwapResponseDto {
  const _JupiterSwapResponseDto({
    required this.swapTransaction,
    required this.lastValidBlockHeight,
    this.prioritizationFeeLamports,
    this.dynamicSlippageReport,
  });
  factory _JupiterSwapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$JupiterSwapResponseDtoFromJson(json);

  @override
  final String swapTransaction;
  @override
  final int lastValidBlockHeight;
  @override
  final int? prioritizationFeeLamports;
  @override
  final DynamicSlippageReport? dynamicSlippageReport;

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JupiterSwapResponseDtoCopyWith<_JupiterSwapResponseDto> get copyWith =>
      __$JupiterSwapResponseDtoCopyWithImpl<_JupiterSwapResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$JupiterSwapResponseDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JupiterSwapResponseDto &&
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

  @override
  String toString() {
    return 'JupiterSwapResponseDto(swapTransaction: $swapTransaction, lastValidBlockHeight: $lastValidBlockHeight, prioritizationFeeLamports: $prioritizationFeeLamports, dynamicSlippageReport: $dynamicSlippageReport)';
  }
}

/// @nodoc
abstract mixin class _$JupiterSwapResponseDtoCopyWith<$Res>
    implements $JupiterSwapResponseDtoCopyWith<$Res> {
  factory _$JupiterSwapResponseDtoCopyWith(
    _JupiterSwapResponseDto value,
    $Res Function(_JupiterSwapResponseDto) _then,
  ) = __$JupiterSwapResponseDtoCopyWithImpl;
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
class __$JupiterSwapResponseDtoCopyWithImpl<$Res>
    implements _$JupiterSwapResponseDtoCopyWith<$Res> {
  __$JupiterSwapResponseDtoCopyWithImpl(this._self, this._then);

  final _JupiterSwapResponseDto _self;
  final $Res Function(_JupiterSwapResponseDto) _then;

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? swapTransaction = null,
    Object? lastValidBlockHeight = null,
    Object? prioritizationFeeLamports = freezed,
    Object? dynamicSlippageReport = freezed,
  }) {
    return _then(
      _JupiterSwapResponseDto(
        swapTransaction:
            null == swapTransaction
                ? _self.swapTransaction
                : swapTransaction // ignore: cast_nullable_to_non_nullable
                    as String,
        lastValidBlockHeight:
            null == lastValidBlockHeight
                ? _self.lastValidBlockHeight
                : lastValidBlockHeight // ignore: cast_nullable_to_non_nullable
                    as int,
        prioritizationFeeLamports:
            freezed == prioritizationFeeLamports
                ? _self.prioritizationFeeLamports
                : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
                    as int?,
        dynamicSlippageReport:
            freezed == dynamicSlippageReport
                ? _self.dynamicSlippageReport
                : dynamicSlippageReport // ignore: cast_nullable_to_non_nullable
                    as DynamicSlippageReport?,
      ),
    );
  }

  /// Create a copy of JupiterSwapResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DynamicSlippageReportCopyWith<$Res>? get dynamicSlippageReport {
    if (_self.dynamicSlippageReport == null) {
      return null;
    }

    return $DynamicSlippageReportCopyWith<$Res>(_self.dynamicSlippageReport!, (value) {
      return _then(_self.copyWith(dynamicSlippageReport: value));
    });
  }
}

/// @nodoc
mixin _$DynamicSlippageReport {
  int? get slippageBps;
  int? get otherAmount;
  int? get simulatedIncurredSlippageBps;
  String? get amplificationRatio;

  /// Create a copy of DynamicSlippageReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DynamicSlippageReportCopyWith<DynamicSlippageReport> get copyWith =>
      _$DynamicSlippageReportCopyWithImpl<DynamicSlippageReport>(
        this as DynamicSlippageReport,
        _$identity,
      );

  /// Serializes this DynamicSlippageReport to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DynamicSlippageReport &&
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

  @override
  String toString() {
    return 'DynamicSlippageReport(slippageBps: $slippageBps, otherAmount: $otherAmount, simulatedIncurredSlippageBps: $simulatedIncurredSlippageBps, amplificationRatio: $amplificationRatio)';
  }
}

/// @nodoc
abstract mixin class $DynamicSlippageReportCopyWith<$Res> {
  factory $DynamicSlippageReportCopyWith(
    DynamicSlippageReport value,
    $Res Function(DynamicSlippageReport) _then,
  ) = _$DynamicSlippageReportCopyWithImpl;
  @useResult
  $Res call({
    int? slippageBps,
    int? otherAmount,
    int? simulatedIncurredSlippageBps,
    String? amplificationRatio,
  });
}

/// @nodoc
class _$DynamicSlippageReportCopyWithImpl<$Res> implements $DynamicSlippageReportCopyWith<$Res> {
  _$DynamicSlippageReportCopyWithImpl(this._self, this._then);

  final DynamicSlippageReport _self;
  final $Res Function(DynamicSlippageReport) _then;

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
      _self.copyWith(
        slippageBps:
            freezed == slippageBps
                ? _self.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        otherAmount:
            freezed == otherAmount
                ? _self.otherAmount
                : otherAmount // ignore: cast_nullable_to_non_nullable
                    as int?,
        simulatedIncurredSlippageBps:
            freezed == simulatedIncurredSlippageBps
                ? _self.simulatedIncurredSlippageBps
                : simulatedIncurredSlippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        amplificationRatio:
            freezed == amplificationRatio
                ? _self.amplificationRatio
                : amplificationRatio // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _DynamicSlippageReport implements DynamicSlippageReport {
  const _DynamicSlippageReport({
    this.slippageBps,
    this.otherAmount,
    this.simulatedIncurredSlippageBps,
    this.amplificationRatio,
  });
  factory _DynamicSlippageReport.fromJson(Map<String, dynamic> json) =>
      _$DynamicSlippageReportFromJson(json);

  @override
  final int? slippageBps;
  @override
  final int? otherAmount;
  @override
  final int? simulatedIncurredSlippageBps;
  @override
  final String? amplificationRatio;

  /// Create a copy of DynamicSlippageReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DynamicSlippageReportCopyWith<_DynamicSlippageReport> get copyWith =>
      __$DynamicSlippageReportCopyWithImpl<_DynamicSlippageReport>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DynamicSlippageReportToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DynamicSlippageReport &&
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

  @override
  String toString() {
    return 'DynamicSlippageReport(slippageBps: $slippageBps, otherAmount: $otherAmount, simulatedIncurredSlippageBps: $simulatedIncurredSlippageBps, amplificationRatio: $amplificationRatio)';
  }
}

/// @nodoc
abstract mixin class _$DynamicSlippageReportCopyWith<$Res>
    implements $DynamicSlippageReportCopyWith<$Res> {
  factory _$DynamicSlippageReportCopyWith(
    _DynamicSlippageReport value,
    $Res Function(_DynamicSlippageReport) _then,
  ) = __$DynamicSlippageReportCopyWithImpl;
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
class __$DynamicSlippageReportCopyWithImpl<$Res> implements _$DynamicSlippageReportCopyWith<$Res> {
  __$DynamicSlippageReportCopyWithImpl(this._self, this._then);

  final _DynamicSlippageReport _self;
  final $Res Function(_DynamicSlippageReport) _then;

  /// Create a copy of DynamicSlippageReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? slippageBps = freezed,
    Object? otherAmount = freezed,
    Object? simulatedIncurredSlippageBps = freezed,
    Object? amplificationRatio = freezed,
  }) {
    return _then(
      _DynamicSlippageReport(
        slippageBps:
            freezed == slippageBps
                ? _self.slippageBps
                : slippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        otherAmount:
            freezed == otherAmount
                ? _self.otherAmount
                : otherAmount // ignore: cast_nullable_to_non_nullable
                    as int?,
        simulatedIncurredSlippageBps:
            freezed == simulatedIncurredSlippageBps
                ? _self.simulatedIncurredSlippageBps
                : simulatedIncurredSlippageBps // ignore: cast_nullable_to_non_nullable
                    as int?,
        amplificationRatio:
            freezed == amplificationRatio
                ? _self.amplificationRatio
                : amplificationRatio // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
mixin _$PriceRequestDto {
  @JsonKey(toJson: _listToString)
  List<String> get ids;

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PriceRequestDtoCopyWith<PriceRequestDto> get copyWith =>
      _$PriceRequestDtoCopyWithImpl<PriceRequestDto>(this as PriceRequestDto, _$identity);

  /// Serializes this PriceRequestDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PriceRequestDto &&
            const DeepCollectionEquality().equals(other.ids, ids));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(ids));

  @override
  String toString() {
    return 'PriceRequestDto(ids: $ids)';
  }
}

/// @nodoc
abstract mixin class $PriceRequestDtoCopyWith<$Res> {
  factory $PriceRequestDtoCopyWith(PriceRequestDto value, $Res Function(PriceRequestDto) _then) =
      _$PriceRequestDtoCopyWithImpl;
  @useResult
  $Res call({@JsonKey(toJson: _listToString) List<String> ids});
}

/// @nodoc
class _$PriceRequestDtoCopyWithImpl<$Res> implements $PriceRequestDtoCopyWith<$Res> {
  _$PriceRequestDtoCopyWithImpl(this._self, this._then);

  final PriceRequestDto _self;
  final $Res Function(PriceRequestDto) _then;

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ids = null}) {
    return _then(
      _self.copyWith(
        ids:
            null == ids
                ? _self.ids
                : ids // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _PriceRequestDto implements PriceRequestDto {
  const _PriceRequestDto({@JsonKey(toJson: _listToString) required final List<String> ids})
    : _ids = ids;
  factory _PriceRequestDto.fromJson(Map<String, dynamic> json) => _$PriceRequestDtoFromJson(json);

  final List<String> _ids;
  @override
  @JsonKey(toJson: _listToString)
  List<String> get ids {
    if (_ids is EqualUnmodifiableListView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ids);
  }

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PriceRequestDtoCopyWith<_PriceRequestDto> get copyWith =>
      __$PriceRequestDtoCopyWithImpl<_PriceRequestDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PriceRequestDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PriceRequestDto &&
            const DeepCollectionEquality().equals(other._ids, _ids));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));

  @override
  String toString() {
    return 'PriceRequestDto(ids: $ids)';
  }
}

/// @nodoc
abstract mixin class _$PriceRequestDtoCopyWith<$Res> implements $PriceRequestDtoCopyWith<$Res> {
  factory _$PriceRequestDtoCopyWith(_PriceRequestDto value, $Res Function(_PriceRequestDto) _then) =
      __$PriceRequestDtoCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(toJson: _listToString) List<String> ids});
}

/// @nodoc
class __$PriceRequestDtoCopyWithImpl<$Res> implements _$PriceRequestDtoCopyWith<$Res> {
  __$PriceRequestDtoCopyWithImpl(this._self, this._then);

  final _PriceRequestDto _self;
  final $Res Function(_PriceRequestDto) _then;

  /// Create a copy of PriceRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? ids = null}) {
    return _then(
      _PriceRequestDto(
        ids:
            null == ids
                ? _self._ids
                : ids // ignore: cast_nullable_to_non_nullable
                    as List<String>,
      ),
    );
  }
}

/// @nodoc
mixin _$PriceResponseDto {
  Map<String, PriceDto> get data;

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PriceResponseDtoCopyWith<PriceResponseDto> get copyWith =>
      _$PriceResponseDtoCopyWithImpl<PriceResponseDto>(this as PriceResponseDto, _$identity);

  /// Serializes this PriceResponseDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PriceResponseDto &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'PriceResponseDto(data: $data)';
  }
}

/// @nodoc
abstract mixin class $PriceResponseDtoCopyWith<$Res> {
  factory $PriceResponseDtoCopyWith(PriceResponseDto value, $Res Function(PriceResponseDto) _then) =
      _$PriceResponseDtoCopyWithImpl;
  @useResult
  $Res call({Map<String, PriceDto> data});
}

/// @nodoc
class _$PriceResponseDtoCopyWithImpl<$Res> implements $PriceResponseDtoCopyWith<$Res> {
  _$PriceResponseDtoCopyWithImpl(this._self, this._then);

  final PriceResponseDto _self;
  final $Res Function(PriceResponseDto) _then;

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _self.copyWith(
        data:
            null == data
                ? _self.data
                : data // ignore: cast_nullable_to_non_nullable
                    as Map<String, PriceDto>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _PriceResponseDto implements PriceResponseDto {
  const _PriceResponseDto({required final Map<String, PriceDto> data}) : _data = data;
  factory _PriceResponseDto.fromJson(Map<String, dynamic> json) => _$PriceResponseDtoFromJson(json);

  final Map<String, PriceDto> _data;
  @override
  Map<String, PriceDto> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PriceResponseDtoCopyWith<_PriceResponseDto> get copyWith =>
      __$PriceResponseDtoCopyWithImpl<_PriceResponseDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PriceResponseDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PriceResponseDto &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'PriceResponseDto(data: $data)';
  }
}

/// @nodoc
abstract mixin class _$PriceResponseDtoCopyWith<$Res> implements $PriceResponseDtoCopyWith<$Res> {
  factory _$PriceResponseDtoCopyWith(
    _PriceResponseDto value,
    $Res Function(_PriceResponseDto) _then,
  ) = __$PriceResponseDtoCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, PriceDto> data});
}

/// @nodoc
class __$PriceResponseDtoCopyWithImpl<$Res> implements _$PriceResponseDtoCopyWith<$Res> {
  __$PriceResponseDtoCopyWithImpl(this._self, this._then);

  final _PriceResponseDto _self;
  final $Res Function(_PriceResponseDto) _then;

  /// Create a copy of PriceResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? data = null}) {
    return _then(
      _PriceResponseDto(
        data:
            null == data
                ? _self._data
                : data // ignore: cast_nullable_to_non_nullable
                    as Map<String, PriceDto>,
      ),
    );
  }
}

/// @nodoc
mixin _$PriceDto {
  String? get price;

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PriceDtoCopyWith<PriceDto> get copyWith =>
      _$PriceDtoCopyWithImpl<PriceDto>(this as PriceDto, _$identity);

  /// Serializes this PriceDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PriceDto &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, price);

  @override
  String toString() {
    return 'PriceDto(price: $price)';
  }
}

/// @nodoc
abstract mixin class $PriceDtoCopyWith<$Res> {
  factory $PriceDtoCopyWith(PriceDto value, $Res Function(PriceDto) _then) = _$PriceDtoCopyWithImpl;
  @useResult
  $Res call({String? price});
}

/// @nodoc
class _$PriceDtoCopyWithImpl<$Res> implements $PriceDtoCopyWith<$Res> {
  _$PriceDtoCopyWithImpl(this._self, this._then);

  final PriceDto _self;
  final $Res Function(PriceDto) _then;

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? price = freezed}) {
    return _then(
      _self.copyWith(
        price:
            freezed == price
                ? _self.price
                : price // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _PriceDto implements PriceDto {
  const _PriceDto({required this.price});
  factory _PriceDto.fromJson(Map<String, dynamic> json) => _$PriceDtoFromJson(json);

  @override
  final String? price;

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PriceDtoCopyWith<_PriceDto> get copyWith =>
      __$PriceDtoCopyWithImpl<_PriceDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PriceDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PriceDto &&
            (identical(other.price, price) || other.price == price));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, price);

  @override
  String toString() {
    return 'PriceDto(price: $price)';
  }
}

/// @nodoc
abstract mixin class _$PriceDtoCopyWith<$Res> implements $PriceDtoCopyWith<$Res> {
  factory _$PriceDtoCopyWith(_PriceDto value, $Res Function(_PriceDto) _then) =
      __$PriceDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String? price});
}

/// @nodoc
class __$PriceDtoCopyWithImpl<$Res> implements _$PriceDtoCopyWith<$Res> {
  __$PriceDtoCopyWithImpl(this._self, this._then);

  final _PriceDto _self;
  final $Res Function(_PriceDto) _then;

  /// Create a copy of PriceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? price = freezed}) {
    return _then(
      _PriceDto(
        price:
            freezed == price
                ? _self.price
                : price // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}
