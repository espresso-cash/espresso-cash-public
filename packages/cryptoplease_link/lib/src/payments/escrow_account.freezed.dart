// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'escrow_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EscrowAccount {
  Ed25519HDPublicKey get address => throw _privateConstructorUsedError;
  Ed25519HDPublicKey get mint => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EscrowAccountCopyWith<EscrowAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EscrowAccountCopyWith<$Res> {
  factory $EscrowAccountCopyWith(
          EscrowAccount value, $Res Function(EscrowAccount) then) =
      _$EscrowAccountCopyWithImpl<$Res, EscrowAccount>;
  @useResult
  $Res call({Ed25519HDPublicKey address, Ed25519HDPublicKey mint, int amount});
}

/// @nodoc
class _$EscrowAccountCopyWithImpl<$Res, $Val extends EscrowAccount>
    implements $EscrowAccountCopyWith<$Res> {
  _$EscrowAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? mint = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      mint: null == mint
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EscrowAccountCopyWith<$Res>
    implements $EscrowAccountCopyWith<$Res> {
  factory _$$_EscrowAccountCopyWith(
          _$_EscrowAccount value, $Res Function(_$_EscrowAccount) then) =
      __$$_EscrowAccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Ed25519HDPublicKey address, Ed25519HDPublicKey mint, int amount});
}

/// @nodoc
class __$$_EscrowAccountCopyWithImpl<$Res>
    extends _$EscrowAccountCopyWithImpl<$Res, _$_EscrowAccount>
    implements _$$_EscrowAccountCopyWith<$Res> {
  __$$_EscrowAccountCopyWithImpl(
      _$_EscrowAccount _value, $Res Function(_$_EscrowAccount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? mint = null,
    Object? amount = null,
  }) {
    return _then(_$_EscrowAccount(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      mint: null == mint
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_EscrowAccount implements _EscrowAccount {
  const _$_EscrowAccount(
      {required this.address, required this.mint, required this.amount});

  @override
  final Ed25519HDPublicKey address;
  @override
  final Ed25519HDPublicKey mint;
  @override
  final int amount;

  @override
  String toString() {
    return 'EscrowAccount(address: $address, mint: $mint, amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EscrowAccount &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.mint, mint) || other.mint == mint) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, mint, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EscrowAccountCopyWith<_$_EscrowAccount> get copyWith =>
      __$$_EscrowAccountCopyWithImpl<_$_EscrowAccount>(this, _$identity);
}

abstract class _EscrowAccount implements EscrowAccount {
  const factory _EscrowAccount(
      {required final Ed25519HDPublicKey address,
      required final Ed25519HDPublicKey mint,
      required final int amount}) = _$_EscrowAccount;

  @override
  Ed25519HDPublicKey get address;
  @override
  Ed25519HDPublicKey get mint;
  @override
  int get amount;
  @override
  @JsonKey(ignore: true)
  _$$_EscrowAccountCopyWith<_$_EscrowAccount> get copyWith =>
      throw _privateConstructorUsedError;
}
