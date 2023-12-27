// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderEstimation _$OrderEstimationFromJson(Map<String, dynamic> json) {
  return _OrderEstimation.fromJson(json);
}

/// @nodoc
mixin _$OrderEstimation {
  TokenWithApproximateOperatingExpense get srcChainTokenIn =>
      throw _privateConstructorUsedError;
  TokenWithMaxRefundAmount? get srcChainTokenOut =>
      throw _privateConstructorUsedError;
  DstChainTokenOutResponseType get dstChainTokenOut =>
      throw _privateConstructorUsedError;
  double? get recommendedSlippage => throw _privateConstructorUsedError;
  List<dynamic> get costsDetails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderEstimationCopyWith<OrderEstimation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEstimationCopyWith<$Res> {
  factory $OrderEstimationCopyWith(
          OrderEstimation value, $Res Function(OrderEstimation) then) =
      _$OrderEstimationCopyWithImpl<$Res, OrderEstimation>;
  @useResult
  $Res call(
      {TokenWithApproximateOperatingExpense srcChainTokenIn,
      TokenWithMaxRefundAmount? srcChainTokenOut,
      DstChainTokenOutResponseType dstChainTokenOut,
      double? recommendedSlippage,
      List<dynamic> costsDetails});

  $TokenWithApproximateOperatingExpenseCopyWith<$Res> get srcChainTokenIn;
  $TokenWithMaxRefundAmountCopyWith<$Res>? get srcChainTokenOut;
  $DstChainTokenOutResponseTypeCopyWith<$Res> get dstChainTokenOut;
}

/// @nodoc
class _$OrderEstimationCopyWithImpl<$Res, $Val extends OrderEstimation>
    implements $OrderEstimationCopyWith<$Res> {
  _$OrderEstimationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcChainTokenIn = null,
    Object? srcChainTokenOut = freezed,
    Object? dstChainTokenOut = null,
    Object? recommendedSlippage = freezed,
    Object? costsDetails = null,
  }) {
    return _then(_value.copyWith(
      srcChainTokenIn: null == srcChainTokenIn
          ? _value.srcChainTokenIn
          : srcChainTokenIn // ignore: cast_nullable_to_non_nullable
              as TokenWithApproximateOperatingExpense,
      srcChainTokenOut: freezed == srcChainTokenOut
          ? _value.srcChainTokenOut
          : srcChainTokenOut // ignore: cast_nullable_to_non_nullable
              as TokenWithMaxRefundAmount?,
      dstChainTokenOut: null == dstChainTokenOut
          ? _value.dstChainTokenOut
          : dstChainTokenOut // ignore: cast_nullable_to_non_nullable
              as DstChainTokenOutResponseType,
      recommendedSlippage: freezed == recommendedSlippage
          ? _value.recommendedSlippage
          : recommendedSlippage // ignore: cast_nullable_to_non_nullable
              as double?,
      costsDetails: null == costsDetails
          ? _value.costsDetails
          : costsDetails // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenWithApproximateOperatingExpenseCopyWith<$Res> get srcChainTokenIn {
    return $TokenWithApproximateOperatingExpenseCopyWith<$Res>(
        _value.srcChainTokenIn, (value) {
      return _then(_value.copyWith(srcChainTokenIn: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenWithMaxRefundAmountCopyWith<$Res>? get srcChainTokenOut {
    if (_value.srcChainTokenOut == null) {
      return null;
    }

    return $TokenWithMaxRefundAmountCopyWith<$Res>(_value.srcChainTokenOut!,
        (value) {
      return _then(_value.copyWith(srcChainTokenOut: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DstChainTokenOutResponseTypeCopyWith<$Res> get dstChainTokenOut {
    return $DstChainTokenOutResponseTypeCopyWith<$Res>(_value.dstChainTokenOut,
        (value) {
      return _then(_value.copyWith(dstChainTokenOut: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderEstimationImplCopyWith<$Res>
    implements $OrderEstimationCopyWith<$Res> {
  factory _$$OrderEstimationImplCopyWith(_$OrderEstimationImpl value,
          $Res Function(_$OrderEstimationImpl) then) =
      __$$OrderEstimationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TokenWithApproximateOperatingExpense srcChainTokenIn,
      TokenWithMaxRefundAmount? srcChainTokenOut,
      DstChainTokenOutResponseType dstChainTokenOut,
      double? recommendedSlippage,
      List<dynamic> costsDetails});

  @override
  $TokenWithApproximateOperatingExpenseCopyWith<$Res> get srcChainTokenIn;
  @override
  $TokenWithMaxRefundAmountCopyWith<$Res>? get srcChainTokenOut;
  @override
  $DstChainTokenOutResponseTypeCopyWith<$Res> get dstChainTokenOut;
}

/// @nodoc
class __$$OrderEstimationImplCopyWithImpl<$Res>
    extends _$OrderEstimationCopyWithImpl<$Res, _$OrderEstimationImpl>
    implements _$$OrderEstimationImplCopyWith<$Res> {
  __$$OrderEstimationImplCopyWithImpl(
      _$OrderEstimationImpl _value, $Res Function(_$OrderEstimationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? srcChainTokenIn = null,
    Object? srcChainTokenOut = freezed,
    Object? dstChainTokenOut = null,
    Object? recommendedSlippage = freezed,
    Object? costsDetails = null,
  }) {
    return _then(_$OrderEstimationImpl(
      srcChainTokenIn: null == srcChainTokenIn
          ? _value.srcChainTokenIn
          : srcChainTokenIn // ignore: cast_nullable_to_non_nullable
              as TokenWithApproximateOperatingExpense,
      srcChainTokenOut: freezed == srcChainTokenOut
          ? _value.srcChainTokenOut
          : srcChainTokenOut // ignore: cast_nullable_to_non_nullable
              as TokenWithMaxRefundAmount?,
      dstChainTokenOut: null == dstChainTokenOut
          ? _value.dstChainTokenOut
          : dstChainTokenOut // ignore: cast_nullable_to_non_nullable
              as DstChainTokenOutResponseType,
      recommendedSlippage: freezed == recommendedSlippage
          ? _value.recommendedSlippage
          : recommendedSlippage // ignore: cast_nullable_to_non_nullable
              as double?,
      costsDetails: null == costsDetails
          ? _value._costsDetails
          : costsDetails // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderEstimationImpl implements _OrderEstimation {
  const _$OrderEstimationImpl(
      {required this.srcChainTokenIn,
      this.srcChainTokenOut,
      required this.dstChainTokenOut,
      this.recommendedSlippage,
      required final List<dynamic> costsDetails})
      : _costsDetails = costsDetails;

  factory _$OrderEstimationImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderEstimationImplFromJson(json);

  @override
  final TokenWithApproximateOperatingExpense srcChainTokenIn;
  @override
  final TokenWithMaxRefundAmount? srcChainTokenOut;
  @override
  final DstChainTokenOutResponseType dstChainTokenOut;
  @override
  final double? recommendedSlippage;
  final List<dynamic> _costsDetails;
  @override
  List<dynamic> get costsDetails {
    if (_costsDetails is EqualUnmodifiableListView) return _costsDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_costsDetails);
  }

  @override
  String toString() {
    return 'OrderEstimation(srcChainTokenIn: $srcChainTokenIn, srcChainTokenOut: $srcChainTokenOut, dstChainTokenOut: $dstChainTokenOut, recommendedSlippage: $recommendedSlippage, costsDetails: $costsDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderEstimationImpl &&
            (identical(other.srcChainTokenIn, srcChainTokenIn) ||
                other.srcChainTokenIn == srcChainTokenIn) &&
            (identical(other.srcChainTokenOut, srcChainTokenOut) ||
                other.srcChainTokenOut == srcChainTokenOut) &&
            (identical(other.dstChainTokenOut, dstChainTokenOut) ||
                other.dstChainTokenOut == dstChainTokenOut) &&
            (identical(other.recommendedSlippage, recommendedSlippage) ||
                other.recommendedSlippage == recommendedSlippage) &&
            const DeepCollectionEquality()
                .equals(other._costsDetails, _costsDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      srcChainTokenIn,
      srcChainTokenOut,
      dstChainTokenOut,
      recommendedSlippage,
      const DeepCollectionEquality().hash(_costsDetails));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderEstimationImplCopyWith<_$OrderEstimationImpl> get copyWith =>
      __$$OrderEstimationImplCopyWithImpl<_$OrderEstimationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderEstimationImplToJson(
      this,
    );
  }
}

abstract class _OrderEstimation implements OrderEstimation {
  const factory _OrderEstimation(
      {required final TokenWithApproximateOperatingExpense srcChainTokenIn,
      final TokenWithMaxRefundAmount? srcChainTokenOut,
      required final DstChainTokenOutResponseType dstChainTokenOut,
      final double? recommendedSlippage,
      required final List<dynamic> costsDetails}) = _$OrderEstimationImpl;

  factory _OrderEstimation.fromJson(Map<String, dynamic> json) =
      _$OrderEstimationImpl.fromJson;

  @override
  TokenWithApproximateOperatingExpense get srcChainTokenIn;
  @override
  TokenWithMaxRefundAmount? get srcChainTokenOut;
  @override
  DstChainTokenOutResponseType get dstChainTokenOut;
  @override
  double? get recommendedSlippage;
  @override
  List<dynamic> get costsDetails;
  @override
  @JsonKey(ignore: true)
  _$$OrderEstimationImplCopyWith<_$OrderEstimationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenWithMaxRefundAmount _$TokenWithMaxRefundAmountFromJson(
    Map<String, dynamic> json) {
  return _TokenWithMaxRefundAmount.fromJson(json);
}

/// @nodoc
mixin _$TokenWithMaxRefundAmount {
  String get address => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get maxRefundAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenWithMaxRefundAmountCopyWith<TokenWithMaxRefundAmount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenWithMaxRefundAmountCopyWith<$Res> {
  factory $TokenWithMaxRefundAmountCopyWith(TokenWithMaxRefundAmount value,
          $Res Function(TokenWithMaxRefundAmount) then) =
      _$TokenWithMaxRefundAmountCopyWithImpl<$Res, TokenWithMaxRefundAmount>;
  @useResult
  $Res call(
      {String address,
      String name,
      String symbol,
      int decimals,
      String amount,
      String maxRefundAmount});
}

/// @nodoc
class _$TokenWithMaxRefundAmountCopyWithImpl<$Res,
        $Val extends TokenWithMaxRefundAmount>
    implements $TokenWithMaxRefundAmountCopyWith<$Res> {
  _$TokenWithMaxRefundAmountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? amount = null,
    Object? maxRefundAmount = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      maxRefundAmount: null == maxRefundAmount
          ? _value.maxRefundAmount
          : maxRefundAmount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenWithMaxRefundAmountImplCopyWith<$Res>
    implements $TokenWithMaxRefundAmountCopyWith<$Res> {
  factory _$$TokenWithMaxRefundAmountImplCopyWith(
          _$TokenWithMaxRefundAmountImpl value,
          $Res Function(_$TokenWithMaxRefundAmountImpl) then) =
      __$$TokenWithMaxRefundAmountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String name,
      String symbol,
      int decimals,
      String amount,
      String maxRefundAmount});
}

/// @nodoc
class __$$TokenWithMaxRefundAmountImplCopyWithImpl<$Res>
    extends _$TokenWithMaxRefundAmountCopyWithImpl<$Res,
        _$TokenWithMaxRefundAmountImpl>
    implements _$$TokenWithMaxRefundAmountImplCopyWith<$Res> {
  __$$TokenWithMaxRefundAmountImplCopyWithImpl(
      _$TokenWithMaxRefundAmountImpl _value,
      $Res Function(_$TokenWithMaxRefundAmountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? amount = null,
    Object? maxRefundAmount = null,
  }) {
    return _then(_$TokenWithMaxRefundAmountImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      maxRefundAmount: null == maxRefundAmount
          ? _value.maxRefundAmount
          : maxRefundAmount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenWithMaxRefundAmountImpl implements _TokenWithMaxRefundAmount {
  const _$TokenWithMaxRefundAmountImpl(
      {required this.address,
      required this.name,
      required this.symbol,
      required this.decimals,
      required this.amount,
      required this.maxRefundAmount});

  factory _$TokenWithMaxRefundAmountImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenWithMaxRefundAmountImplFromJson(json);

  @override
  final String address;
  @override
  final String name;
  @override
  final String symbol;
  @override
  final int decimals;
  @override
  final String amount;
  @override
  final String maxRefundAmount;

  @override
  String toString() {
    return 'TokenWithMaxRefundAmount(address: $address, name: $name, symbol: $symbol, decimals: $decimals, amount: $amount, maxRefundAmount: $maxRefundAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenWithMaxRefundAmountImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.maxRefundAmount, maxRefundAmount) ||
                other.maxRefundAmount == maxRefundAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, address, name, symbol, decimals, amount, maxRefundAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenWithMaxRefundAmountImplCopyWith<_$TokenWithMaxRefundAmountImpl>
      get copyWith => __$$TokenWithMaxRefundAmountImplCopyWithImpl<
          _$TokenWithMaxRefundAmountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenWithMaxRefundAmountImplToJson(
      this,
    );
  }
}

abstract class _TokenWithMaxRefundAmount implements TokenWithMaxRefundAmount {
  const factory _TokenWithMaxRefundAmount(
      {required final String address,
      required final String name,
      required final String symbol,
      required final int decimals,
      required final String amount,
      required final String maxRefundAmount}) = _$TokenWithMaxRefundAmountImpl;

  factory _TokenWithMaxRefundAmount.fromJson(Map<String, dynamic> json) =
      _$TokenWithMaxRefundAmountImpl.fromJson;

  @override
  String get address;
  @override
  String get name;
  @override
  String get symbol;
  @override
  int get decimals;
  @override
  String get amount;
  @override
  String get maxRefundAmount;
  @override
  @JsonKey(ignore: true)
  _$$TokenWithMaxRefundAmountImplCopyWith<_$TokenWithMaxRefundAmountImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TokenWithApproximateOperatingExpense
    _$TokenWithApproximateOperatingExpenseFromJson(Map<String, dynamic> json) {
  return _TokenWithApproximateOperatingExpense.fromJson(json);
}

/// @nodoc
mixin _$TokenWithApproximateOperatingExpense {
  String get address => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get approximateOperatingExpense => throw _privateConstructorUsedError;
  bool get mutatedWithOperatingExpense => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenWithApproximateOperatingExpenseCopyWith<
          TokenWithApproximateOperatingExpense>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenWithApproximateOperatingExpenseCopyWith<$Res> {
  factory $TokenWithApproximateOperatingExpenseCopyWith(
          TokenWithApproximateOperatingExpense value,
          $Res Function(TokenWithApproximateOperatingExpense) then) =
      _$TokenWithApproximateOperatingExpenseCopyWithImpl<$Res,
          TokenWithApproximateOperatingExpense>;
  @useResult
  $Res call(
      {String address,
      String name,
      String symbol,
      int decimals,
      String amount,
      String approximateOperatingExpense,
      bool mutatedWithOperatingExpense});
}

/// @nodoc
class _$TokenWithApproximateOperatingExpenseCopyWithImpl<$Res,
        $Val extends TokenWithApproximateOperatingExpense>
    implements $TokenWithApproximateOperatingExpenseCopyWith<$Res> {
  _$TokenWithApproximateOperatingExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? amount = null,
    Object? approximateOperatingExpense = null,
    Object? mutatedWithOperatingExpense = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      approximateOperatingExpense: null == approximateOperatingExpense
          ? _value.approximateOperatingExpense
          : approximateOperatingExpense // ignore: cast_nullable_to_non_nullable
              as String,
      mutatedWithOperatingExpense: null == mutatedWithOperatingExpense
          ? _value.mutatedWithOperatingExpense
          : mutatedWithOperatingExpense // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenWithApproximateOperatingExpenseImplCopyWith<$Res>
    implements $TokenWithApproximateOperatingExpenseCopyWith<$Res> {
  factory _$$TokenWithApproximateOperatingExpenseImplCopyWith(
          _$TokenWithApproximateOperatingExpenseImpl value,
          $Res Function(_$TokenWithApproximateOperatingExpenseImpl) then) =
      __$$TokenWithApproximateOperatingExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String name,
      String symbol,
      int decimals,
      String amount,
      String approximateOperatingExpense,
      bool mutatedWithOperatingExpense});
}

/// @nodoc
class __$$TokenWithApproximateOperatingExpenseImplCopyWithImpl<$Res>
    extends _$TokenWithApproximateOperatingExpenseCopyWithImpl<$Res,
        _$TokenWithApproximateOperatingExpenseImpl>
    implements _$$TokenWithApproximateOperatingExpenseImplCopyWith<$Res> {
  __$$TokenWithApproximateOperatingExpenseImplCopyWithImpl(
      _$TokenWithApproximateOperatingExpenseImpl _value,
      $Res Function(_$TokenWithApproximateOperatingExpenseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? amount = null,
    Object? approximateOperatingExpense = null,
    Object? mutatedWithOperatingExpense = null,
  }) {
    return _then(_$TokenWithApproximateOperatingExpenseImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      approximateOperatingExpense: null == approximateOperatingExpense
          ? _value.approximateOperatingExpense
          : approximateOperatingExpense // ignore: cast_nullable_to_non_nullable
              as String,
      mutatedWithOperatingExpense: null == mutatedWithOperatingExpense
          ? _value.mutatedWithOperatingExpense
          : mutatedWithOperatingExpense // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenWithApproximateOperatingExpenseImpl
    implements _TokenWithApproximateOperatingExpense {
  const _$TokenWithApproximateOperatingExpenseImpl(
      {required this.address,
      required this.name,
      required this.symbol,
      required this.decimals,
      required this.amount,
      required this.approximateOperatingExpense,
      required this.mutatedWithOperatingExpense});

  factory _$TokenWithApproximateOperatingExpenseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$TokenWithApproximateOperatingExpenseImplFromJson(json);

  @override
  final String address;
  @override
  final String name;
  @override
  final String symbol;
  @override
  final int decimals;
  @override
  final String amount;
  @override
  final String approximateOperatingExpense;
  @override
  final bool mutatedWithOperatingExpense;

  @override
  String toString() {
    return 'TokenWithApproximateOperatingExpense(address: $address, name: $name, symbol: $symbol, decimals: $decimals, amount: $amount, approximateOperatingExpense: $approximateOperatingExpense, mutatedWithOperatingExpense: $mutatedWithOperatingExpense)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenWithApproximateOperatingExpenseImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.approximateOperatingExpense,
                    approximateOperatingExpense) ||
                other.approximateOperatingExpense ==
                    approximateOperatingExpense) &&
            (identical(other.mutatedWithOperatingExpense,
                    mutatedWithOperatingExpense) ||
                other.mutatedWithOperatingExpense ==
                    mutatedWithOperatingExpense));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, name, symbol, decimals,
      amount, approximateOperatingExpense, mutatedWithOperatingExpense);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenWithApproximateOperatingExpenseImplCopyWith<
          _$TokenWithApproximateOperatingExpenseImpl>
      get copyWith => __$$TokenWithApproximateOperatingExpenseImplCopyWithImpl<
          _$TokenWithApproximateOperatingExpenseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenWithApproximateOperatingExpenseImplToJson(
      this,
    );
  }
}

abstract class _TokenWithApproximateOperatingExpense
    implements TokenWithApproximateOperatingExpense {
  const factory _TokenWithApproximateOperatingExpense(
          {required final String address,
          required final String name,
          required final String symbol,
          required final int decimals,
          required final String amount,
          required final String approximateOperatingExpense,
          required final bool mutatedWithOperatingExpense}) =
      _$TokenWithApproximateOperatingExpenseImpl;

  factory _TokenWithApproximateOperatingExpense.fromJson(
          Map<String, dynamic> json) =
      _$TokenWithApproximateOperatingExpenseImpl.fromJson;

  @override
  String get address;
  @override
  String get name;
  @override
  String get symbol;
  @override
  int get decimals;
  @override
  String get amount;
  @override
  String get approximateOperatingExpense;
  @override
  bool get mutatedWithOperatingExpense;
  @override
  @JsonKey(ignore: true)
  _$$TokenWithApproximateOperatingExpenseImplCopyWith<
          _$TokenWithApproximateOperatingExpenseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DstChainTokenOutResponseType _$DstChainTokenOutResponseTypeFromJson(
    Map<String, dynamic> json) {
  return _DstChainTokenOutResponseType.fromJson(json);
}

/// @nodoc
mixin _$DstChainTokenOutResponseType {
  String get address => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get recommendedAmount => throw _privateConstructorUsedError;
  String? get withoutAdditionalTakerRewardsAmount =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DstChainTokenOutResponseTypeCopyWith<DstChainTokenOutResponseType>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DstChainTokenOutResponseTypeCopyWith<$Res> {
  factory $DstChainTokenOutResponseTypeCopyWith(
          DstChainTokenOutResponseType value,
          $Res Function(DstChainTokenOutResponseType) then) =
      _$DstChainTokenOutResponseTypeCopyWithImpl<$Res,
          DstChainTokenOutResponseType>;
  @useResult
  $Res call(
      {String address,
      String name,
      String symbol,
      int decimals,
      String amount,
      String recommendedAmount,
      String? withoutAdditionalTakerRewardsAmount});
}

/// @nodoc
class _$DstChainTokenOutResponseTypeCopyWithImpl<$Res,
        $Val extends DstChainTokenOutResponseType>
    implements $DstChainTokenOutResponseTypeCopyWith<$Res> {
  _$DstChainTokenOutResponseTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? amount = null,
    Object? recommendedAmount = null,
    Object? withoutAdditionalTakerRewardsAmount = freezed,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedAmount: null == recommendedAmount
          ? _value.recommendedAmount
          : recommendedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      withoutAdditionalTakerRewardsAmount: freezed ==
              withoutAdditionalTakerRewardsAmount
          ? _value.withoutAdditionalTakerRewardsAmount
          : withoutAdditionalTakerRewardsAmount // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DstChainTokenOutResponseTypeImplCopyWith<$Res>
    implements $DstChainTokenOutResponseTypeCopyWith<$Res> {
  factory _$$DstChainTokenOutResponseTypeImplCopyWith(
          _$DstChainTokenOutResponseTypeImpl value,
          $Res Function(_$DstChainTokenOutResponseTypeImpl) then) =
      __$$DstChainTokenOutResponseTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String name,
      String symbol,
      int decimals,
      String amount,
      String recommendedAmount,
      String? withoutAdditionalTakerRewardsAmount});
}

/// @nodoc
class __$$DstChainTokenOutResponseTypeImplCopyWithImpl<$Res>
    extends _$DstChainTokenOutResponseTypeCopyWithImpl<$Res,
        _$DstChainTokenOutResponseTypeImpl>
    implements _$$DstChainTokenOutResponseTypeImplCopyWith<$Res> {
  __$$DstChainTokenOutResponseTypeImplCopyWithImpl(
      _$DstChainTokenOutResponseTypeImpl _value,
      $Res Function(_$DstChainTokenOutResponseTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? amount = null,
    Object? recommendedAmount = null,
    Object? withoutAdditionalTakerRewardsAmount = freezed,
  }) {
    return _then(_$DstChainTokenOutResponseTypeImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      recommendedAmount: null == recommendedAmount
          ? _value.recommendedAmount
          : recommendedAmount // ignore: cast_nullable_to_non_nullable
              as String,
      withoutAdditionalTakerRewardsAmount: freezed ==
              withoutAdditionalTakerRewardsAmount
          ? _value.withoutAdditionalTakerRewardsAmount
          : withoutAdditionalTakerRewardsAmount // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DstChainTokenOutResponseTypeImpl
    implements _DstChainTokenOutResponseType {
  const _$DstChainTokenOutResponseTypeImpl(
      {required this.address,
      required this.name,
      required this.symbol,
      required this.decimals,
      required this.amount,
      required this.recommendedAmount,
      this.withoutAdditionalTakerRewardsAmount});

  factory _$DstChainTokenOutResponseTypeImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$DstChainTokenOutResponseTypeImplFromJson(json);

  @override
  final String address;
  @override
  final String name;
  @override
  final String symbol;
  @override
  final int decimals;
  @override
  final String amount;
  @override
  final String recommendedAmount;
  @override
  final String? withoutAdditionalTakerRewardsAmount;

  @override
  String toString() {
    return 'DstChainTokenOutResponseType(address: $address, name: $name, symbol: $symbol, decimals: $decimals, amount: $amount, recommendedAmount: $recommendedAmount, withoutAdditionalTakerRewardsAmount: $withoutAdditionalTakerRewardsAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DstChainTokenOutResponseTypeImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.recommendedAmount, recommendedAmount) ||
                other.recommendedAmount == recommendedAmount) &&
            (identical(other.withoutAdditionalTakerRewardsAmount,
                    withoutAdditionalTakerRewardsAmount) ||
                other.withoutAdditionalTakerRewardsAmount ==
                    withoutAdditionalTakerRewardsAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, name, symbol, decimals,
      amount, recommendedAmount, withoutAdditionalTakerRewardsAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DstChainTokenOutResponseTypeImplCopyWith<
          _$DstChainTokenOutResponseTypeImpl>
      get copyWith => __$$DstChainTokenOutResponseTypeImplCopyWithImpl<
          _$DstChainTokenOutResponseTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DstChainTokenOutResponseTypeImplToJson(
      this,
    );
  }
}

abstract class _DstChainTokenOutResponseType
    implements DstChainTokenOutResponseType {
  const factory _DstChainTokenOutResponseType(
          {required final String address,
          required final String name,
          required final String symbol,
          required final int decimals,
          required final String amount,
          required final String recommendedAmount,
          final String? withoutAdditionalTakerRewardsAmount}) =
      _$DstChainTokenOutResponseTypeImpl;

  factory _DstChainTokenOutResponseType.fromJson(Map<String, dynamic> json) =
      _$DstChainTokenOutResponseTypeImpl.fromJson;

  @override
  String get address;
  @override
  String get name;
  @override
  String get symbol;
  @override
  int get decimals;
  @override
  String get amount;
  @override
  String get recommendedAmount;
  @override
  String? get withoutAdditionalTakerRewardsAmount;
  @override
  @JsonKey(ignore: true)
  _$$DstChainTokenOutResponseTypeImplCopyWith<
          _$DstChainTokenOutResponseTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TxQuote _$TxQuoteFromJson(Map<String, dynamic> json) {
  return _TxQuote.fromJson(json);
}

/// @nodoc
mixin _$TxQuote {
  String get allowanceTarget => throw _privateConstructorUsedError;
  String get allowanceValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TxQuoteCopyWith<TxQuote> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxQuoteCopyWith<$Res> {
  factory $TxQuoteCopyWith(TxQuote value, $Res Function(TxQuote) then) =
      _$TxQuoteCopyWithImpl<$Res, TxQuote>;
  @useResult
  $Res call({String allowanceTarget, String allowanceValue});
}

/// @nodoc
class _$TxQuoteCopyWithImpl<$Res, $Val extends TxQuote>
    implements $TxQuoteCopyWith<$Res> {
  _$TxQuoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowanceTarget = null,
    Object? allowanceValue = null,
  }) {
    return _then(_value.copyWith(
      allowanceTarget: null == allowanceTarget
          ? _value.allowanceTarget
          : allowanceTarget // ignore: cast_nullable_to_non_nullable
              as String,
      allowanceValue: null == allowanceValue
          ? _value.allowanceValue
          : allowanceValue // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TxQuoteImplCopyWith<$Res> implements $TxQuoteCopyWith<$Res> {
  factory _$$TxQuoteImplCopyWith(
          _$TxQuoteImpl value, $Res Function(_$TxQuoteImpl) then) =
      __$$TxQuoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String allowanceTarget, String allowanceValue});
}

/// @nodoc
class __$$TxQuoteImplCopyWithImpl<$Res>
    extends _$TxQuoteCopyWithImpl<$Res, _$TxQuoteImpl>
    implements _$$TxQuoteImplCopyWith<$Res> {
  __$$TxQuoteImplCopyWithImpl(
      _$TxQuoteImpl _value, $Res Function(_$TxQuoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowanceTarget = null,
    Object? allowanceValue = null,
  }) {
    return _then(_$TxQuoteImpl(
      allowanceTarget: null == allowanceTarget
          ? _value.allowanceTarget
          : allowanceTarget // ignore: cast_nullable_to_non_nullable
              as String,
      allowanceValue: null == allowanceValue
          ? _value.allowanceValue
          : allowanceValue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TxQuoteImpl implements _TxQuote {
  const _$TxQuoteImpl(
      {required this.allowanceTarget, required this.allowanceValue});

  factory _$TxQuoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$TxQuoteImplFromJson(json);

  @override
  final String allowanceTarget;
  @override
  final String allowanceValue;

  @override
  String toString() {
    return 'TxQuote(allowanceTarget: $allowanceTarget, allowanceValue: $allowanceValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TxQuoteImpl &&
            (identical(other.allowanceTarget, allowanceTarget) ||
                other.allowanceTarget == allowanceTarget) &&
            (identical(other.allowanceValue, allowanceValue) ||
                other.allowanceValue == allowanceValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, allowanceTarget, allowanceValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TxQuoteImplCopyWith<_$TxQuoteImpl> get copyWith =>
      __$$TxQuoteImplCopyWithImpl<_$TxQuoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TxQuoteImplToJson(
      this,
    );
  }
}

abstract class _TxQuote implements TxQuote {
  const factory _TxQuote(
      {required final String allowanceTarget,
      required final String allowanceValue}) = _$TxQuoteImpl;

  factory _TxQuote.fromJson(Map<String, dynamic> json) = _$TxQuoteImpl.fromJson;

  @override
  String get allowanceTarget;
  @override
  String get allowanceValue;
  @override
  @JsonKey(ignore: true)
  _$$TxQuoteImplCopyWith<_$TxQuoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  double get approximateFulfillmentDelay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({double approximateFulfillmentDelay});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? approximateFulfillmentDelay = null,
  }) {
    return _then(_value.copyWith(
      approximateFulfillmentDelay: null == approximateFulfillmentDelay
          ? _value.approximateFulfillmentDelay
          : approximateFulfillmentDelay // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double approximateFulfillmentDelay});
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? approximateFulfillmentDelay = null,
  }) {
    return _then(_$OrderImpl(
      approximateFulfillmentDelay: null == approximateFulfillmentDelay
          ? _value.approximateFulfillmentDelay
          : approximateFulfillmentDelay // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl({required this.approximateFulfillmentDelay});

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final double approximateFulfillmentDelay;

  @override
  String toString() {
    return 'Order(approximateFulfillmentDelay: $approximateFulfillmentDelay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.approximateFulfillmentDelay,
                    approximateFulfillmentDelay) ||
                other.approximateFulfillmentDelay ==
                    approximateFulfillmentDelay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, approximateFulfillmentDelay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order({required final double approximateFulfillmentDelay}) =
      _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  double get approximateFulfillmentDelay;
  @override
  @JsonKey(ignore: true)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DlnTx _$DlnTxFromJson(Map<String, dynamic> json) {
  return _DlnTx.fromJson(json);
}

/// @nodoc
mixin _$DlnTx {
  String get data => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  double? get gasLimit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DlnTxCopyWith<DlnTx> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DlnTxCopyWith<$Res> {
  factory $DlnTxCopyWith(DlnTx value, $Res Function(DlnTx) then) =
      _$DlnTxCopyWithImpl<$Res, DlnTx>;
  @useResult
  $Res call({String data, String? to, String? value, double? gasLimit});
}

/// @nodoc
class _$DlnTxCopyWithImpl<$Res, $Val extends DlnTx>
    implements $DlnTxCopyWith<$Res> {
  _$DlnTxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? to = freezed,
    Object? value = freezed,
    Object? gasLimit = freezed,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      gasLimit: freezed == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DlnTxImplCopyWith<$Res> implements $DlnTxCopyWith<$Res> {
  factory _$$DlnTxImplCopyWith(
          _$DlnTxImpl value, $Res Function(_$DlnTxImpl) then) =
      __$$DlnTxImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String data, String? to, String? value, double? gasLimit});
}

/// @nodoc
class __$$DlnTxImplCopyWithImpl<$Res>
    extends _$DlnTxCopyWithImpl<$Res, _$DlnTxImpl>
    implements _$$DlnTxImplCopyWith<$Res> {
  __$$DlnTxImplCopyWithImpl(
      _$DlnTxImpl _value, $Res Function(_$DlnTxImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? to = freezed,
    Object? value = freezed,
    Object? gasLimit = freezed,
  }) {
    return _then(_$DlnTxImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      gasLimit: freezed == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DlnTxImpl implements _DlnTx {
  const _$DlnTxImpl({required this.data, this.to, this.value, this.gasLimit});

  factory _$DlnTxImpl.fromJson(Map<String, dynamic> json) =>
      _$$DlnTxImplFromJson(json);

  @override
  final String data;
  @override
  final String? to;
  @override
  final String? value;
  @override
  final double? gasLimit;

  @override
  String toString() {
    return 'DlnTx(data: $data, to: $to, value: $value, gasLimit: $gasLimit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DlnTxImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, to, value, gasLimit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DlnTxImplCopyWith<_$DlnTxImpl> get copyWith =>
      __$$DlnTxImplCopyWithImpl<_$DlnTxImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DlnTxImplToJson(
      this,
    );
  }
}

abstract class _DlnTx implements DlnTx {
  const factory _DlnTx(
      {required final String data,
      final String? to,
      final String? value,
      final double? gasLimit}) = _$DlnTxImpl;

  factory _DlnTx.fromJson(Map<String, dynamic> json) = _$DlnTxImpl.fromJson;

  @override
  String get data;
  @override
  String? get to;
  @override
  String? get value;
  @override
  double? get gasLimit;
  @override
  @JsonKey(ignore: true)
  _$$DlnTxImplCopyWith<_$DlnTxImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return _Offer.fromJson(json);
}

/// @nodoc
mixin _$Offer {
  int get chainId => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfferCopyWith<Offer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferCopyWith<$Res> {
  factory $OfferCopyWith(Offer value, $Res Function(Offer) then) =
      _$OfferCopyWithImpl<$Res, Offer>;
  @useResult
  $Res call({int chainId, String tokenAddress, String amount});
}

/// @nodoc
class _$OfferCopyWithImpl<$Res, $Val extends Offer>
    implements $OfferCopyWith<$Res> {
  _$OfferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? tokenAddress = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfferImplCopyWith<$Res> implements $OfferCopyWith<$Res> {
  factory _$$OfferImplCopyWith(
          _$OfferImpl value, $Res Function(_$OfferImpl) then) =
      __$$OfferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int chainId, String tokenAddress, String amount});
}

/// @nodoc
class __$$OfferImplCopyWithImpl<$Res>
    extends _$OfferCopyWithImpl<$Res, _$OfferImpl>
    implements _$$OfferImplCopyWith<$Res> {
  __$$OfferImplCopyWithImpl(
      _$OfferImpl _value, $Res Function(_$OfferImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? tokenAddress = null,
    Object? amount = null,
  }) {
    return _then(_$OfferImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfferImpl implements _Offer {
  const _$OfferImpl(
      {required this.chainId,
      required this.tokenAddress,
      required this.amount});

  factory _$OfferImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfferImplFromJson(json);

  @override
  final int chainId;
  @override
  final String tokenAddress;
  @override
  final String amount;

  @override
  String toString() {
    return 'Offer(chainId: $chainId, tokenAddress: $tokenAddress, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, tokenAddress, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferImplCopyWith<_$OfferImpl> get copyWith =>
      __$$OfferImplCopyWithImpl<_$OfferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfferImplToJson(
      this,
    );
  }
}

abstract class _Offer implements Offer {
  const factory _Offer(
      {required final int chainId,
      required final String tokenAddress,
      required final String amount}) = _$OfferImpl;

  factory _Offer.fromJson(Map<String, dynamic> json) = _$OfferImpl.fromJson;

  @override
  int get chainId;
  @override
  String get tokenAddress;
  @override
  String get amount;
  @override
  @JsonKey(ignore: true)
  _$$OfferImplCopyWith<_$OfferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderStruct _$OrderStructFromJson(Map<String, dynamic> json) {
  return _OrderStruct.fromJson(json);
}

/// @nodoc
mixin _$OrderStruct {
  int get makerOrderNonce => throw _privateConstructorUsedError;
  String get makerSrc => throw _privateConstructorUsedError;
  Offer get giveOffer => throw _privateConstructorUsedError;
  String get receiverDst => throw _privateConstructorUsedError;
  Offer get takeOffer => throw _privateConstructorUsedError;
  String get givePatchAuthoritySrc => throw _privateConstructorUsedError;
  String get orderAuthorityAddressDst => throw _privateConstructorUsedError;
  String? get allowedTakerDst => throw _privateConstructorUsedError;
  String? get allowedCancelBeneficiarySrc => throw _privateConstructorUsedError;
  String? get externalCall => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStructCopyWith<OrderStruct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStructCopyWith<$Res> {
  factory $OrderStructCopyWith(
          OrderStruct value, $Res Function(OrderStruct) then) =
      _$OrderStructCopyWithImpl<$Res, OrderStruct>;
  @useResult
  $Res call(
      {int makerOrderNonce,
      String makerSrc,
      Offer giveOffer,
      String receiverDst,
      Offer takeOffer,
      String givePatchAuthoritySrc,
      String orderAuthorityAddressDst,
      String? allowedTakerDst,
      String? allowedCancelBeneficiarySrc,
      String? externalCall});

  $OfferCopyWith<$Res> get giveOffer;
  $OfferCopyWith<$Res> get takeOffer;
}

/// @nodoc
class _$OrderStructCopyWithImpl<$Res, $Val extends OrderStruct>
    implements $OrderStructCopyWith<$Res> {
  _$OrderStructCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? makerOrderNonce = null,
    Object? makerSrc = null,
    Object? giveOffer = null,
    Object? receiverDst = null,
    Object? takeOffer = null,
    Object? givePatchAuthoritySrc = null,
    Object? orderAuthorityAddressDst = null,
    Object? allowedTakerDst = freezed,
    Object? allowedCancelBeneficiarySrc = freezed,
    Object? externalCall = freezed,
  }) {
    return _then(_value.copyWith(
      makerOrderNonce: null == makerOrderNonce
          ? _value.makerOrderNonce
          : makerOrderNonce // ignore: cast_nullable_to_non_nullable
              as int,
      makerSrc: null == makerSrc
          ? _value.makerSrc
          : makerSrc // ignore: cast_nullable_to_non_nullable
              as String,
      giveOffer: null == giveOffer
          ? _value.giveOffer
          : giveOffer // ignore: cast_nullable_to_non_nullable
              as Offer,
      receiverDst: null == receiverDst
          ? _value.receiverDst
          : receiverDst // ignore: cast_nullable_to_non_nullable
              as String,
      takeOffer: null == takeOffer
          ? _value.takeOffer
          : takeOffer // ignore: cast_nullable_to_non_nullable
              as Offer,
      givePatchAuthoritySrc: null == givePatchAuthoritySrc
          ? _value.givePatchAuthoritySrc
          : givePatchAuthoritySrc // ignore: cast_nullable_to_non_nullable
              as String,
      orderAuthorityAddressDst: null == orderAuthorityAddressDst
          ? _value.orderAuthorityAddressDst
          : orderAuthorityAddressDst // ignore: cast_nullable_to_non_nullable
              as String,
      allowedTakerDst: freezed == allowedTakerDst
          ? _value.allowedTakerDst
          : allowedTakerDst // ignore: cast_nullable_to_non_nullable
              as String?,
      allowedCancelBeneficiarySrc: freezed == allowedCancelBeneficiarySrc
          ? _value.allowedCancelBeneficiarySrc
          : allowedCancelBeneficiarySrc // ignore: cast_nullable_to_non_nullable
              as String?,
      externalCall: freezed == externalCall
          ? _value.externalCall
          : externalCall // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OfferCopyWith<$Res> get giveOffer {
    return $OfferCopyWith<$Res>(_value.giveOffer, (value) {
      return _then(_value.copyWith(giveOffer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $OfferCopyWith<$Res> get takeOffer {
    return $OfferCopyWith<$Res>(_value.takeOffer, (value) {
      return _then(_value.copyWith(takeOffer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderStructImplCopyWith<$Res>
    implements $OrderStructCopyWith<$Res> {
  factory _$$OrderStructImplCopyWith(
          _$OrderStructImpl value, $Res Function(_$OrderStructImpl) then) =
      __$$OrderStructImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int makerOrderNonce,
      String makerSrc,
      Offer giveOffer,
      String receiverDst,
      Offer takeOffer,
      String givePatchAuthoritySrc,
      String orderAuthorityAddressDst,
      String? allowedTakerDst,
      String? allowedCancelBeneficiarySrc,
      String? externalCall});

  @override
  $OfferCopyWith<$Res> get giveOffer;
  @override
  $OfferCopyWith<$Res> get takeOffer;
}

/// @nodoc
class __$$OrderStructImplCopyWithImpl<$Res>
    extends _$OrderStructCopyWithImpl<$Res, _$OrderStructImpl>
    implements _$$OrderStructImplCopyWith<$Res> {
  __$$OrderStructImplCopyWithImpl(
      _$OrderStructImpl _value, $Res Function(_$OrderStructImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? makerOrderNonce = null,
    Object? makerSrc = null,
    Object? giveOffer = null,
    Object? receiverDst = null,
    Object? takeOffer = null,
    Object? givePatchAuthoritySrc = null,
    Object? orderAuthorityAddressDst = null,
    Object? allowedTakerDst = freezed,
    Object? allowedCancelBeneficiarySrc = freezed,
    Object? externalCall = freezed,
  }) {
    return _then(_$OrderStructImpl(
      makerOrderNonce: null == makerOrderNonce
          ? _value.makerOrderNonce
          : makerOrderNonce // ignore: cast_nullable_to_non_nullable
              as int,
      makerSrc: null == makerSrc
          ? _value.makerSrc
          : makerSrc // ignore: cast_nullable_to_non_nullable
              as String,
      giveOffer: null == giveOffer
          ? _value.giveOffer
          : giveOffer // ignore: cast_nullable_to_non_nullable
              as Offer,
      receiverDst: null == receiverDst
          ? _value.receiverDst
          : receiverDst // ignore: cast_nullable_to_non_nullable
              as String,
      takeOffer: null == takeOffer
          ? _value.takeOffer
          : takeOffer // ignore: cast_nullable_to_non_nullable
              as Offer,
      givePatchAuthoritySrc: null == givePatchAuthoritySrc
          ? _value.givePatchAuthoritySrc
          : givePatchAuthoritySrc // ignore: cast_nullable_to_non_nullable
              as String,
      orderAuthorityAddressDst: null == orderAuthorityAddressDst
          ? _value.orderAuthorityAddressDst
          : orderAuthorityAddressDst // ignore: cast_nullable_to_non_nullable
              as String,
      allowedTakerDst: freezed == allowedTakerDst
          ? _value.allowedTakerDst
          : allowedTakerDst // ignore: cast_nullable_to_non_nullable
              as String?,
      allowedCancelBeneficiarySrc: freezed == allowedCancelBeneficiarySrc
          ? _value.allowedCancelBeneficiarySrc
          : allowedCancelBeneficiarySrc // ignore: cast_nullable_to_non_nullable
              as String?,
      externalCall: freezed == externalCall
          ? _value.externalCall
          : externalCall // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderStructImpl implements _OrderStruct {
  const _$OrderStructImpl(
      {required this.makerOrderNonce,
      required this.makerSrc,
      required this.giveOffer,
      required this.receiverDst,
      required this.takeOffer,
      required this.givePatchAuthoritySrc,
      required this.orderAuthorityAddressDst,
      this.allowedTakerDst,
      this.allowedCancelBeneficiarySrc,
      this.externalCall});

  factory _$OrderStructImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderStructImplFromJson(json);

  @override
  final int makerOrderNonce;
  @override
  final String makerSrc;
  @override
  final Offer giveOffer;
  @override
  final String receiverDst;
  @override
  final Offer takeOffer;
  @override
  final String givePatchAuthoritySrc;
  @override
  final String orderAuthorityAddressDst;
  @override
  final String? allowedTakerDst;
  @override
  final String? allowedCancelBeneficiarySrc;
  @override
  final String? externalCall;

  @override
  String toString() {
    return 'OrderStruct(makerOrderNonce: $makerOrderNonce, makerSrc: $makerSrc, giveOffer: $giveOffer, receiverDst: $receiverDst, takeOffer: $takeOffer, givePatchAuthoritySrc: $givePatchAuthoritySrc, orderAuthorityAddressDst: $orderAuthorityAddressDst, allowedTakerDst: $allowedTakerDst, allowedCancelBeneficiarySrc: $allowedCancelBeneficiarySrc, externalCall: $externalCall)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderStructImpl &&
            (identical(other.makerOrderNonce, makerOrderNonce) ||
                other.makerOrderNonce == makerOrderNonce) &&
            (identical(other.makerSrc, makerSrc) ||
                other.makerSrc == makerSrc) &&
            (identical(other.giveOffer, giveOffer) ||
                other.giveOffer == giveOffer) &&
            (identical(other.receiverDst, receiverDst) ||
                other.receiverDst == receiverDst) &&
            (identical(other.takeOffer, takeOffer) ||
                other.takeOffer == takeOffer) &&
            (identical(other.givePatchAuthoritySrc, givePatchAuthoritySrc) ||
                other.givePatchAuthoritySrc == givePatchAuthoritySrc) &&
            (identical(
                    other.orderAuthorityAddressDst, orderAuthorityAddressDst) ||
                other.orderAuthorityAddressDst == orderAuthorityAddressDst) &&
            (identical(other.allowedTakerDst, allowedTakerDst) ||
                other.allowedTakerDst == allowedTakerDst) &&
            (identical(other.allowedCancelBeneficiarySrc,
                    allowedCancelBeneficiarySrc) ||
                other.allowedCancelBeneficiarySrc ==
                    allowedCancelBeneficiarySrc) &&
            (identical(other.externalCall, externalCall) ||
                other.externalCall == externalCall));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      makerOrderNonce,
      makerSrc,
      giveOffer,
      receiverDst,
      takeOffer,
      givePatchAuthoritySrc,
      orderAuthorityAddressDst,
      allowedTakerDst,
      allowedCancelBeneficiarySrc,
      externalCall);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderStructImplCopyWith<_$OrderStructImpl> get copyWith =>
      __$$OrderStructImplCopyWithImpl<_$OrderStructImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderStructImplToJson(
      this,
    );
  }
}

abstract class _OrderStruct implements OrderStruct {
  const factory _OrderStruct(
      {required final int makerOrderNonce,
      required final String makerSrc,
      required final Offer giveOffer,
      required final String receiverDst,
      required final Offer takeOffer,
      required final String givePatchAuthoritySrc,
      required final String orderAuthorityAddressDst,
      final String? allowedTakerDst,
      final String? allowedCancelBeneficiarySrc,
      final String? externalCall}) = _$OrderStructImpl;

  factory _OrderStruct.fromJson(Map<String, dynamic> json) =
      _$OrderStructImpl.fromJson;

  @override
  int get makerOrderNonce;
  @override
  String get makerSrc;
  @override
  Offer get giveOffer;
  @override
  String get receiverDst;
  @override
  Offer get takeOffer;
  @override
  String get givePatchAuthoritySrc;
  @override
  String get orderAuthorityAddressDst;
  @override
  String? get allowedTakerDst;
  @override
  String? get allowedCancelBeneficiarySrc;
  @override
  String? get externalCall;
  @override
  @JsonKey(ignore: true)
  _$$OrderStructImplCopyWith<_$OrderStructImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
