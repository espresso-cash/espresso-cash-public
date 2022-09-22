// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$DirectPaymentResultCopyWithImpl<$Res>;
  $Res call({int fee, SignedTx transaction});
}

/// @nodoc
class _$DirectPaymentResultCopyWithImpl<$Res>
    implements $DirectPaymentResultCopyWith<$Res> {
  _$DirectPaymentResultCopyWithImpl(this._value, this._then);

  final DirectPaymentResult _value;
  // ignore: unused_field
  final $Res Function(DirectPaymentResult) _then;

  @override
  $Res call({
    Object? fee = freezed,
    Object? transaction = freezed,
  }) {
    return _then(_value.copyWith(
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as SignedTx,
    ));
  }
}

/// @nodoc
abstract class _$$_DirectPaymentResultCopyWith<$Res>
    implements $DirectPaymentResultCopyWith<$Res> {
  factory _$$_DirectPaymentResultCopyWith(_$_DirectPaymentResult value,
          $Res Function(_$_DirectPaymentResult) then) =
      __$$_DirectPaymentResultCopyWithImpl<$Res>;
  @override
  $Res call({int fee, SignedTx transaction});
}

/// @nodoc
class __$$_DirectPaymentResultCopyWithImpl<$Res>
    extends _$DirectPaymentResultCopyWithImpl<$Res>
    implements _$$_DirectPaymentResultCopyWith<$Res> {
  __$$_DirectPaymentResultCopyWithImpl(_$_DirectPaymentResult _value,
      $Res Function(_$_DirectPaymentResult) _then)
      : super(_value, (v) => _then(v as _$_DirectPaymentResult));

  @override
  _$_DirectPaymentResult get _value => super._value as _$_DirectPaymentResult;

  @override
  $Res call({
    Object? fee = freezed,
    Object? transaction = freezed,
  }) {
    return _then(_$_DirectPaymentResult(
      fee: fee == freezed
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: transaction == freezed
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
            const DeepCollectionEquality().equals(other.fee, fee) &&
            const DeepCollectionEquality()
                .equals(other.transaction, transaction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fee),
      const DeepCollectionEquality().hash(transaction));

  @JsonKey(ignore: true)
  @override
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
