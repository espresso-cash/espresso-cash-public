// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
abstract class _$$_JupiterIndexedRouteMapCopyWith<$Res>
    implements $JupiterIndexedRouteMapCopyWith<$Res> {
  factory _$$_JupiterIndexedRouteMapCopyWith(_$_JupiterIndexedRouteMap value,
          $Res Function(_$_JupiterIndexedRouteMap) then) =
      __$$_JupiterIndexedRouteMapCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> mintKeys, Map<String, List<int>> indexedRouteMap});
}

/// @nodoc
class __$$_JupiterIndexedRouteMapCopyWithImpl<$Res>
    extends _$JupiterIndexedRouteMapCopyWithImpl<$Res,
        _$_JupiterIndexedRouteMap>
    implements _$$_JupiterIndexedRouteMapCopyWith<$Res> {
  __$$_JupiterIndexedRouteMapCopyWithImpl(_$_JupiterIndexedRouteMap _value,
      $Res Function(_$_JupiterIndexedRouteMap) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mintKeys = null,
    Object? indexedRouteMap = null,
  }) {
    return _then(_$_JupiterIndexedRouteMap(
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
class _$_JupiterIndexedRouteMap implements _JupiterIndexedRouteMap {
  const _$_JupiterIndexedRouteMap(
      {required final List<String> mintKeys,
      required final Map<String, List<int>> indexedRouteMap})
      : _mintKeys = mintKeys,
        _indexedRouteMap = indexedRouteMap;

  factory _$_JupiterIndexedRouteMap.fromJson(Map<String, dynamic> json) =>
      _$$_JupiterIndexedRouteMapFromJson(json);

  final List<String> _mintKeys;
  @override
  List<String> get mintKeys {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mintKeys);
  }

  final Map<String, List<int>> _indexedRouteMap;
  @override
  Map<String, List<int>> get indexedRouteMap {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_indexedRouteMap);
  }

  @override
  String toString() {
    return 'JupiterIndexedRouteMap(mintKeys: $mintKeys, indexedRouteMap: $indexedRouteMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JupiterIndexedRouteMap &&
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
  _$$_JupiterIndexedRouteMapCopyWith<_$_JupiterIndexedRouteMap> get copyWith =>
      __$$_JupiterIndexedRouteMapCopyWithImpl<_$_JupiterIndexedRouteMap>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JupiterIndexedRouteMapToJson(
      this,
    );
  }
}

abstract class _JupiterIndexedRouteMap implements JupiterIndexedRouteMap {
  const factory _JupiterIndexedRouteMap(
          {required final List<String> mintKeys,
          required final Map<String, List<int>> indexedRouteMap}) =
      _$_JupiterIndexedRouteMap;

  factory _JupiterIndexedRouteMap.fromJson(Map<String, dynamic> json) =
      _$_JupiterIndexedRouteMap.fromJson;

  @override
  List<String> get mintKeys;
  @override
  Map<String, List<int>> get indexedRouteMap;
  @override
  @JsonKey(ignore: true)
  _$$_JupiterIndexedRouteMapCopyWith<_$_JupiterIndexedRouteMap> get copyWith =>
      throw _privateConstructorUsedError;
}

JupiterSwapTransactions _$JupiterSwapTransactionsFromJson(
    Map<String, dynamic> json) {
  return _JupiterSwapTransactions.fromJson(json);
}

/// @nodoc
mixin _$JupiterSwapTransactions {
  String? get setupTransaction => throw _privateConstructorUsedError;
  String get swapTransaction => throw _privateConstructorUsedError;
  String? get cleanupTransaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JupiterSwapTransactionsCopyWith<JupiterSwapTransactions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterSwapTransactionsCopyWith<$Res> {
  factory $JupiterSwapTransactionsCopyWith(JupiterSwapTransactions value,
          $Res Function(JupiterSwapTransactions) then) =
      _$JupiterSwapTransactionsCopyWithImpl<$Res, JupiterSwapTransactions>;
  @useResult
  $Res call(
      {String? setupTransaction,
      String swapTransaction,
      String? cleanupTransaction});
}

/// @nodoc
class _$JupiterSwapTransactionsCopyWithImpl<$Res,
        $Val extends JupiterSwapTransactions>
    implements $JupiterSwapTransactionsCopyWith<$Res> {
  _$JupiterSwapTransactionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setupTransaction = freezed,
    Object? swapTransaction = null,
    Object? cleanupTransaction = freezed,
  }) {
    return _then(_value.copyWith(
      setupTransaction: freezed == setupTransaction
          ? _value.setupTransaction
          : setupTransaction // ignore: cast_nullable_to_non_nullable
              as String?,
      swapTransaction: null == swapTransaction
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
      cleanupTransaction: freezed == cleanupTransaction
          ? _value.cleanupTransaction
          : cleanupTransaction // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JupiterSwapTransactionsCopyWith<$Res>
    implements $JupiterSwapTransactionsCopyWith<$Res> {
  factory _$$_JupiterSwapTransactionsCopyWith(_$_JupiterSwapTransactions value,
          $Res Function(_$_JupiterSwapTransactions) then) =
      __$$_JupiterSwapTransactionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? setupTransaction,
      String swapTransaction,
      String? cleanupTransaction});
}

/// @nodoc
class __$$_JupiterSwapTransactionsCopyWithImpl<$Res>
    extends _$JupiterSwapTransactionsCopyWithImpl<$Res,
        _$_JupiterSwapTransactions>
    implements _$$_JupiterSwapTransactionsCopyWith<$Res> {
  __$$_JupiterSwapTransactionsCopyWithImpl(_$_JupiterSwapTransactions _value,
      $Res Function(_$_JupiterSwapTransactions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setupTransaction = freezed,
    Object? swapTransaction = null,
    Object? cleanupTransaction = freezed,
  }) {
    return _then(_$_JupiterSwapTransactions(
      setupTransaction: freezed == setupTransaction
          ? _value.setupTransaction
          : setupTransaction // ignore: cast_nullable_to_non_nullable
              as String?,
      swapTransaction: null == swapTransaction
          ? _value.swapTransaction
          : swapTransaction // ignore: cast_nullable_to_non_nullable
              as String,
      cleanupTransaction: freezed == cleanupTransaction
          ? _value.cleanupTransaction
          : cleanupTransaction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JupiterSwapTransactions implements _JupiterSwapTransactions {
  const _$_JupiterSwapTransactions(
      {required this.setupTransaction,
      required this.swapTransaction,
      required this.cleanupTransaction});

  factory _$_JupiterSwapTransactions.fromJson(Map<String, dynamic> json) =>
      _$$_JupiterSwapTransactionsFromJson(json);

  @override
  final String? setupTransaction;
  @override
  final String swapTransaction;
  @override
  final String? cleanupTransaction;

  @override
  String toString() {
    return 'JupiterSwapTransactions(setupTransaction: $setupTransaction, swapTransaction: $swapTransaction, cleanupTransaction: $cleanupTransaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JupiterSwapTransactions &&
            (identical(other.setupTransaction, setupTransaction) ||
                other.setupTransaction == setupTransaction) &&
            (identical(other.swapTransaction, swapTransaction) ||
                other.swapTransaction == swapTransaction) &&
            (identical(other.cleanupTransaction, cleanupTransaction) ||
                other.cleanupTransaction == cleanupTransaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, setupTransaction, swapTransaction, cleanupTransaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JupiterSwapTransactionsCopyWith<_$_JupiterSwapTransactions>
      get copyWith =>
          __$$_JupiterSwapTransactionsCopyWithImpl<_$_JupiterSwapTransactions>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JupiterSwapTransactionsToJson(
      this,
    );
  }
}

abstract class _JupiterSwapTransactions implements JupiterSwapTransactions {
  const factory _JupiterSwapTransactions(
      {required final String? setupTransaction,
      required final String swapTransaction,
      required final String? cleanupTransaction}) = _$_JupiterSwapTransactions;

  factory _JupiterSwapTransactions.fromJson(Map<String, dynamic> json) =
      _$_JupiterSwapTransactions.fromJson;

  @override
  String? get setupTransaction;
  @override
  String get swapTransaction;
  @override
  String? get cleanupTransaction;
  @override
  @JsonKey(ignore: true)
  _$$_JupiterSwapTransactionsCopyWith<_$_JupiterSwapTransactions>
      get copyWith => throw _privateConstructorUsedError;
}

JupiterRoute _$JupiterRouteFromJson(Map<String, dynamic> json) {
  return _JupiterRoute.fromJson(json);
}

/// @nodoc
mixin _$JupiterRoute {
  int get inAmount => throw _privateConstructorUsedError;
  int get outAmount => throw _privateConstructorUsedError;
  int get otherAmountThreshold => throw _privateConstructorUsedError;
  double? get priceImpactPct => throw _privateConstructorUsedError;
  List<JupiterMarket> get marketInfos => throw _privateConstructorUsedError;
  SwapMode get swapMode => throw _privateConstructorUsedError;

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
      {int inAmount,
      int outAmount,
      int otherAmountThreshold,
      double? priceImpactPct,
      List<JupiterMarket> marketInfos,
      SwapMode swapMode});
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
    Object? otherAmountThreshold = null,
    Object? priceImpactPct = freezed,
    Object? marketInfos = null,
    Object? swapMode = null,
  }) {
    return _then(_value.copyWith(
      inAmount: null == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as int,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as int,
      otherAmountThreshold: null == otherAmountThreshold
          ? _value.otherAmountThreshold
          : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      priceImpactPct: freezed == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as double?,
      marketInfos: null == marketInfos
          ? _value.marketInfos
          : marketInfos // ignore: cast_nullable_to_non_nullable
              as List<JupiterMarket>,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JupiterRouteCopyWith<$Res>
    implements $JupiterRouteCopyWith<$Res> {
  factory _$$_JupiterRouteCopyWith(
          _$_JupiterRoute value, $Res Function(_$_JupiterRoute) then) =
      __$$_JupiterRouteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int inAmount,
      int outAmount,
      int otherAmountThreshold,
      double? priceImpactPct,
      List<JupiterMarket> marketInfos,
      SwapMode swapMode});
}

/// @nodoc
class __$$_JupiterRouteCopyWithImpl<$Res>
    extends _$JupiterRouteCopyWithImpl<$Res, _$_JupiterRoute>
    implements _$$_JupiterRouteCopyWith<$Res> {
  __$$_JupiterRouteCopyWithImpl(
      _$_JupiterRoute _value, $Res Function(_$_JupiterRoute) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inAmount = null,
    Object? outAmount = null,
    Object? otherAmountThreshold = null,
    Object? priceImpactPct = freezed,
    Object? marketInfos = null,
    Object? swapMode = null,
  }) {
    return _then(_$_JupiterRoute(
      inAmount: null == inAmount
          ? _value.inAmount
          : inAmount // ignore: cast_nullable_to_non_nullable
              as int,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as int,
      otherAmountThreshold: null == otherAmountThreshold
          ? _value.otherAmountThreshold
          : otherAmountThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      priceImpactPct: freezed == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as double?,
      marketInfos: null == marketInfos
          ? _value._marketInfos
          : marketInfos // ignore: cast_nullable_to_non_nullable
              as List<JupiterMarket>,
      swapMode: null == swapMode
          ? _value.swapMode
          : swapMode // ignore: cast_nullable_to_non_nullable
              as SwapMode,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JupiterRoute implements _JupiterRoute {
  const _$_JupiterRoute(
      {required this.inAmount,
      required this.outAmount,
      required this.otherAmountThreshold,
      required this.priceImpactPct,
      required final List<JupiterMarket> marketInfos,
      required this.swapMode})
      : _marketInfos = marketInfos;

  factory _$_JupiterRoute.fromJson(Map<String, dynamic> json) =>
      _$$_JupiterRouteFromJson(json);

  @override
  final int inAmount;
  @override
  final int outAmount;
  @override
  final int otherAmountThreshold;
  @override
  final double? priceImpactPct;
  final List<JupiterMarket> _marketInfos;
  @override
  List<JupiterMarket> get marketInfos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_marketInfos);
  }

  @override
  final SwapMode swapMode;

  @override
  String toString() {
    return 'JupiterRoute(inAmount: $inAmount, outAmount: $outAmount, otherAmountThreshold: $otherAmountThreshold, priceImpactPct: $priceImpactPct, marketInfos: $marketInfos, swapMode: $swapMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JupiterRoute &&
            (identical(other.inAmount, inAmount) ||
                other.inAmount == inAmount) &&
            (identical(other.outAmount, outAmount) ||
                other.outAmount == outAmount) &&
            (identical(other.otherAmountThreshold, otherAmountThreshold) ||
                other.otherAmountThreshold == otherAmountThreshold) &&
            (identical(other.priceImpactPct, priceImpactPct) ||
                other.priceImpactPct == priceImpactPct) &&
            const DeepCollectionEquality()
                .equals(other._marketInfos, _marketInfos) &&
            (identical(other.swapMode, swapMode) ||
                other.swapMode == swapMode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      inAmount,
      outAmount,
      otherAmountThreshold,
      priceImpactPct,
      const DeepCollectionEquality().hash(_marketInfos),
      swapMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JupiterRouteCopyWith<_$_JupiterRoute> get copyWith =>
      __$$_JupiterRouteCopyWithImpl<_$_JupiterRoute>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JupiterRouteToJson(
      this,
    );
  }
}

abstract class _JupiterRoute implements JupiterRoute {
  const factory _JupiterRoute(
      {required final int inAmount,
      required final int outAmount,
      required final int otherAmountThreshold,
      required final double? priceImpactPct,
      required final List<JupiterMarket> marketInfos,
      required final SwapMode swapMode}) = _$_JupiterRoute;

  factory _JupiterRoute.fromJson(Map<String, dynamic> json) =
      _$_JupiterRoute.fromJson;

  @override
  int get inAmount;
  @override
  int get outAmount;
  @override
  int get otherAmountThreshold;
  @override
  double? get priceImpactPct;
  @override
  List<JupiterMarket> get marketInfos;
  @override
  SwapMode get swapMode;
  @override
  @JsonKey(ignore: true)
  _$$_JupiterRouteCopyWith<_$_JupiterRoute> get copyWith =>
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
  int get inAmount => throw _privateConstructorUsedError;
  int get outAmount => throw _privateConstructorUsedError;
  double? get priceImpactPct => throw _privateConstructorUsedError;
  JupiterFee get lpFee => throw _privateConstructorUsedError;
  JupiterFee get platformFee => throw _privateConstructorUsedError;

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
      int inAmount,
      int outAmount,
      double? priceImpactPct,
      JupiterFee lpFee,
      JupiterFee platformFee});

  $JupiterFeeCopyWith<$Res> get lpFee;
  $JupiterFeeCopyWith<$Res> get platformFee;
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
    Object? priceImpactPct = freezed,
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
              as int,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as int,
      priceImpactPct: freezed == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as double?,
      lpFee: null == lpFee
          ? _value.lpFee
          : lpFee // ignore: cast_nullable_to_non_nullable
              as JupiterFee,
      platformFee: null == platformFee
          ? _value.platformFee
          : platformFee // ignore: cast_nullable_to_non_nullable
              as JupiterFee,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JupiterFeeCopyWith<$Res> get lpFee {
    return $JupiterFeeCopyWith<$Res>(_value.lpFee, (value) {
      return _then(_value.copyWith(lpFee: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $JupiterFeeCopyWith<$Res> get platformFee {
    return $JupiterFeeCopyWith<$Res>(_value.platformFee, (value) {
      return _then(_value.copyWith(platformFee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_JupiterMarketCopyWith<$Res>
    implements $JupiterMarketCopyWith<$Res> {
  factory _$$_JupiterMarketCopyWith(
          _$_JupiterMarket value, $Res Function(_$_JupiterMarket) then) =
      __$$_JupiterMarketCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      String inputMint,
      String outputMint,
      bool notEnoughLiquidity,
      int inAmount,
      int outAmount,
      double? priceImpactPct,
      JupiterFee lpFee,
      JupiterFee platformFee});

  @override
  $JupiterFeeCopyWith<$Res> get lpFee;
  @override
  $JupiterFeeCopyWith<$Res> get platformFee;
}

/// @nodoc
class __$$_JupiterMarketCopyWithImpl<$Res>
    extends _$JupiterMarketCopyWithImpl<$Res, _$_JupiterMarket>
    implements _$$_JupiterMarketCopyWith<$Res> {
  __$$_JupiterMarketCopyWithImpl(
      _$_JupiterMarket _value, $Res Function(_$_JupiterMarket) _then)
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
    Object? priceImpactPct = freezed,
    Object? lpFee = null,
    Object? platformFee = null,
  }) {
    return _then(_$_JupiterMarket(
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
              as int,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as int,
      priceImpactPct: freezed == priceImpactPct
          ? _value.priceImpactPct
          : priceImpactPct // ignore: cast_nullable_to_non_nullable
              as double?,
      lpFee: null == lpFee
          ? _value.lpFee
          : lpFee // ignore: cast_nullable_to_non_nullable
              as JupiterFee,
      platformFee: null == platformFee
          ? _value.platformFee
          : platformFee // ignore: cast_nullable_to_non_nullable
              as JupiterFee,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JupiterMarket implements _JupiterMarket {
  const _$_JupiterMarket(
      {required this.id,
      required this.label,
      required this.inputMint,
      required this.outputMint,
      required this.notEnoughLiquidity,
      required this.inAmount,
      required this.outAmount,
      required this.priceImpactPct,
      required this.lpFee,
      required this.platformFee});

  factory _$_JupiterMarket.fromJson(Map<String, dynamic> json) =>
      _$$_JupiterMarketFromJson(json);

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
  final int inAmount;
  @override
  final int outAmount;
  @override
  final double? priceImpactPct;
  @override
  final JupiterFee lpFee;
  @override
  final JupiterFee platformFee;

  @override
  String toString() {
    return 'JupiterMarket(id: $id, label: $label, inputMint: $inputMint, outputMint: $outputMint, notEnoughLiquidity: $notEnoughLiquidity, inAmount: $inAmount, outAmount: $outAmount, priceImpactPct: $priceImpactPct, lpFee: $lpFee, platformFee: $platformFee)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JupiterMarket &&
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
      lpFee,
      platformFee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JupiterMarketCopyWith<_$_JupiterMarket> get copyWith =>
      __$$_JupiterMarketCopyWithImpl<_$_JupiterMarket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JupiterMarketToJson(
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
      required final int inAmount,
      required final int outAmount,
      required final double? priceImpactPct,
      required final JupiterFee lpFee,
      required final JupiterFee platformFee}) = _$_JupiterMarket;

  factory _JupiterMarket.fromJson(Map<String, dynamic> json) =
      _$_JupiterMarket.fromJson;

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
  int get inAmount;
  @override
  int get outAmount;
  @override
  double? get priceImpactPct;
  @override
  JupiterFee get lpFee;
  @override
  JupiterFee get platformFee;
  @override
  @JsonKey(ignore: true)
  _$$_JupiterMarketCopyWith<_$_JupiterMarket> get copyWith =>
      throw _privateConstructorUsedError;
}

JupiterFee _$JupiterFeeFromJson(Map<String, dynamic> json) {
  return _JupiterFee.fromJson(json);
}

/// @nodoc
mixin _$JupiterFee {
  double get amount => throw _privateConstructorUsedError;
  String get mint => throw _privateConstructorUsedError;
  double? get pct => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JupiterFeeCopyWith<JupiterFee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JupiterFeeCopyWith<$Res> {
  factory $JupiterFeeCopyWith(
          JupiterFee value, $Res Function(JupiterFee) then) =
      _$JupiterFeeCopyWithImpl<$Res, JupiterFee>;
  @useResult
  $Res call({double amount, String mint, double? pct});
}

/// @nodoc
class _$JupiterFeeCopyWithImpl<$Res, $Val extends JupiterFee>
    implements $JupiterFeeCopyWith<$Res> {
  _$JupiterFeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? mint = null,
    Object? pct = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      mint: null == mint
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as String,
      pct: freezed == pct
          ? _value.pct
          : pct // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JupiterFeeCopyWith<$Res>
    implements $JupiterFeeCopyWith<$Res> {
  factory _$$_JupiterFeeCopyWith(
          _$_JupiterFee value, $Res Function(_$_JupiterFee) then) =
      __$$_JupiterFeeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double amount, String mint, double? pct});
}

/// @nodoc
class __$$_JupiterFeeCopyWithImpl<$Res>
    extends _$JupiterFeeCopyWithImpl<$Res, _$_JupiterFee>
    implements _$$_JupiterFeeCopyWith<$Res> {
  __$$_JupiterFeeCopyWithImpl(
      _$_JupiterFee _value, $Res Function(_$_JupiterFee) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? mint = null,
    Object? pct = freezed,
  }) {
    return _then(_$_JupiterFee(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      mint: null == mint
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as String,
      pct: freezed == pct
          ? _value.pct
          : pct // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JupiterFee implements _JupiterFee {
  const _$_JupiterFee(
      {required this.amount, required this.mint, required this.pct});

  factory _$_JupiterFee.fromJson(Map<String, dynamic> json) =>
      _$$_JupiterFeeFromJson(json);

  @override
  final double amount;
  @override
  final String mint;
  @override
  final double? pct;

  @override
  String toString() {
    return 'JupiterFee(amount: $amount, mint: $mint, pct: $pct)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JupiterFee &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.mint, mint) || other.mint == mint) &&
            (identical(other.pct, pct) || other.pct == pct));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, mint, pct);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JupiterFeeCopyWith<_$_JupiterFee> get copyWith =>
      __$$_JupiterFeeCopyWithImpl<_$_JupiterFee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JupiterFeeToJson(
      this,
    );
  }
}

abstract class _JupiterFee implements JupiterFee {
  const factory _JupiterFee(
      {required final double amount,
      required final String mint,
      required final double? pct}) = _$_JupiterFee;

  factory _JupiterFee.fromJson(Map<String, dynamic> json) =
      _$_JupiterFee.fromJson;

  @override
  double get amount;
  @override
  String get mint;
  @override
  double? get pct;
  @override
  @JsonKey(ignore: true)
  _$$_JupiterFeeCopyWith<_$_JupiterFee> get copyWith =>
      throw _privateConstructorUsedError;
}
