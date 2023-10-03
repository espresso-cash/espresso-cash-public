// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dln_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuoteInfo {
  String get hexTx => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get outAmount => throw _privateConstructorUsedError;
  num get totalFees => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuoteInfoCopyWith<QuoteInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteInfoCopyWith<$Res> {
  factory $QuoteInfoCopyWith(QuoteInfo value, $Res Function(QuoteInfo) then) =
      _$QuoteInfoCopyWithImpl<$Res, QuoteInfo>;
  @useResult
  $Res call({String hexTx, String amount, String outAmount, num totalFees});
}

/// @nodoc
class _$QuoteInfoCopyWithImpl<$Res, $Val extends QuoteInfo>
    implements $QuoteInfoCopyWith<$Res> {
  _$QuoteInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hexTx = null,
    Object? amount = null,
    Object? outAmount = null,
    Object? totalFees = null,
  }) {
    return _then(_value.copyWith(
      hexTx: null == hexTx
          ? _value.hexTx
          : hexTx // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      totalFees: null == totalFees
          ? _value.totalFees
          : totalFees // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RouteInfoCopyWith<$Res> implements $QuoteInfoCopyWith<$Res> {
  factory _$$_RouteInfoCopyWith(
          _$_RouteInfo value, $Res Function(_$_RouteInfo) then) =
      __$$_RouteInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hexTx, String amount, String outAmount, num totalFees});
}

/// @nodoc
class __$$_RouteInfoCopyWithImpl<$Res>
    extends _$QuoteInfoCopyWithImpl<$Res, _$_RouteInfo>
    implements _$$_RouteInfoCopyWith<$Res> {
  __$$_RouteInfoCopyWithImpl(
      _$_RouteInfo _value, $Res Function(_$_RouteInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hexTx = null,
    Object? amount = null,
    Object? outAmount = null,
    Object? totalFees = null,
  }) {
    return _then(_$_RouteInfo(
      hexTx: null == hexTx
          ? _value.hexTx
          : hexTx // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      totalFees: null == totalFees
          ? _value.totalFees
          : totalFees // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc

class _$_RouteInfo implements _RouteInfo {
  const _$_RouteInfo(
      {required this.hexTx,
      required this.amount,
      required this.outAmount,
      required this.totalFees});

  @override
  final String hexTx;
  @override
  final String amount;
  @override
  final String outAmount;
  @override
  final num totalFees;

  @override
  String toString() {
    return 'QuoteInfo(hexTx: $hexTx, amount: $amount, outAmount: $outAmount, totalFees: $totalFees)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RouteInfo &&
            (identical(other.hexTx, hexTx) || other.hexTx == hexTx) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.outAmount, outAmount) ||
                other.outAmount == outAmount) &&
            (identical(other.totalFees, totalFees) ||
                other.totalFees == totalFees));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, hexTx, amount, outAmount, totalFees);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RouteInfoCopyWith<_$_RouteInfo> get copyWith =>
      __$$_RouteInfoCopyWithImpl<_$_RouteInfo>(this, _$identity);
}

abstract class _RouteInfo implements QuoteInfo {
  const factory _RouteInfo(
      {required final String hexTx,
      required final String amount,
      required final String outAmount,
      required final num totalFees}) = _$_RouteInfo;

  @override
  String get hexTx;
  @override
  String get amount;
  @override
  String get outAmount;
  @override
  num get totalFees;
  @override
  @JsonKey(ignore: true)
  _$$_RouteInfoCopyWith<_$_RouteInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
