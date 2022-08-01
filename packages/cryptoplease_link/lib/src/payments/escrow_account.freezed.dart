// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$EscrowAccountCopyWithImpl<$Res>;
  $Res call({Ed25519HDPublicKey address, Ed25519HDPublicKey mint, int amount});
}

/// @nodoc
class _$EscrowAccountCopyWithImpl<$Res>
    implements $EscrowAccountCopyWith<$Res> {
  _$EscrowAccountCopyWithImpl(this._value, this._then);

  final EscrowAccount _value;
  // ignore: unused_field
  final $Res Function(EscrowAccount) _then;

  @override
  $Res call({
    Object? address = freezed,
    Object? mint = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      mint: mint == freezed
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$EscrowAccountCopyWith<$Res>
    implements $EscrowAccountCopyWith<$Res> {
  factory _$EscrowAccountCopyWith(
          _EscrowAccount value, $Res Function(_EscrowAccount) then) =
      __$EscrowAccountCopyWithImpl<$Res>;
  @override
  $Res call({Ed25519HDPublicKey address, Ed25519HDPublicKey mint, int amount});
}

/// @nodoc
class __$EscrowAccountCopyWithImpl<$Res>
    extends _$EscrowAccountCopyWithImpl<$Res>
    implements _$EscrowAccountCopyWith<$Res> {
  __$EscrowAccountCopyWithImpl(
      _EscrowAccount _value, $Res Function(_EscrowAccount) _then)
      : super(_value, (v) => _then(v as _EscrowAccount));

  @override
  _EscrowAccount get _value => super._value as _EscrowAccount;

  @override
  $Res call({
    Object? address = freezed,
    Object? mint = freezed,
    Object? amount = freezed,
  }) {
    return _then(_EscrowAccount(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      mint: mint == freezed
          ? _value.mint
          : mint // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      amount: amount == freezed
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
            other is _EscrowAccount &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.mint, mint) &&
            const DeepCollectionEquality().equals(other.amount, amount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(mint),
      const DeepCollectionEquality().hash(amount));

  @JsonKey(ignore: true)
  @override
  _$EscrowAccountCopyWith<_EscrowAccount> get copyWith =>
      __$EscrowAccountCopyWithImpl<_EscrowAccount>(this, _$identity);
}

abstract class _EscrowAccount implements EscrowAccount {
  const factory _EscrowAccount(
      {required final Ed25519HDPublicKey address,
      required final Ed25519HDPublicKey mint,
      required final int amount}) = _$_EscrowAccount;

  @override
  Ed25519HDPublicKey get address => throw _privateConstructorUsedError;
  @override
  Ed25519HDPublicKey get mint => throw _privateConstructorUsedError;
  @override
  int get amount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$EscrowAccountCopyWith<_EscrowAccount> get copyWith =>
      throw _privateConstructorUsedError;
}
