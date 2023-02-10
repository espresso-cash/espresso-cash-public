// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_direct_payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DirectPaymentResult {
  int get fee => throw _privateConstructorUsedError;
  SignedTx get transaction => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DirectPaymentResultCopyWith<DirectPaymentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectPaymentResultCopyWith<$Res> {
  factory $DirectPaymentResultCopyWith(
          DirectPaymentResult value, $Res Function(DirectPaymentResult) then) =
      _$DirectPaymentResultCopyWithImpl<$Res, DirectPaymentResult>;
  @useResult
  $Res call({int fee, SignedTx transaction});
}

/// @nodoc
class _$DirectPaymentResultCopyWithImpl<$Res, $Val extends DirectPaymentResult>
    implements $DirectPaymentResultCopyWith<$Res> {
  _$DirectPaymentResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? transaction = null,
  }) {
    return _then(_value.copyWith(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as SignedTx,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DirectPaymentResultCopyWith<$Res>
    implements $DirectPaymentResultCopyWith<$Res> {
  factory _$$_DirectPaymentResultCopyWith(_$_DirectPaymentResult value,
          $Res Function(_$_DirectPaymentResult) then) =
      __$$_DirectPaymentResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fee, SignedTx transaction});
}

/// @nodoc
class __$$_DirectPaymentResultCopyWithImpl<$Res>
    extends _$DirectPaymentResultCopyWithImpl<$Res, _$_DirectPaymentResult>
    implements _$$_DirectPaymentResultCopyWith<$Res> {
  __$$_DirectPaymentResultCopyWithImpl(_$_DirectPaymentResult _value,
      $Res Function(_$_DirectPaymentResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? transaction = null,
  }) {
    return _then(_$_DirectPaymentResult(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as SignedTx,
    ));
  }
}

/// @nodoc

class _$_DirectPaymentResult implements _DirectPaymentResult {
  const _$_DirectPaymentResult({required this.fee, required this.transaction});

  @override
  final int fee;
  @override
  final SignedTx transaction;

  @override
  String toString() {
    return 'DirectPaymentResult(fee: $fee, transaction: $transaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectPaymentResult &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fee, transaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DirectPaymentResultCopyWith<_$_DirectPaymentResult> get copyWith =>
      __$$_DirectPaymentResultCopyWithImpl<_$_DirectPaymentResult>(
          this, _$identity);
}

abstract class _DirectPaymentResult implements DirectPaymentResult {
  const factory _DirectPaymentResult(
      {required final int fee,
      required final SignedTx transaction}) = _$_DirectPaymentResult;

  @override
  int get fee;
  @override
  SignedTx get transaction;
  @override
  @JsonKey(ignore: true)
  _$$_DirectPaymentResultCopyWith<_$_DirectPaymentResult> get copyWith =>
      throw _privateConstructorUsedError;
}
