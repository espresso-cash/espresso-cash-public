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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JupiterIndexedRouteMap _$JupiterIndexedRouteMapFromJson(
    Map<String, dynamic> json) {
  return _JupiterIndexedRouteMap.fromJson(json);
}

/// @nodoc
mixin _$JupiterIndexedRouteMap {
  List<String> get mintKeys => throw _privateConstructorUsedError;
  Map<String, List<int>> get indexedRouteMap =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JupiterIndexedRouteMapCopyWith<JupiterIndexedRouteMap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterIndexedRouteMapCopyWith<$Res> {
  factory $JupiterIndexedRouteMapCopyWith(JupiterIndexedRouteMap value,
          $Res Function(JupiterIndexedRouteMap) then) =
      _$JupiterIndexedRouteMapCopyWithImpl<$Res, JupiterIndexedRouteMap>;
  @useResult
  $Res call({List<String> mintKeys, Map<String, List<int>> indexedRouteMap});
}

/// @nodoc
class _$JupiterIndexedRouteMapCopyWithImpl<$Res,
        $Val extends JupiterIndexedRouteMap>
    implements $JupiterIndexedRouteMapCopyWith<$Res> {
  _$JupiterIndexedRouteMapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mintKeys = null,
    Object? indexedRouteMap = null,
  }) {
    return _then(_value.copyWith(
      mintKeys: null == mintKeys
          ? _value.mintKeys
          : mintKeys // ignore: cast_nullable_to_non_nullable
              as List<String>,
      indexedRouteMap: null == indexedRouteMap
          ? _value.indexedRouteMap
          : indexedRouteMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JupiterIndexedRouteMapImplCopyWith<$Res>
    implements $JupiterIndexedRouteMapCopyWith<$Res> {
  factory _$$JupiterIndexedRouteMapImplCopyWith(
          _$JupiterIndexedRouteMapImpl value,
          $Res Function(_$JupiterIndexedRouteMapImpl) then) =
      __$$JupiterIndexedRouteMapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> mintKeys, Map<String, List<int>> indexedRouteMap});
}

/// @nodoc
class __$$JupiterIndexedRouteMapImplCopyWithImpl<$Res>
    extends _$JupiterIndexedRouteMapCopyWithImpl<$Res,
        _$JupiterIndexedRouteMapImpl>
    implements _$$JupiterIndexedRouteMapImplCopyWith<$Res> {
  __$$JupiterIndexedRouteMapImplCopyWithImpl(
      _$JupiterIndexedRouteMapImpl _value,
      $Res Function(_$JupiterIndexedRouteMapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mintKeys = null,
    Object? indexedRouteMap = null,
  }) {
    return _then(_$JupiterIndexedRouteMapImpl(
      mintKeys: null == mintKeys
          ? _value._mintKeys
          : mintKeys // ignore: cast_nullable_to_non_nullable
              as List<String>,
      indexedRouteMap: null == indexedRouteMap
          ? _value._indexedRouteMap
          : indexedRouteMap // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterIndexedRouteMapImpl implements _JupiterIndexedRouteMap {
  const _$JupiterIndexedRouteMapImpl(
      {required final List<String> mintKeys,
      required final Map<String, List<int>> indexedRouteMap})
      : _mintKeys = mintKeys,
        _indexedRouteMap = indexedRouteMap;

  factory _$JupiterIndexedRouteMapImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterIndexedRouteMapImplFromJson(json);

  final List<String> _mintKeys;
  @override
  List<String> get mintKeys {
    if (_mintKeys is EqualUnmodifiableListView) return _mintKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mintKeys);
  }

  final Map<String, List<int>> _indexedRouteMap;
  @override
  Map<String, List<int>> get indexedRouteMap {
    if (_indexedRouteMap is EqualUnmodifiableMapView) return _indexedRouteMap;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_indexedRouteMap);
  }

  @override
  String toString() {
    return 'JupiterIndexedRouteMap(mintKeys: $mintKeys, indexedRouteMap: $indexedRouteMap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JupiterIndexedRouteMapImpl &&
            const DeepCollectionEquality().equals(other._mintKeys, _mintKeys) &&
            const DeepCollectionEquality()
                .equals(other._indexedRouteMap, _indexedRouteMap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mintKeys),
      const DeepCollectionEquality().hash(_indexedRouteMap));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterIndexedRouteMapImplCopyWith<_$JupiterIndexedRouteMapImpl>
      get copyWith => __$$JupiterIndexedRouteMapImplCopyWithImpl<
          _$JupiterIndexedRouteMapImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterIndexedRouteMapImplToJson(
      this,
    );
  }
}

abstract class _JupiterIndexedRouteMap implements JupiterIndexedRouteMap {
  const factory _JupiterIndexedRouteMap(
          {required final List<String> mintKeys,
          required final Map<String, List<int>> indexedRouteMap}) =
      _$JupiterIndexedRouteMapImpl;

  factory _JupiterIndexedRouteMap.fromJson(Map<String, dynamic> json) =
      _$JupiterIndexedRouteMapImpl.fromJson;

  @override
  List<String> get mintKeys;
  @override
  Map<String, List<int>> get indexedRouteMap;
  @override
  @JsonKey(ignore: true)
  _$$JupiterIndexedRouteMapImplCopyWith<_$JupiterIndexedRouteMapImpl>
      get copyWith => throw _privateConstructorUsedError;
}

JupiterRoute _$JupiterRouteFromJson(Map<String, dynamic> json) {
  return _JupiterRoute.fromJson(json);
}

/// @nodoc
mixin _$JupiterRoute {
  String get inAmount => throw _privateConstructorUsedError;
  String get outAmount => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get otherAmountThreshold => throw _privateConstructorUsedError;
  int get slippageBps => throw _privateConstructorUsedError;
  num get priceImpactPct => throw _privateConstructorUsedError;
  List<JupiterMarket> get marketInfos => throw _privateConstructorUsedError;
  SwapMode get swapMode => throw _privateConstructorUsedError;
  JupiterRouteFee? get fees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JupiterRouteCopyWith<JupiterRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterRouteCopyWith<$Res> {
  factory $JupiterRouteCopyWith(
          JupiterRoute value, $Res Function(JupiterRoute) then) =
      _$JupiterRouteCopyWithImpl<$Res, JupiterRoute>;
  @useResult
  $Res call(
      {String inAmount,
      String outAmount,
      String amount,
      String otherAmountThreshold,
      int slippageBps,
      num priceImpactPct,
      List<JupiterMarket> marketInfos,
      SwapMode swapMode,
      JupiterRouteFee? fees});

  $JupiterRouteFeeCopyWith<$Res>? get fees;
}

/// @nodoc
class _$JupiterRouteCopyWithImpl<$Res, $Val extends JupiterRoute>
    implements $JupiterRouteCopyWith<$Res> {
  _$JupiterRouteCopyWithImpl(this._value, this._then);

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
    Object? otherAmountThreshold = null,
    Object? slippageBps = null,
    Object? priceImpactPct = null,
    Object? marketInfos = null,
    Object? swapMode = null,
    Object? fees = freezed,
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
      otherAmountThreshold: null == otherAmountThreshold
          ? _value.otherAmountThreshold
          : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
              as String,
      slippageBps: null == slippageBps
          ? _value.slippageBps
          : slippageBps // ignore: cast_nullable_to_non_nullable
              as int,
      priceImpactPct: null == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as num,
      marketInfos: null == marketInfos
          ? _value.marketInfos
          : marketInfos // ignore: cast_nullable_to_non_nullable
              as List<JupiterMarket>,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
      fees: freezed == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as JupiterRouteFee?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JupiterRouteFeeCopyWith<$Res>? get fees {
    if (_value.fees == null) {
      return null;
    }

    return $JupiterRouteFeeCopyWith<$Res>(_value.fees!, (value) {
      return _then(_value.copyWith(fees: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JupiterRouteImplCopyWith<$Res>
    implements $JupiterRouteCopyWith<$Res> {
  factory _$$JupiterRouteImplCopyWith(
          _$JupiterRouteImpl value, $Res Function(_$JupiterRouteImpl) then) =
      __$$JupiterRouteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inAmount,
      String outAmount,
      String amount,
      String otherAmountThreshold,
      int slippageBps,
      num priceImpactPct,
      List<JupiterMarket> marketInfos,
      SwapMode swapMode,
      JupiterRouteFee? fees});

  @override
  $JupiterRouteFeeCopyWith<$Res>? get fees;
}

/// @nodoc
class __$$JupiterRouteImplCopyWithImpl<$Res>
    extends _$JupiterRouteCopyWithImpl<$Res, _$JupiterRouteImpl>
    implements _$$JupiterRouteImplCopyWith<$Res> {
  __$$JupiterRouteImplCopyWithImpl(
      _$JupiterRouteImpl _value, $Res Function(_$JupiterRouteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inAmount = null,
    Object? outAmount = null,
    Object? amount = null,
    Object? otherAmountThreshold = null,
    Object? slippageBps = null,
    Object? priceImpactPct = null,
    Object? marketInfos = null,
    Object? swapMode = null,
    Object? fees = freezed,
  }) {
    return _then(_$JupiterRouteImpl(
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
      otherAmountThreshold: null == otherAmountThreshold
          ? _value.otherAmountThreshold
          : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
              as String,
      slippageBps: null == slippageBps
          ? _value.slippageBps
          : slippageBps // ignore: cast_nullable_to_non_nullable
              as int,
      priceImpactPct: null == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as num,
      marketInfos: null == marketInfos
          ? _value._marketInfos
          : marketInfos // ignore: cast_nullable_to_non_nullable
              as List<JupiterMarket>,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
      fees: freezed == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as JupiterRouteFee?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterRouteImpl implements _JupiterRoute {
  const _$JupiterRouteImpl(
      {required this.inAmount,
      required this.outAmount,
      required this.amount,
      required this.otherAmountThreshold,
      required this.slippageBps,
      required this.priceImpactPct,
      required final List<JupiterMarket> marketInfos,
      required this.swapMode,
      required this.fees})
      : _marketInfos = marketInfos;

  factory _$JupiterRouteImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterRouteImplFromJson(json);

  @override
  final String inAmount;
  @override
  final String outAmount;
  @override
  final String amount;
  @override
  final String otherAmountThreshold;
  @override
  final int slippageBps;
  @override
  final num priceImpactPct;
  final List<JupiterMarket> _marketInfos;
  @override
  List<JupiterMarket> get marketInfos {
    if (_marketInfos is EqualUnmodifiableListView) return _marketInfos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_marketInfos);
  }

  @override
  final SwapMode swapMode;
  @override
  final JupiterRouteFee? fees;

  @override
  String toString() {
    return 'JupiterRoute(inAmount: $inAmount, outAmount: $outAmount, amount: $amount, otherAmountThreshold: $otherAmountThreshold, slippageBps: $slippageBps, priceImpactPct: $priceImpactPct, marketInfos: $marketInfos, swapMode: $swapMode, fees: $fees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JupiterRouteImpl &&
            (identical(other.inAmount, inAmount) ||
                other.inAmount == inAmount) &&
            (identical(other.outAmount, outAmount) ||
                other.outAmount == outAmount) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.otherAmountThreshold, otherAmountThreshold) ||
                other.otherAmountThreshold == otherAmountThreshold) &&
            (identical(other.slippageBps, slippageBps) ||
                other.slippageBps == slippageBps) &&
            (identical(other.priceImpactPct, priceImpactPct) ||
                other.priceImpactPct == priceImpactPct) &&
            const DeepCollectionEquality()
                .equals(other._marketInfos, _marketInfos) &&
            (identical(other.swapMode, swapMode) ||
                other.swapMode == swapMode) &&
            (identical(other.fees, fees) || other.fees == fees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      inAmount,
      outAmount,
      amount,
      otherAmountThreshold,
      slippageBps,
      priceImpactPct,
      const DeepCollectionEquality().hash(_marketInfos),
      swapMode,
      fees);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterRouteImplCopyWith<_$JupiterRouteImpl> get copyWith =>
      __$$JupiterRouteImplCopyWithImpl<_$JupiterRouteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterRouteImplToJson(
      this,
    );
  }
}

abstract class _JupiterRoute implements JupiterRoute {
  const factory _JupiterRoute(
      {required final String inAmount,
      required final String outAmount,
      required final String amount,
      required final String otherAmountThreshold,
      required final int slippageBps,
      required final num priceImpactPct,
      required final List<JupiterMarket> marketInfos,
      required final SwapMode swapMode,
      required final JupiterRouteFee? fees}) = _$JupiterRouteImpl;

  factory _JupiterRoute.fromJson(Map<String, dynamic> json) =
      _$JupiterRouteImpl.fromJson;

  @override
  String get inAmount;
  @override
  String get outAmount;
  @override
  String get amount;
  @override
  String get otherAmountThreshold;
  @override
  int get slippageBps;
  @override
  num get priceImpactPct;
  @override
  List<JupiterMarket> get marketInfos;
  @override
  SwapMode get swapMode;
  @override
  JupiterRouteFee? get fees;
  @override
  @JsonKey(ignore: true)
  _$$JupiterRouteImplCopyWith<_$JupiterRouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JupiterMarket _$JupiterMarketFromJson(Map<String, dynamic> json) {
  return _JupiterMarket.fromJson(json);
}

/// @nodoc
mixin _$JupiterMarket {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get inputMint => throw _privateConstructorUsedError;
  String get outputMint => throw _privateConstructorUsedError;
  bool get notEnoughLiquidity => throw _privateConstructorUsedError;
  String get inAmount => throw _privateConstructorUsedError;
  String get outAmount => throw _privateConstructorUsedError;
  num get priceImpactPct => throw _privateConstructorUsedError;
  String? get minInAmount => throw _privateConstructorUsedError;
  String? get minOutAmount => throw _privateConstructorUsedError;
  JupiterMarketFee get lpFee => throw _privateConstructorUsedError;
  JupiterMarketFee get platformFee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JupiterMarketCopyWith<JupiterMarket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterMarketCopyWith<$Res> {
  factory $JupiterMarketCopyWith(
          JupiterMarket value, $Res Function(JupiterMarket) then) =
      _$JupiterMarketCopyWithImpl<$Res, JupiterMarket>;
  @useResult
  $Res call(
      {String id,
      String label,
      String inputMint,
      String outputMint,
      bool notEnoughLiquidity,
      String inAmount,
      String outAmount,
      num priceImpactPct,
      String? minInAmount,
      String? minOutAmount,
      JupiterMarketFee lpFee,
      JupiterMarketFee platformFee});

  $JupiterMarketFeeCopyWith<$Res> get lpFee;
  $JupiterMarketFeeCopyWith<$Res> get platformFee;
}

/// @nodoc
class _$JupiterMarketCopyWithImpl<$Res, $Val extends JupiterMarket>
    implements $JupiterMarketCopyWith<$Res> {
  _$JupiterMarketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? inputMint = null,
    Object? outputMint = null,
    Object? notEnoughLiquidity = null,
    Object? inAmount = null,
    Object? outAmount = null,
    Object? priceImpactPct = null,
    Object? minInAmount = freezed,
    Object? minOutAmount = freezed,
    Object? lpFee = null,
    Object? platformFee = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      notEnoughLiquidity: null == notEnoughLiquidity
          ? _value.notEnoughLiquidity
          : notEnoughLiquidity // ignore: cast_nullable_to_non_nullable
              as bool,
      inAmount: null == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      priceImpactPct: null == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as num,
      minInAmount: freezed == minInAmount
          ? _value.minInAmount
          : minInAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      minOutAmount: freezed == minOutAmount
          ? _value.minOutAmount
          : minOutAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      lpFee: null == lpFee
          ? _value.lpFee
          : lpFee // ignore: cast_nullable_to_non_nullable
              as JupiterMarketFee,
      platformFee: null == platformFee
          ? _value.platformFee
          : platformFee // ignore: cast_nullable_to_non_nullable
              as JupiterMarketFee,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JupiterMarketFeeCopyWith<$Res> get lpFee {
    return $JupiterMarketFeeCopyWith<$Res>(_value.lpFee, (value) {
      return _then(_value.copyWith(lpFee: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $JupiterMarketFeeCopyWith<$Res> get platformFee {
    return $JupiterMarketFeeCopyWith<$Res>(_value.platformFee, (value) {
      return _then(_value.copyWith(platformFee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JupiterMarketImplCopyWith<$Res>
    implements $JupiterMarketCopyWith<$Res> {
  factory _$$JupiterMarketImplCopyWith(
          _$JupiterMarketImpl value, $Res Function(_$JupiterMarketImpl) then) =
      __$$JupiterMarketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      String inputMint,
      String outputMint,
      bool notEnoughLiquidity,
      String inAmount,
      String outAmount,
      num priceImpactPct,
      String? minInAmount,
      String? minOutAmount,
      JupiterMarketFee lpFee,
      JupiterMarketFee platformFee});

  @override
  $JupiterMarketFeeCopyWith<$Res> get lpFee;
  @override
  $JupiterMarketFeeCopyWith<$Res> get platformFee;
}

/// @nodoc
class __$$JupiterMarketImplCopyWithImpl<$Res>
    extends _$JupiterMarketCopyWithImpl<$Res, _$JupiterMarketImpl>
    implements _$$JupiterMarketImplCopyWith<$Res> {
  __$$JupiterMarketImplCopyWithImpl(
      _$JupiterMarketImpl _value, $Res Function(_$JupiterMarketImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? inputMint = null,
    Object? outputMint = null,
    Object? notEnoughLiquidity = null,
    Object? inAmount = null,
    Object? outAmount = null,
    Object? priceImpactPct = null,
    Object? minInAmount = freezed,
    Object? minOutAmount = freezed,
    Object? lpFee = null,
    Object? platformFee = null,
  }) {
    return _then(_$JupiterMarketImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      notEnoughLiquidity: null == notEnoughLiquidity
          ? _value.notEnoughLiquidity
          : notEnoughLiquidity // ignore: cast_nullable_to_non_nullable
              as bool,
      inAmount: null == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      priceImpactPct: null == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as num,
      minInAmount: freezed == minInAmount
          ? _value.minInAmount
          : minInAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      minOutAmount: freezed == minOutAmount
          ? _value.minOutAmount
          : minOutAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      lpFee: null == lpFee
          ? _value.lpFee
          : lpFee // ignore: cast_nullable_to_non_nullable
              as JupiterMarketFee,
      platformFee: null == platformFee
          ? _value.platformFee
          : platformFee // ignore: cast_nullable_to_non_nullable
              as JupiterMarketFee,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterMarketImpl implements _JupiterMarket {
  const _$JupiterMarketImpl(
      {required this.id,
      required this.label,
      required this.inputMint,
      required this.outputMint,
      required this.notEnoughLiquidity,
      required this.inAmount,
      required this.outAmount,
      required this.priceImpactPct,
      required this.minInAmount,
      required this.minOutAmount,
      required this.lpFee,
      required this.platformFee});

  factory _$JupiterMarketImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterMarketImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String inputMint;
  @override
  final String outputMint;
  @override
  final bool notEnoughLiquidity;
  @override
  final String inAmount;
  @override
  final String outAmount;
  @override
  final num priceImpactPct;
  @override
  final String? minInAmount;
  @override
  final String? minOutAmount;
  @override
  final JupiterMarketFee lpFee;
  @override
  final JupiterMarketFee platformFee;

  @override
  String toString() {
    return 'JupiterMarket(id: $id, label: $label, inputMint: $inputMint, outputMint: $outputMint, notEnoughLiquidity: $notEnoughLiquidity, inAmount: $inAmount, outAmount: $outAmount, priceImpactPct: $priceImpactPct, minInAmount: $minInAmount, minOutAmount: $minOutAmount, lpFee: $lpFee, platformFee: $platformFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JupiterMarketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.inputMint, inputMint) ||
                other.inputMint == inputMint) &&
            (identical(other.outputMint, outputMint) ||
                other.outputMint == outputMint) &&
            (identical(other.notEnoughLiquidity, notEnoughLiquidity) ||
                other.notEnoughLiquidity == notEnoughLiquidity) &&
            (identical(other.inAmount, inAmount) ||
                other.inAmount == inAmount) &&
            (identical(other.outAmount, outAmount) ||
                other.outAmount == outAmount) &&
            (identical(other.priceImpactPct, priceImpactPct) ||
                other.priceImpactPct == priceImpactPct) &&
            (identical(other.minInAmount, minInAmount) ||
                other.minInAmount == minInAmount) &&
            (identical(other.minOutAmount, minOutAmount) ||
                other.minOutAmount == minOutAmount) &&
            (identical(other.lpFee, lpFee) || other.lpFee == lpFee) &&
            (identical(other.platformFee, platformFee) ||
                other.platformFee == platformFee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      label,
      inputMint,
      outputMint,
      notEnoughLiquidity,
      inAmount,
      outAmount,
      priceImpactPct,
      minInAmount,
      minOutAmount,
      lpFee,
      platformFee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterMarketImplCopyWith<_$JupiterMarketImpl> get copyWith =>
      __$$JupiterMarketImplCopyWithImpl<_$JupiterMarketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterMarketImplToJson(
      this,
    );
  }
}

abstract class _JupiterMarket implements JupiterMarket {
  const factory _JupiterMarket(
      {required final String id,
      required final String label,
      required final String inputMint,
      required final String outputMint,
      required final bool notEnoughLiquidity,
      required final String inAmount,
      required final String outAmount,
      required final num priceImpactPct,
      required final String? minInAmount,
      required final String? minOutAmount,
      required final JupiterMarketFee lpFee,
      required final JupiterMarketFee platformFee}) = _$JupiterMarketImpl;

  factory _JupiterMarket.fromJson(Map<String, dynamic> json) =
      _$JupiterMarketImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String get inputMint;
  @override
  String get outputMint;
  @override
  bool get notEnoughLiquidity;
  @override
  String get inAmount;
  @override
  String get outAmount;
  @override
  num get priceImpactPct;
  @override
  String? get minInAmount;
  @override
  String? get minOutAmount;
  @override
  JupiterMarketFee get lpFee;
  @override
  JupiterMarketFee get platformFee;
  @override
  @JsonKey(ignore: true)
  _$$JupiterMarketImplCopyWith<_$JupiterMarketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JupiterMarketFee _$JupiterMarketFeeFromJson(Map<String, dynamic> json) {
  return _JupiterMarketFee.fromJson(json);
}

/// @nodoc
mixin _$JupiterMarketFee {
  String? get amount => throw _privateConstructorUsedError;
  num? get feeBps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JupiterMarketFeeCopyWith<JupiterMarketFee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterMarketFeeCopyWith<$Res> {
  factory $JupiterMarketFeeCopyWith(
          JupiterMarketFee value, $Res Function(JupiterMarketFee) then) =
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? feeBps = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      feeBps: freezed == feeBps
          ? _value.feeBps
          : feeBps // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JupiterMarketFeeImplCopyWith<$Res>
    implements $JupiterMarketFeeCopyWith<$Res> {
  factory _$$JupiterMarketFeeImplCopyWith(_$JupiterMarketFeeImpl value,
          $Res Function(_$JupiterMarketFeeImpl) then) =
      __$$JupiterMarketFeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? amount, num? feeBps});
}

/// @nodoc
class __$$JupiterMarketFeeImplCopyWithImpl<$Res>
    extends _$JupiterMarketFeeCopyWithImpl<$Res, _$JupiterMarketFeeImpl>
    implements _$$JupiterMarketFeeImplCopyWith<$Res> {
  __$$JupiterMarketFeeImplCopyWithImpl(_$JupiterMarketFeeImpl _value,
      $Res Function(_$JupiterMarketFeeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? feeBps = freezed,
  }) {
    return _then(_$JupiterMarketFeeImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      feeBps: freezed == feeBps
          ? _value.feeBps
          : feeBps // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterMarketFeeImpl implements _JupiterMarketFee {
  const _$JupiterMarketFeeImpl(
      {required this.amount, required this.mint, required this.pct});

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, feeBps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterMarketFeeImplCopyWith<_$JupiterMarketFeeImpl> get copyWith =>
      __$$JupiterMarketFeeImplCopyWithImpl<_$JupiterMarketFeeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterMarketFeeImplToJson(
      this,
    );
  }
}

abstract class _JupiterMarketFee implements JupiterMarketFee {
  const factory _JupiterMarketFee(
      {required final String amount,
      required final String mint,
      required final num pct}) = _$JupiterMarketFeeImpl;

  factory _JupiterMarketFee.fromJson(Map<String, dynamic> json) =
      _$JupiterMarketFeeImpl.fromJson;

  @override
  String? get amount;
  @override
  num? get feeBps;
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoutePlanCopyWith<RoutePlan> get copyWith =>
      throw _privateConstructorUsedError;
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
class _$RoutePlanCopyWithImpl<$Res, $Val extends RoutePlan>
    implements $RoutePlanCopyWith<$Res> {
  _$RoutePlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapInfo = null,
    Object? percent = null,
  }) {
    return _then(_value.copyWith(
      swapInfo: null == swapInfo
          ? _value.swapInfo
          : swapInfo // ignore: cast_nullable_to_non_nullable
              as JupiterSwapInfo,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JupiterSwapInfoCopyWith<$Res> get swapInfo {
    return $JupiterSwapInfoCopyWith<$Res>(_value.swapInfo, (value) {
      return _then(_value.copyWith(swapInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JupiterRouteFeeImplCopyWith<$Res>
    implements $JupiterRouteFeeCopyWith<$Res> {
  factory _$$JupiterRouteFeeImplCopyWith(_$JupiterRouteFeeImpl value,
          $Res Function(_$JupiterRouteFeeImpl) then) =
      __$$JupiterRouteFeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({JupiterSwapInfo swapInfo, int percent});

  @override
  $JupiterSwapInfoCopyWith<$Res> get swapInfo;
}

/// @nodoc
class __$$JupiterRouteFeeImplCopyWithImpl<$Res>
    extends _$JupiterRouteFeeCopyWithImpl<$Res, _$JupiterRouteFeeImpl>
    implements _$$JupiterRouteFeeImplCopyWith<$Res> {
  __$$JupiterRouteFeeImplCopyWithImpl(
      _$JupiterRouteFeeImpl _value, $Res Function(_$JupiterRouteFeeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapInfo = null,
    Object? percent = null,
  }) {
    return _then(_$JupiterRouteFeeImpl(
      signatureFee: null == signatureFee
          ? _value.signatureFee
          : signatureFee // ignore: cast_nullable_to_non_nullable
              as num,
      openOrdersDeposits: null == openOrdersDeposits
          ? _value._openOrdersDeposits
          : openOrdersDeposits // ignore: cast_nullable_to_non_nullable
              as List<num>,
      ataDeposits: null == ataDeposits
          ? _value._ataDeposits
          : ataDeposits // ignore: cast_nullable_to_non_nullable
              as List<num>,
      totalFeeAndDeposits: null == totalFeeAndDeposits
          ? _value.totalFeeAndDeposits
          : totalFeeAndDeposits // ignore: cast_nullable_to_non_nullable
              as num,
      minimumSOLForTransaction: null == minimumSOLForTransaction
          ? _value.minimumSOLForTransaction
          : minimumSOLForTransaction // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterRouteFeeImpl implements _JupiterRouteFee {
  const _$JupiterRouteFeeImpl(
      {required this.signatureFee,
      required final List<num> openOrdersDeposits,
      required final List<num> ataDeposits,
      required this.totalFeeAndDeposits,
      required this.minimumSOLForTransaction})
      : _openOrdersDeposits = openOrdersDeposits,
        _ataDeposits = ataDeposits;

  factory _$JupiterRouteFeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterRouteFeeImplFromJson(json);

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
            other is _$JupiterRouteFeeImpl &&
            (identical(other.signatureFee, signatureFee) ||
                other.signatureFee == signatureFee) &&
            const DeepCollectionEquality()
                .equals(other._openOrdersDeposits, _openOrdersDeposits) &&
            const DeepCollectionEquality()
                .equals(other._ataDeposits, _ataDeposits) &&
            (identical(other.totalFeeAndDeposits, totalFeeAndDeposits) ||
                other.totalFeeAndDeposits == totalFeeAndDeposits) &&
            (identical(
                    other.minimumSOLForTransaction, minimumSOLForTransaction) ||
                other.minimumSOLForTransaction == minimumSOLForTransaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, swapInfo, percent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterRouteFeeImplCopyWith<_$JupiterRouteFeeImpl> get copyWith =>
      __$$JupiterRouteFeeImplCopyWithImpl<_$JupiterRouteFeeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterRouteFeeImplToJson(
      this,
    );
  }
}

abstract class _JupiterRouteFee implements JupiterRouteFee {
  const factory _JupiterRouteFee(
      {required final num signatureFee,
      required final List<num> openOrdersDeposits,
      required final List<num> ataDeposits,
      required final num totalFeeAndDeposits,
      required final num minimumSOLForTransaction}) = _$JupiterRouteFeeImpl;

  factory _JupiterRouteFee.fromJson(Map<String, dynamic> json) =
      _$JupiterRouteFeeImpl.fromJson;

  @override
  JupiterSwapInfo get swapInfo;
  @override
  int get percent;
  @override
  @JsonKey(ignore: true)
  _$$JupiterRouteFeeImplCopyWith<_$JupiterRouteFeeImpl> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuoteResponseDtoCopyWith<QuoteResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteResponseDtoCopyWith<$Res> {
  factory $QuoteResponseDtoCopyWith(
          QuoteResponseDto value, $Res Function(QuoteResponseDto) then) =
      _$QuoteResponseDtoCopyWithImpl<$Res, QuoteResponseDto>;
  @useResult
  $Res call(
      {String inputMint,
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
      double? timeTaken});

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
    return _then(_value.copyWith(
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      inAmount: null == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      otherAmountThreshold: null == otherAmountThreshold
          ? _value.otherAmountThreshold
          : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
              as String,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
      slippageBps: null == slippageBps
          ? _value.slippageBps
          : slippageBps // ignore: cast_nullable_to_non_nullable
              as int,
      platformFee: freezed == platformFee
          ? _value.platformFee
          : platformFee // ignore: cast_nullable_to_non_nullable
              as JupiterMarketFee?,
      priceImpactPct: null == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as String,
      routePlan: null == routePlan
          ? _value.routePlan
          : routePlan // ignore: cast_nullable_to_non_nullable
              as List<RoutePlan>,
      contextSlot: freezed == contextSlot
          ? _value.contextSlot
          : contextSlot // ignore: cast_nullable_to_non_nullable
              as num?,
      timeTaken: freezed == timeTaken
          ? _value.timeTaken
          : timeTaken // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

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
abstract class _$$QuoteResponseDtoImplCopyWith<$Res>
    implements $QuoteResponseDtoCopyWith<$Res> {
  factory _$$QuoteResponseDtoImplCopyWith(_$QuoteResponseDtoImpl value,
          $Res Function(_$QuoteResponseDtoImpl) then) =
      __$$QuoteResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inputMint,
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
      double? timeTaken});

  @override
  $JupiterMarketFeeCopyWith<$Res>? get platformFee;
}

/// @nodoc
class __$$QuoteResponseDtoImplCopyWithImpl<$Res>
    extends _$QuoteResponseDtoCopyWithImpl<$Res, _$QuoteResponseDtoImpl>
    implements _$$QuoteResponseDtoImplCopyWith<$Res> {
  __$$QuoteResponseDtoImplCopyWithImpl(_$QuoteResponseDtoImpl _value,
      $Res Function(_$QuoteResponseDtoImpl) _then)
      : super(_value, _then);

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
    return _then(_$QuoteResponseDtoImpl(
      routes: null == routes
          ? _value._routes
          : routes // ignore: cast_nullable_to_non_nullable
              as List<JupiterRoute>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteResponseDtoImpl implements _QuoteResponseDto {
  const _$QuoteResponseDtoImpl(
      {@JsonKey(name: 'data') required final List<JupiterRoute> routes})
      : _routes = routes;

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
            const DeepCollectionEquality().equals(other._routes, _routes));
  }

  @JsonKey(ignore: true)
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
      timeTaken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteResponseDtoImplCopyWith<_$QuoteResponseDtoImpl> get copyWith =>
      __$$QuoteResponseDtoImplCopyWithImpl<_$QuoteResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _QuoteResponseDto implements QuoteResponseDto {
  const factory _QuoteResponseDto(
          {@JsonKey(name: 'data') required final List<JupiterRoute> routes}) =
      _$QuoteResponseDtoImpl;

  factory _QuoteResponseDto.fromJson(Map<String, dynamic> json) =
      _$QuoteResponseDtoImpl.fromJson;

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
  @override
  @JsonKey(ignore: true)
  _$$QuoteResponseDtoImplCopyWith<_$QuoteResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IndexedRouteMapRequestDto _$IndexedRouteMapRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _IndexedRouteMapRequestDto.fromJson(json);
}

/// @nodoc
mixin _$IndexedRouteMapRequestDto {
  bool? get onlyDirectRoutes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IndexedRouteMapRequestDtoCopyWith<IndexedRouteMapRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndexedRouteMapRequestDtoCopyWith<$Res> {
  factory $IndexedRouteMapRequestDtoCopyWith(IndexedRouteMapRequestDto value,
          $Res Function(IndexedRouteMapRequestDto) then) =
      _$IndexedRouteMapRequestDtoCopyWithImpl<$Res, IndexedRouteMapRequestDto>;
  @useResult
  $Res call({bool? onlyDirectRoutes});
}

/// @nodoc
class _$IndexedRouteMapRequestDtoCopyWithImpl<$Res,
        $Val extends IndexedRouteMapRequestDto>
    implements $IndexedRouteMapRequestDtoCopyWith<$Res> {
  _$IndexedRouteMapRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onlyDirectRoutes = freezed,
  }) {
    return _then(_value.copyWith(
      onlyDirectRoutes: freezed == onlyDirectRoutes
          ? _value.onlyDirectRoutes
          : onlyDirectRoutes // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IndexedRouteMapRequestDtoImplCopyWith<$Res>
    implements $IndexedRouteMapRequestDtoCopyWith<$Res> {
  factory _$$IndexedRouteMapRequestDtoImplCopyWith(
          _$IndexedRouteMapRequestDtoImpl value,
          $Res Function(_$IndexedRouteMapRequestDtoImpl) then) =
      __$$IndexedRouteMapRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? onlyDirectRoutes});
}

/// @nodoc
class __$$IndexedRouteMapRequestDtoImplCopyWithImpl<$Res>
    extends _$IndexedRouteMapRequestDtoCopyWithImpl<$Res,
        _$IndexedRouteMapRequestDtoImpl>
    implements _$$IndexedRouteMapRequestDtoImplCopyWith<$Res> {
  __$$IndexedRouteMapRequestDtoImplCopyWithImpl(
      _$IndexedRouteMapRequestDtoImpl _value,
      $Res Function(_$IndexedRouteMapRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? onlyDirectRoutes = freezed,
  }) {
    return _then(_$IndexedRouteMapRequestDtoImpl(
      onlyDirectRoutes: freezed == onlyDirectRoutes
          ? _value.onlyDirectRoutes
          : onlyDirectRoutes // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IndexedRouteMapRequestDtoImpl implements _IndexedRouteMapRequestDto {
  const _$IndexedRouteMapRequestDtoImpl({this.onlyDirectRoutes});

  factory _$IndexedRouteMapRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$IndexedRouteMapRequestDtoImplFromJson(json);

  @override
  final bool? onlyDirectRoutes;

  @override
  String toString() {
    return 'IndexedRouteMapRequestDto(onlyDirectRoutes: $onlyDirectRoutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndexedRouteMapRequestDtoImpl &&
            (identical(other.onlyDirectRoutes, onlyDirectRoutes) ||
                other.onlyDirectRoutes == onlyDirectRoutes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, onlyDirectRoutes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IndexedRouteMapRequestDtoImplCopyWith<_$IndexedRouteMapRequestDtoImpl>
      get copyWith => __$$IndexedRouteMapRequestDtoImplCopyWithImpl<
          _$IndexedRouteMapRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IndexedRouteMapRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _IndexedRouteMapRequestDto implements IndexedRouteMapRequestDto {
  const factory _IndexedRouteMapRequestDto({final bool? onlyDirectRoutes}) =
      _$IndexedRouteMapRequestDtoImpl;

  factory _IndexedRouteMapRequestDto.fromJson(Map<String, dynamic> json) =
      _$IndexedRouteMapRequestDtoImpl.fromJson;

  @override
  bool? get onlyDirectRoutes;
  @override
  @JsonKey(ignore: true)
  _$$IndexedRouteMapRequestDtoImplCopyWith<_$IndexedRouteMapRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuoteRequestDtoCopyWith<QuoteRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteRequestDtoCopyWith<$Res> {
  factory $QuoteRequestDtoCopyWith(
          QuoteRequestDto value, $Res Function(QuoteRequestDto) then) =
      _$QuoteRequestDtoCopyWithImpl<$Res, QuoteRequestDto>;
  @useResult
  $Res call(
      {String inputMint,
      String outputMint,
      int amount,
      int? slippageBps,
      SwapMode swapMode,
      List<String>? dexes,
      List<String>? excludeDexes,
      bool? onlyDirectRoutes,
      bool? asLegacyTransaction,
      int? platformFeeBps,
      int? maxAccounts});
}

/// @nodoc
class _$QuoteRequestDtoCopyWithImpl<$Res, $Val extends QuoteRequestDto>
    implements $QuoteRequestDtoCopyWith<$Res> {
  _$QuoteRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
  }) {
    return _then(_value.copyWith(
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      slippageBps: freezed == slippageBps
          ? _value.slippageBps
          : slippageBps // ignore: cast_nullable_to_non_nullable
              as int?,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
      dexes: freezed == dexes
          ? _value.dexes
          : dexes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      excludeDexes: freezed == excludeDexes
          ? _value.excludeDexes
          : excludeDexes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      onlyDirectRoutes: freezed == onlyDirectRoutes
          ? _value.onlyDirectRoutes
          : onlyDirectRoutes // ignore: cast_nullable_to_non_nullable
              as bool?,
      asLegacyTransaction: freezed == asLegacyTransaction
          ? _value.asLegacyTransaction
          : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
              as bool?,
      platformFeeBps: freezed == platformFeeBps
          ? _value.platformFeeBps
          : platformFeeBps // ignore: cast_nullable_to_non_nullable
              as int?,
      maxAccounts: freezed == maxAccounts
          ? _value.maxAccounts
          : maxAccounts // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuoteRequestDtoImplCopyWith<$Res>
    implements $QuoteRequestDtoCopyWith<$Res> {
  factory _$$QuoteRequestDtoImplCopyWith(_$QuoteRequestDtoImpl value,
          $Res Function(_$QuoteRequestDtoImpl) then) =
      __$$QuoteRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String inputMint,
      String outputMint,
      int amount,
      int? slippageBps,
      SwapMode swapMode,
      List<String>? dexes,
      List<String>? excludeDexes,
      bool? onlyDirectRoutes,
      bool? asLegacyTransaction,
      int? platformFeeBps,
      int? maxAccounts});
}

/// @nodoc
class __$$QuoteRequestDtoImplCopyWithImpl<$Res>
    extends _$QuoteRequestDtoCopyWithImpl<$Res, _$QuoteRequestDtoImpl>
    implements _$$QuoteRequestDtoImplCopyWith<$Res> {
  __$$QuoteRequestDtoImplCopyWithImpl(
      _$QuoteRequestDtoImpl _value, $Res Function(_$QuoteRequestDtoImpl) _then)
      : super(_value, _then);

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
  }) {
    return _then(_$QuoteRequestDtoImpl(
      inputMint: null == inputMint
          ? _value.inputMint
          : inputMint // ignore: cast_nullable_to_non_nullable
              as String,
      outputMint: null == outputMint
          ? _value.outputMint
          : outputMint // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      slippageBps: freezed == slippageBps
          ? _value.slippageBps
          : slippageBps // ignore: cast_nullable_to_non_nullable
              as int?,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
      dexes: freezed == dexes
          ? _value._dexes
          : dexes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      excludeDexes: freezed == excludeDexes
          ? _value._excludeDexes
          : excludeDexes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      onlyDirectRoutes: freezed == onlyDirectRoutes
          ? _value.onlyDirectRoutes
          : onlyDirectRoutes // ignore: cast_nullable_to_non_nullable
              as bool?,
      asLegacyTransaction: freezed == asLegacyTransaction
          ? _value.asLegacyTransaction
          : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
              as bool?,
      platformFeeBps: freezed == platformFeeBps
          ? _value.platformFeeBps
          : platformFeeBps // ignore: cast_nullable_to_non_nullable
              as int?,
      maxAccounts: freezed == maxAccounts
          ? _value.maxAccounts
          : maxAccounts // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteRequestDtoImpl implements _QuoteRequestDto {
  const _$QuoteRequestDtoImpl(
      {required this.inputMint,
      required this.outputMint,
      required this.amount,
      this.slippageBps,
      this.swapMode = SwapMode.exactIn,
      final List<String>? dexes,
      final List<String>? excludeDexes,
      this.onlyDirectRoutes,
      this.asLegacyTransaction,
      this.platformFeeBps,
      this.maxAccounts})
      : _dexes = dexes,
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteRequestDtoImpl &&
            (identical(other.inputMint, inputMint) ||
                other.inputMint == inputMint) &&
            (identical(other.outputMint, outputMint) ||
                other.outputMint == outputMint) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.slippageBps, slippageBps) ||
                other.slippageBps == slippageBps) &&
            (identical(other.swapMode, swapMode) ||
                other.swapMode == swapMode) &&
            const DeepCollectionEquality().equals(other._dexes, _dexes) &&
            const DeepCollectionEquality()
                .equals(other._excludeDexes, _excludeDexes) &&
            (identical(other.onlyDirectRoutes, onlyDirectRoutes) ||
                other.onlyDirectRoutes == onlyDirectRoutes) &&
            (identical(other.asLegacyTransaction, asLegacyTransaction) ||
                other.asLegacyTransaction == asLegacyTransaction) &&
            (identical(other.platformFeeBps, platformFeeBps) ||
                other.platformFeeBps == platformFeeBps) &&
            (identical(other.maxAccounts, maxAccounts) ||
                other.maxAccounts == maxAccounts));
  }

  @JsonKey(ignore: true)
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
      maxAccounts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteRequestDtoImplCopyWith<_$QuoteRequestDtoImpl> get copyWith =>
      __$$QuoteRequestDtoImplCopyWithImpl<_$QuoteRequestDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _QuoteRequestDto implements QuoteRequestDto {
  const factory _QuoteRequestDto(
      {required final String inputMint,
      required final String outputMint,
      required final int amount,
      final int? slippageBps,
      final SwapMode swapMode,
      final List<String>? dexes,
      final List<String>? excludeDexes,
      final bool? onlyDirectRoutes,
      final String? userPublicKey,
      final bool? asLegacyTransaction}) = _$QuoteRequestDtoImpl;

  factory _QuoteRequestDto.fromJson(Map<String, dynamic> json) =
      _$QuoteRequestDtoImpl.fromJson;

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
  @JsonKey(ignore: true)
  _$$QuoteRequestDtoImplCopyWith<_$QuoteRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JupiterSwapRequestDto _$JupiterSwapRequestDtoFromJson(
    Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JupiterSwapRequestDtoCopyWith<JupiterSwapRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterSwapRequestDtoCopyWith<$Res> {
  factory $JupiterSwapRequestDtoCopyWith(JupiterSwapRequestDto value,
          $Res Function(JupiterSwapRequestDto) then) =
      _$JupiterSwapRequestDtoCopyWithImpl<$Res, JupiterSwapRequestDto>;
  @useResult
  $Res call(
      {String userPublicKey,
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
      bool? skipUserAccountsRpcCalls});

  $QuoteResponseDtoCopyWith<$Res> get quoteResponse;
}

/// @nodoc
class _$JupiterSwapRequestDtoCopyWithImpl<$Res,
        $Val extends JupiterSwapRequestDto>
    implements $JupiterSwapRequestDtoCopyWith<$Res> {
  _$JupiterSwapRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
  }) {
    return _then(_value.copyWith(
      userPublicKey: null == userPublicKey
          ? _value.userPublicKey
          : userPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      quoteResponse: null == quoteResponse
          ? _value.quoteResponse
          : quoteResponse // ignore: cast_nullable_to_non_nullable
              as QuoteResponseDto,
      wrapAndUnwrapSol: freezed == wrapAndUnwrapSol
          ? _value.wrapAndUnwrapSol
          : wrapAndUnwrapSol // ignore: cast_nullable_to_non_nullable
              as bool?,
      useSharedAccounts: freezed == useSharedAccounts
          ? _value.useSharedAccounts
          : useSharedAccounts // ignore: cast_nullable_to_non_nullable
              as bool?,
      feeAccount: freezed == feeAccount
          ? _value.feeAccount
          : feeAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      computeUnitPriceMicroLamports: freezed == computeUnitPriceMicroLamports
          ? _value.computeUnitPriceMicroLamports
          : computeUnitPriceMicroLamports // ignore: cast_nullable_to_non_nullable
              as int?,
      prioritizationFeeLamports: freezed == prioritizationFeeLamports
          ? _value.prioritizationFeeLamports
          : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
              as int?,
      asLegacyTransaction: freezed == asLegacyTransaction
          ? _value.asLegacyTransaction
          : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
              as bool?,
      restrictIntermediateTokens: freezed == restrictIntermediateTokens
          ? _value.restrictIntermediateTokens
          : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
              as bool?,
      useTokenLedger: freezed == useTokenLedger
          ? _value.useTokenLedger
          : useTokenLedger // ignore: cast_nullable_to_non_nullable
              as bool?,
      destinationTokenAccount: freezed == destinationTokenAccount
          ? _value.destinationTokenAccount
          : destinationTokenAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      dynamicComputeUnitLimit: freezed == dynamicComputeUnitLimit
          ? _value.dynamicComputeUnitLimit
          : dynamicComputeUnitLimit // ignore: cast_nullable_to_non_nullable
              as bool?,
      skipUserAccountsRpcCalls: freezed == skipUserAccountsRpcCalls
          ? _value.skipUserAccountsRpcCalls
          : skipUserAccountsRpcCalls // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QuoteResponseDtoCopyWith<$Res> get quoteResponse {
    return $QuoteResponseDtoCopyWith<$Res>(_value.quoteResponse, (value) {
      return _then(_value.copyWith(quoteResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JupiterSwapRequestDtoImplCopyWith<$Res>
    implements $JupiterSwapRequestDtoCopyWith<$Res> {
  factory _$$JupiterSwapRequestDtoImplCopyWith(
          _$JupiterSwapRequestDtoImpl value,
          $Res Function(_$JupiterSwapRequestDtoImpl) then) =
      __$$JupiterSwapRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userPublicKey,
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
      bool? skipUserAccountsRpcCalls});

  @override
  $QuoteResponseDtoCopyWith<$Res> get quoteResponse;
}

/// @nodoc
class __$$JupiterSwapRequestDtoImplCopyWithImpl<$Res>
    extends _$JupiterSwapRequestDtoCopyWithImpl<$Res,
        _$JupiterSwapRequestDtoImpl>
    implements _$$JupiterSwapRequestDtoImplCopyWith<$Res> {
  __$$JupiterSwapRequestDtoImplCopyWithImpl(_$JupiterSwapRequestDtoImpl _value,
      $Res Function(_$JupiterSwapRequestDtoImpl) _then)
      : super(_value, _then);

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
  }) {
    return _then(_$JupiterSwapRequestDtoImpl(
      userPublicKey: null == userPublicKey
          ? _value.userPublicKey
          : userPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      quoteResponse: null == quoteResponse
          ? _value.quoteResponse
          : quoteResponse // ignore: cast_nullable_to_non_nullable
              as QuoteResponseDto,
      wrapAndUnwrapSol: freezed == wrapAndUnwrapSol
          ? _value.wrapAndUnwrapSol
          : wrapAndUnwrapSol // ignore: cast_nullable_to_non_nullable
              as bool?,
      useSharedAccounts: freezed == useSharedAccounts
          ? _value.useSharedAccounts
          : useSharedAccounts // ignore: cast_nullable_to_non_nullable
              as bool?,
      feeAccount: freezed == feeAccount
          ? _value.feeAccount
          : feeAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      computeUnitPriceMicroLamports: freezed == computeUnitPriceMicroLamports
          ? _value.computeUnitPriceMicroLamports
          : computeUnitPriceMicroLamports // ignore: cast_nullable_to_non_nullable
              as int?,
      prioritizationFeeLamports: freezed == prioritizationFeeLamports
          ? _value.prioritizationFeeLamports
          : prioritizationFeeLamports // ignore: cast_nullable_to_non_nullable
              as int?,
      asLegacyTransaction: freezed == asLegacyTransaction
          ? _value.asLegacyTransaction
          : asLegacyTransaction // ignore: cast_nullable_to_non_nullable
              as bool?,
      restrictIntermediateTokens: freezed == restrictIntermediateTokens
          ? _value.restrictIntermediateTokens
          : restrictIntermediateTokens // ignore: cast_nullable_to_non_nullable
              as bool?,
      useTokenLedger: freezed == useTokenLedger
          ? _value.useTokenLedger
          : useTokenLedger // ignore: cast_nullable_to_non_nullable
              as bool?,
      destinationTokenAccount: freezed == destinationTokenAccount
          ? _value.destinationTokenAccount
          : destinationTokenAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      dynamicComputeUnitLimit: freezed == dynamicComputeUnitLimit
          ? _value.dynamicComputeUnitLimit
          : dynamicComputeUnitLimit // ignore: cast_nullable_to_non_nullable
              as bool?,
      skipUserAccountsRpcCalls: freezed == skipUserAccountsRpcCalls
          ? _value.skipUserAccountsRpcCalls
          : skipUserAccountsRpcCalls // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterSwapRequestDtoImpl implements _JupiterSwapRequestDto {
  const _$JupiterSwapRequestDtoImpl(
      {required this.userPublicKey,
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
      this.skipUserAccountsRpcCalls});

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
  String toString() {
    return 'JupiterSwapRequestDto(userPublicKey: $userPublicKey, quoteResponse: $quoteResponse, wrapAndUnwrapSol: $wrapAndUnwrapSol, useSharedAccounts: $useSharedAccounts, feeAccount: $feeAccount, computeUnitPriceMicroLamports: $computeUnitPriceMicroLamports, prioritizationFeeLamports: $prioritizationFeeLamports, asLegacyTransaction: $asLegacyTransaction, restrictIntermediateTokens: $restrictIntermediateTokens, useTokenLedger: $useTokenLedger, destinationTokenAccount: $destinationTokenAccount, dynamicComputeUnitLimit: $dynamicComputeUnitLimit, skipUserAccountsRpcCalls: $skipUserAccountsRpcCalls)';
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
            (identical(other.feeAccount, feeAccount) ||
                other.feeAccount == feeAccount) &&
            (identical(other.computeUnitPriceMicroLamports,
                    computeUnitPriceMicroLamports) ||
                other.computeUnitPriceMicroLamports ==
                    computeUnitPriceMicroLamports) &&
            (identical(other.prioritizationFeeLamports,
                    prioritizationFeeLamports) ||
                other.prioritizationFeeLamports == prioritizationFeeLamports) &&
            (identical(other.asLegacyTransaction, asLegacyTransaction) ||
                other.asLegacyTransaction == asLegacyTransaction) &&
            (identical(other.restrictIntermediateTokens,
                    restrictIntermediateTokens) ||
                other.restrictIntermediateTokens ==
                    restrictIntermediateTokens) &&
            (identical(other.useTokenLedger, useTokenLedger) ||
                other.useTokenLedger == useTokenLedger) &&
            (identical(
                    other.destinationTokenAccount, destinationTokenAccount) ||
                other.destinationTokenAccount == destinationTokenAccount) &&
            (identical(
                    other.dynamicComputeUnitLimit, dynamicComputeUnitLimit) ||
                other.dynamicComputeUnitLimit == dynamicComputeUnitLimit) &&
            (identical(
                    other.skipUserAccountsRpcCalls, skipUserAccountsRpcCalls) ||
                other.skipUserAccountsRpcCalls == skipUserAccountsRpcCalls));
  }

  @JsonKey(ignore: true)
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
      skipUserAccountsRpcCalls);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterSwapRequestDtoImplCopyWith<_$JupiterSwapRequestDtoImpl>
      get copyWith => __$$JupiterSwapRequestDtoImplCopyWithImpl<
          _$JupiterSwapRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterSwapRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _JupiterSwapRequestDto implements JupiterSwapRequestDto {
  const factory _JupiterSwapRequestDto(
      {required final String userPublicKey,
      required final QuoteResponseDto quoteResponse,
      final bool? wrapAndUnwrapSol,
      final bool? useSharedAccounts,
      final String? feeAccount,
      final String? destinationWallet,
      final bool? asLegacyTransaction}) = _$JupiterSwapRequestDtoImpl;

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
  @JsonKey(ignore: true)
  _$$JupiterSwapRequestDtoImplCopyWith<_$JupiterSwapRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

JupiterSwapResponseDto _$JupiterSwapResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _JupiterSwapResponseDto.fromJson(json);
}

/// @nodoc
mixin _$JupiterSwapResponseDto {
  String get swapTransaction => throw _privateConstructorUsedError;
  int get lastValidBlockHeight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JupiterSwapResponseDtoCopyWith<JupiterSwapResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterSwapResponseDtoCopyWith<$Res> {
  factory $JupiterSwapResponseDtoCopyWith(JupiterSwapResponseDto value,
          $Res Function(JupiterSwapResponseDto) then) =
      _$JupiterSwapResponseDtoCopyWithImpl<$Res, JupiterSwapResponseDto>;
  @useResult
  $Res call({String swapTransaction, int lastValidBlockHeight});
}

/// @nodoc
class _$JupiterSwapResponseDtoCopyWithImpl<$Res,
        $Val extends JupiterSwapResponseDto>
    implements $JupiterSwapResponseDtoCopyWith<$Res> {
  _$JupiterSwapResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapTransaction = null,
    Object? lastValidBlockHeight = null,
  }) {
    return _then(_value.copyWith(
      swapTransaction: null == swapTransaction
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
      lastValidBlockHeight: null == lastValidBlockHeight
          ? _value.lastValidBlockHeight
          : lastValidBlockHeight // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JupiterSwapResponseDtoImplCopyWith<$Res>
    implements $JupiterSwapResponseDtoCopyWith<$Res> {
  factory _$$JupiterSwapResponseDtoImplCopyWith(
          _$JupiterSwapResponseDtoImpl value,
          $Res Function(_$JupiterSwapResponseDtoImpl) then) =
      __$$JupiterSwapResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String swapTransaction, int lastValidBlockHeight});
}

/// @nodoc
class __$$JupiterSwapResponseDtoImplCopyWithImpl<$Res>
    extends _$JupiterSwapResponseDtoCopyWithImpl<$Res,
        _$JupiterSwapResponseDtoImpl>
    implements _$$JupiterSwapResponseDtoImplCopyWith<$Res> {
  __$$JupiterSwapResponseDtoImplCopyWithImpl(
      _$JupiterSwapResponseDtoImpl _value,
      $Res Function(_$JupiterSwapResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapTransaction = null,
    Object? lastValidBlockHeight = null,
  }) {
    return _then(_$JupiterSwapResponseDtoImpl(
      swapTransaction: null == swapTransaction
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
      lastValidBlockHeight: null == lastValidBlockHeight
          ? _value.lastValidBlockHeight
          : lastValidBlockHeight // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JupiterSwapResponseDtoImpl implements _JupiterSwapResponseDto {
  const _$JupiterSwapResponseDtoImpl({required this.swapTransaction});

  factory _$JupiterSwapResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$JupiterSwapResponseDtoImplFromJson(json);

  @override
  final String swapTransaction;
  @override
  final int lastValidBlockHeight;

  @override
  String toString() {
    return 'JupiterSwapResponseDto(swapTransaction: $swapTransaction, lastValidBlockHeight: $lastValidBlockHeight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JupiterSwapResponseDtoImpl &&
            (identical(other.swapTransaction, swapTransaction) ||
                other.swapTransaction == swapTransaction) &&
            (identical(other.lastValidBlockHeight, lastValidBlockHeight) ||
                other.lastValidBlockHeight == lastValidBlockHeight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, swapTransaction, lastValidBlockHeight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JupiterSwapResponseDtoImplCopyWith<_$JupiterSwapResponseDtoImpl>
      get copyWith => __$$JupiterSwapResponseDtoImplCopyWithImpl<
          _$JupiterSwapResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JupiterSwapResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _JupiterSwapResponseDto implements JupiterSwapResponseDto {
  const factory _JupiterSwapResponseDto(
      {required final String swapTransaction}) = _$JupiterSwapResponseDtoImpl;

  factory _JupiterSwapResponseDto.fromJson(Map<String, dynamic> json) =
      _$JupiterSwapResponseDtoImpl.fromJson;

  @override
  String get swapTransaction;
  @override
  int get lastValidBlockHeight;
  @override
  @JsonKey(ignore: true)
  _$$JupiterSwapResponseDtoImplCopyWith<_$JupiterSwapResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PriceRequestDto _$PriceRequestDtoFromJson(Map<String, dynamic> json) {
  return _PriceRequestDto.fromJson(json);
}

/// @nodoc
mixin _$PriceRequestDto {
  String get ids => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceRequestDtoCopyWith<PriceRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceRequestDtoCopyWith<$Res> {
  factory $PriceRequestDtoCopyWith(
          PriceRequestDto value, $Res Function(PriceRequestDto) then) =
      _$PriceRequestDtoCopyWithImpl<$Res, PriceRequestDto>;
  @useResult
  $Res call({String ids});
}

/// @nodoc
class _$PriceRequestDtoCopyWithImpl<$Res, $Val extends PriceRequestDto>
    implements $PriceRequestDtoCopyWith<$Res> {
  _$PriceRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
  }) {
    return _then(_value.copyWith(
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceRequestDtoImplCopyWith<$Res>
    implements $PriceRequestDtoCopyWith<$Res> {
  factory _$$PriceRequestDtoImplCopyWith(_$PriceRequestDtoImpl value,
          $Res Function(_$PriceRequestDtoImpl) then) =
      __$$PriceRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String ids});
}

/// @nodoc
class __$$PriceRequestDtoImplCopyWithImpl<$Res>
    extends _$PriceRequestDtoCopyWithImpl<$Res, _$PriceRequestDtoImpl>
    implements _$$PriceRequestDtoImplCopyWith<$Res> {
  __$$PriceRequestDtoImplCopyWithImpl(
      _$PriceRequestDtoImpl _value, $Res Function(_$PriceRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ids = null,
  }) {
    return _then(_$PriceRequestDtoImpl(
      ids: null == ids
          ? _value.ids
          : ids // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceRequestDtoImpl implements _PriceRequestDto {
  const _$PriceRequestDtoImpl({required this.ids});

  factory _$PriceRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceRequestDtoImplFromJson(json);

  @override
  final String ids;

  @override
  String toString() {
    return 'PriceRequestDto(ids: $ids)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceRequestDtoImpl &&
            (identical(other.ids, ids) || other.ids == ids));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ids);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceRequestDtoImplCopyWith<_$PriceRequestDtoImpl> get copyWith =>
      __$$PriceRequestDtoImplCopyWithImpl<_$PriceRequestDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _PriceRequestDto implements PriceRequestDto {
  const factory _PriceRequestDto({required final String ids}) =
      _$PriceRequestDtoImpl;

  factory _PriceRequestDto.fromJson(Map<String, dynamic> json) =
      _$PriceRequestDtoImpl.fromJson;

  @override
  String get ids;
  @override
  @JsonKey(ignore: true)
  _$$PriceRequestDtoImplCopyWith<_$PriceRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceResponseDto _$PriceResponseDtoFromJson(Map<String, dynamic> json) {
  return _PriceResponseDto.fromJson(json);
}

/// @nodoc
mixin _$PriceResponseDto {
  Map<String, PriceDto> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceResponseDtoCopyWith<PriceResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceResponseDtoCopyWith<$Res> {
  factory $PriceResponseDtoCopyWith(
          PriceResponseDto value, $Res Function(PriceResponseDto) then) =
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, PriceDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceResponseDtoImplCopyWith<$Res>
    implements $PriceResponseDtoCopyWith<$Res> {
  factory _$$PriceResponseDtoImplCopyWith(_$PriceResponseDtoImpl value,
          $Res Function(_$PriceResponseDtoImpl) then) =
      __$$PriceResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, PriceDto> data});
}

/// @nodoc
class __$$PriceResponseDtoImplCopyWithImpl<$Res>
    extends _$PriceResponseDtoCopyWithImpl<$Res, _$PriceResponseDtoImpl>
    implements _$$PriceResponseDtoImplCopyWith<$Res> {
  __$$PriceResponseDtoImplCopyWithImpl(_$PriceResponseDtoImpl _value,
      $Res Function(_$PriceResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$PriceResponseDtoImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, PriceDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceResponseDtoImpl implements _PriceResponseDto {
  const _$PriceResponseDtoImpl({required final Map<String, PriceDto> data})
      : _data = data;

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

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceResponseDtoImplCopyWith<_$PriceResponseDtoImpl> get copyWith =>
      __$$PriceResponseDtoImplCopyWithImpl<_$PriceResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _PriceResponseDto implements PriceResponseDto {
  const factory _PriceResponseDto({required final Map<String, PriceDto> data}) =
      _$PriceResponseDtoImpl;

  factory _PriceResponseDto.fromJson(Map<String, dynamic> json) =
      _$PriceResponseDtoImpl.fromJson;

  @override
  Map<String, PriceDto> get data;
  @override
  @JsonKey(ignore: true)
  _$$PriceResponseDtoImplCopyWith<_$PriceResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceDto _$PriceDtoFromJson(Map<String, dynamic> json) {
  return _PriceDto.fromJson(json);
}

/// @nodoc
mixin _$PriceDto {
  double get price => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceDtoCopyWith<PriceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceDtoCopyWith<$Res> {
  factory $PriceDtoCopyWith(PriceDto value, $Res Function(PriceDto) then) =
      _$PriceDtoCopyWithImpl<$Res, PriceDto>;
  @useResult
  $Res call({double price});
}

/// @nodoc
class _$PriceDtoCopyWithImpl<$Res, $Val extends PriceDto>
    implements $PriceDtoCopyWith<$Res> {
  _$PriceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceDtoImplCopyWith<$Res>
    implements $PriceDtoCopyWith<$Res> {
  factory _$$PriceDtoImplCopyWith(
          _$PriceDtoImpl value, $Res Function(_$PriceDtoImpl) then) =
      __$$PriceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double price});
}

/// @nodoc
class __$$PriceDtoImplCopyWithImpl<$Res>
    extends _$PriceDtoCopyWithImpl<$Res, _$PriceDtoImpl>
    implements _$$PriceDtoImplCopyWith<$Res> {
  __$$PriceDtoImplCopyWithImpl(
      _$PriceDtoImpl _value, $Res Function(_$PriceDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? price = null,
  }) {
    return _then(_$PriceDtoImpl(
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceDtoImpl implements _PriceDto {
  const _$PriceDtoImpl({required this.price});

  factory _$PriceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceDtoImplFromJson(json);

  @override
  final double price;

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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceDtoImplCopyWith<_$PriceDtoImpl> get copyWith =>
      __$$PriceDtoImplCopyWithImpl<_$PriceDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceDtoImplToJson(
      this,
    );
  }
}

abstract class _PriceDto implements PriceDto {
  const factory _PriceDto({required final double price}) = _$PriceDtoImpl;

  factory _PriceDto.fromJson(Map<String, dynamic> json) =
      _$PriceDtoImpl.fromJson;

  @override
  double get price;
  @override
  @JsonKey(ignore: true)
  _$$PriceDtoImplCopyWith<_$PriceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
