// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuoteTransaction {
  String get amount => throw _privateConstructorUsedError;
  String get outAmount => throw _privateConstructorUsedError;
  int get fee => throw _privateConstructorUsedError;
  SignedTx get transaction => throw _privateConstructorUsedError;
  BigInt get slot => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuoteTransactionCopyWith<QuoteTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteTransactionCopyWith<$Res> {
  factory $QuoteTransactionCopyWith(
          QuoteTransaction value, $Res Function(QuoteTransaction) then) =
      _$QuoteTransactionCopyWithImpl<$Res, QuoteTransaction>;
  @useResult
  $Res call(
      {String amount,
      String outAmount,
      int fee,
      SignedTx transaction,
      BigInt slot});

  $SignedTxCopyWith<$Res> get transaction;
}

/// @nodoc
class _$QuoteTransactionCopyWithImpl<$Res, $Val extends QuoteTransaction>
    implements $QuoteTransactionCopyWith<$Res> {
  _$QuoteTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? outAmount = null,
    Object? fee = null,
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as SignedTx,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SignedTxCopyWith<$Res> get transaction {
    return $SignedTxCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_QuoteTransactionCopyWith<$Res>
    implements $QuoteTransactionCopyWith<$Res> {
  factory _$$_QuoteTransactionCopyWith(
          _$_QuoteTransaction value, $Res Function(_$_QuoteTransaction) then) =
      __$$_QuoteTransactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String amount,
      String outAmount,
      int fee,
      SignedTx transaction,
      BigInt slot});

  @override
  $SignedTxCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$_QuoteTransactionCopyWithImpl<$Res>
    extends _$QuoteTransactionCopyWithImpl<$Res, _$_QuoteTransaction>
    implements _$$_QuoteTransactionCopyWith<$Res> {
  __$$_QuoteTransactionCopyWithImpl(
      _$_QuoteTransaction _value, $Res Function(_$_QuoteTransaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? outAmount = null,
    Object? fee = null,
    Object? transaction = null,
    Object? slot = null,
  }) {
    return _then(_$_QuoteTransaction(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      outAmount: null == outAmount
          ? _value.outAmount
          : outAmount // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as SignedTx,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc

class _$_QuoteTransaction implements _QuoteTransaction {
  const _$_QuoteTransaction(
      {required this.amount,
      required this.outAmount,
      required this.fee,
      required this.transaction,
      required this.slot});

  @override
  final String amount;
  @override
  final String outAmount;
  @override
  final int fee;
  @override
  final SignedTx transaction;
  @override
  final BigInt slot;

  @override
  String toString() {
    return 'QuoteTransaction(amount: $amount, outAmount: $outAmount, fee: $fee, transaction: $transaction, slot: $slot)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuoteTransaction &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.outAmount, outAmount) ||
                other.outAmount == outAmount) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, outAmount, fee, transaction, slot);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuoteTransactionCopyWith<_$_QuoteTransaction> get copyWith =>
      __$$_QuoteTransactionCopyWithImpl<_$_QuoteTransaction>(this, _$identity);
}

abstract class _QuoteTransaction implements QuoteTransaction {
  const factory _QuoteTransaction(
      {required final String amount,
      required final String outAmount,
      required final int fee,
      required final SignedTx transaction,
      required final BigInt slot}) = _$_QuoteTransaction;

  @override
  String get amount;
  @override
  String get outAmount;
  @override
  int get fee;
  @override
  SignedTx get transaction;
  @override
  BigInt get slot;
  @override
  @JsonKey(ignore: true)
  _$$_QuoteTransactionCopyWith<_$_QuoteTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}
