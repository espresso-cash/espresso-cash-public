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
  String get tx => throw _privateConstructorUsedError;
  String get inputAmount => throw _privateConstructorUsedError;
  String get senderDeductAmount => throw _privateConstructorUsedError;
  String get receiverAmount => throw _privateConstructorUsedError;
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
  $Res call(
      {String tx,
      String inputAmount,
      String senderDeductAmount,
      String receiverAmount,
      num totalFees});
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
    Object? tx = null,
    Object? inputAmount = null,
    Object? senderDeductAmount = null,
    Object? receiverAmount = null,
    Object? totalFees = null,
  }) {
    return _then(_value.copyWith(
      tx: null == tx
          ? _value.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as String,
      inputAmount: null == inputAmount
          ? _value.inputAmount
          : inputAmount // ignore: cast_nullable_to_non_nullable
              as String,
      senderDeductAmount: null == senderDeductAmount
          ? _value.senderDeductAmount
          : senderDeductAmount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAmount: null == receiverAmount
          ? _value.receiverAmount
          : receiverAmount // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {String tx,
      String inputAmount,
      String senderDeductAmount,
      String receiverAmount,
      num totalFees});
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
    Object? tx = null,
    Object? inputAmount = null,
    Object? senderDeductAmount = null,
    Object? receiverAmount = null,
    Object? totalFees = null,
  }) {
    return _then(_$_RouteInfo(
      tx: null == tx
          ? _value.tx
          : tx // ignore: cast_nullable_to_non_nullable
              as String,
      inputAmount: null == inputAmount
          ? _value.inputAmount
          : inputAmount // ignore: cast_nullable_to_non_nullable
              as String,
      senderDeductAmount: null == senderDeductAmount
          ? _value.senderDeductAmount
          : senderDeductAmount // ignore: cast_nullable_to_non_nullable
              as String,
      receiverAmount: null == receiverAmount
          ? _value.receiverAmount
          : receiverAmount // ignore: cast_nullable_to_non_nullable
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
      {required this.tx,
      required this.inputAmount,
      required this.senderDeductAmount,
      required this.receiverAmount,
      required this.totalFees});

  @override
  final String tx;
  @override
  final String inputAmount;
  @override
  final String senderDeductAmount;
  @override
  final String receiverAmount;
  @override
  final num totalFees;

  @override
  String toString() {
    return 'QuoteInfo(tx: $tx, inputAmount: $inputAmount, senderDeductAmount: $senderDeductAmount, receiverAmount: $receiverAmount, totalFees: $totalFees)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RouteInfo &&
            (identical(other.tx, tx) || other.tx == tx) &&
            (identical(other.inputAmount, inputAmount) ||
                other.inputAmount == inputAmount) &&
            (identical(other.senderDeductAmount, senderDeductAmount) ||
                other.senderDeductAmount == senderDeductAmount) &&
            (identical(other.receiverAmount, receiverAmount) ||
                other.receiverAmount == receiverAmount) &&
            (identical(other.totalFees, totalFees) ||
                other.totalFees == totalFees));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tx, inputAmount,
      senderDeductAmount, receiverAmount, totalFees);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RouteInfoCopyWith<_$_RouteInfo> get copyWith =>
      __$$_RouteInfoCopyWithImpl<_$_RouteInfo>(this, _$identity);
}

abstract class _RouteInfo implements QuoteInfo {
  const factory _RouteInfo(
      {required final String tx,
      required final String inputAmount,
      required final String senderDeductAmount,
      required final String receiverAmount,
      required final num totalFees}) = _$_RouteInfo;

  @override
  String get tx;
  @override
  String get inputAmount;
  @override
  String get senderDeductAmount;
  @override
  String get receiverAmount;
  @override
  num get totalFees;
  @override
  @JsonKey(ignore: true)
  _$$_RouteInfoCopyWith<_$_RouteInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
