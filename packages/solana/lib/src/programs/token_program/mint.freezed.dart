// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Mint {
  /// Address of the mint
  Ed25519HDPublicKey get address => throw _privateConstructorUsedError;

  /// Total supply of tokens.
  BigInt get supply => throw _privateConstructorUsedError;

  /// Number of base 10 digits to the right of the decimal place.
  int get decimals => throw _privateConstructorUsedError;

  /// Optional authority used to mint new tokens.
  ///
  /// The mint authority may only be provided during mint creation. If no mint
  /// authority is present then the mint has a fixed supply and no further
  /// tokens may be minted.
  Ed25519HDPublicKey? get mintAuthority => throw _privateConstructorUsedError;

  /// Is this mint initialized
  bool get isInitialized => throw _privateConstructorUsedError;

  /// Optional authority to freeze token accounts.
  Ed25519HDPublicKey? get freezeAuthority => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MintCopyWith<Mint> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MintCopyWith<$Res> {
  factory $MintCopyWith(Mint value, $Res Function(Mint) then) =
      _$MintCopyWithImpl<$Res>;
  $Res call(
      {Ed25519HDPublicKey address,
      BigInt supply,
      int decimals,
      Ed25519HDPublicKey? mintAuthority,
      bool isInitialized,
      Ed25519HDPublicKey? freezeAuthority});
}

/// @nodoc
class _$MintCopyWithImpl<$Res> implements $MintCopyWith<$Res> {
  _$MintCopyWithImpl(this._value, this._then);

  final Mint _value;
  // ignore: unused_field
  final $Res Function(Mint) _then;

  @override
  $Res call({
    Object? address = freezed,
    Object? supply = freezed,
    Object? decimals = freezed,
    Object? mintAuthority = freezed,
    Object? isInitialized = freezed,
    Object? freezeAuthority = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      supply: supply == freezed
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as BigInt,
      decimals: decimals == freezed
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      mintAuthority: mintAuthority == freezed
          ? _value.mintAuthority
          : mintAuthority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
      isInitialized: isInitialized == freezed
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      freezeAuthority: freezeAuthority == freezed
          ? _value.freezeAuthority
          : freezeAuthority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
    ));
  }
}

/// @nodoc
abstract class _$$_MintCopyWith<$Res> implements $MintCopyWith<$Res> {
  factory _$$_MintCopyWith(_$_Mint value, $Res Function(_$_Mint) then) =
      __$$_MintCopyWithImpl<$Res>;
  @override
  $Res call(
      {Ed25519HDPublicKey address,
      BigInt supply,
      int decimals,
      Ed25519HDPublicKey? mintAuthority,
      bool isInitialized,
      Ed25519HDPublicKey? freezeAuthority});
}

/// @nodoc
class __$$_MintCopyWithImpl<$Res> extends _$MintCopyWithImpl<$Res>
    implements _$$_MintCopyWith<$Res> {
  __$$_MintCopyWithImpl(_$_Mint _value, $Res Function(_$_Mint) _then)
      : super(_value, (v) => _then(v as _$_Mint));

  @override
  _$_Mint get _value => super._value as _$_Mint;

  @override
  $Res call({
    Object? address = freezed,
    Object? supply = freezed,
    Object? decimals = freezed,
    Object? mintAuthority = freezed,
    Object? isInitialized = freezed,
    Object? freezeAuthority = freezed,
  }) {
    return _then(_$_Mint(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      supply: supply == freezed
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as BigInt,
      decimals: decimals == freezed
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      mintAuthority: mintAuthority == freezed
          ? _value.mintAuthority
          : mintAuthority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
      isInitialized: isInitialized == freezed
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      freezeAuthority: freezeAuthority == freezed
          ? _value.freezeAuthority
          : freezeAuthority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
    ));
  }
}

/// @nodoc

class _$_Mint implements _Mint {
  const _$_Mint(
      {required this.address,
      required this.supply,
      required this.decimals,
      this.mintAuthority,
      required this.isInitialized,
      this.freezeAuthority});

  /// Address of the mint
  @override
  final Ed25519HDPublicKey address;

  /// Total supply of tokens.
  @override
  final BigInt supply;

  /// Number of base 10 digits to the right of the decimal place.
  @override
  final int decimals;

  /// Optional authority used to mint new tokens.
  ///
  /// The mint authority may only be provided during mint creation. If no mint
  /// authority is present then the mint has a fixed supply and no further
  /// tokens may be minted.
  @override
  final Ed25519HDPublicKey? mintAuthority;

  /// Is this mint initialized
  @override
  final bool isInitialized;

  /// Optional authority to freeze token accounts.
  @override
  final Ed25519HDPublicKey? freezeAuthority;

  @override
  String toString() {
    return 'Mint(address: $address, supply: $supply, decimals: $decimals, mintAuthority: $mintAuthority, isInitialized: $isInitialized, freezeAuthority: $freezeAuthority)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Mint &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.supply, supply) &&
            const DeepCollectionEquality().equals(other.decimals, decimals) &&
            const DeepCollectionEquality()
                .equals(other.mintAuthority, mintAuthority) &&
            const DeepCollectionEquality()
                .equals(other.isInitialized, isInitialized) &&
            const DeepCollectionEquality()
                .equals(other.freezeAuthority, freezeAuthority));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(supply),
      const DeepCollectionEquality().hash(decimals),
      const DeepCollectionEquality().hash(mintAuthority),
      const DeepCollectionEquality().hash(isInitialized),
      const DeepCollectionEquality().hash(freezeAuthority));

  @JsonKey(ignore: true)
  @override
  _$$_MintCopyWith<_$_Mint> get copyWith =>
      __$$_MintCopyWithImpl<_$_Mint>(this, _$identity);
}

abstract class _Mint implements Mint {
  const factory _Mint(
      {required final Ed25519HDPublicKey address,
      required final BigInt supply,
      required final int decimals,
      final Ed25519HDPublicKey? mintAuthority,
      required final bool isInitialized,
      final Ed25519HDPublicKey? freezeAuthority}) = _$_Mint;

  @override

  /// Address of the mint
  Ed25519HDPublicKey get address => throw _privateConstructorUsedError;
  @override

  /// Total supply of tokens.
  BigInt get supply => throw _privateConstructorUsedError;
  @override

  /// Number of base 10 digits to the right of the decimal place.
  int get decimals => throw _privateConstructorUsedError;
  @override

  /// Optional authority used to mint new tokens.
  ///
  /// The mint authority may only be provided during mint creation. If no mint
  /// authority is present then the mint has a fixed supply and no further
  /// tokens may be minted.
  Ed25519HDPublicKey? get mintAuthority => throw _privateConstructorUsedError;
  @override

  /// Is this mint initialized
  bool get isInitialized => throw _privateConstructorUsedError;
  @override

  /// Optional authority to freeze token accounts.
  Ed25519HDPublicKey? get freezeAuthority => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MintCopyWith<_$_Mint> get copyWith => throw _privateConstructorUsedError;
}
