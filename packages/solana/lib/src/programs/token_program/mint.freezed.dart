// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
      _$MintCopyWithImpl<$Res, Mint>;
  @useResult
  $Res call(
      {Ed25519HDPublicKey address,
      BigInt supply,
      int decimals,
      Ed25519HDPublicKey? mintAuthority,
      bool isInitialized,
      Ed25519HDPublicKey? freezeAuthority});
}

/// @nodoc
class _$MintCopyWithImpl<$Res, $Val extends Mint>
    implements $MintCopyWith<$Res> {
  _$MintCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? supply = null,
    Object? decimals = null,
    Object? mintAuthority = freezed,
    Object? isInitialized = null,
    Object? freezeAuthority = freezed,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      supply: null == supply
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as BigInt,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      mintAuthority: freezed == mintAuthority
          ? _value.mintAuthority
          : mintAuthority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      freezeAuthority: freezed == freezeAuthority
          ? _value.freezeAuthority
          : freezeAuthority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MintCopyWith<$Res> implements $MintCopyWith<$Res> {
  factory _$$_MintCopyWith(_$_Mint value, $Res Function(_$_Mint) then) =
      __$$_MintCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Ed25519HDPublicKey address,
      BigInt supply,
      int decimals,
      Ed25519HDPublicKey? mintAuthority,
      bool isInitialized,
      Ed25519HDPublicKey? freezeAuthority});
}

/// @nodoc
class __$$_MintCopyWithImpl<$Res> extends _$MintCopyWithImpl<$Res, _$_Mint>
    implements _$$_MintCopyWith<$Res> {
  __$$_MintCopyWithImpl(_$_Mint _value, $Res Function(_$_Mint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? supply = null,
    Object? decimals = null,
    Object? mintAuthority = freezed,
    Object? isInitialized = null,
    Object? freezeAuthority = freezed,
  }) {
    return _then(_$_Mint(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      supply: null == supply
          ? _value.supply
          : supply // ignore: cast_nullable_to_non_nullable
              as BigInt,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      mintAuthority: freezed == mintAuthority
          ? _value.mintAuthority
          : mintAuthority // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey?,
      isInitialized: null == isInitialized
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      freezeAuthority: freezed == freezeAuthority
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
            (identical(other.address, address) || other.address == address) &&
            (identical(other.supply, supply) || other.supply == supply) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.mintAuthority, mintAuthority) ||
                other.mintAuthority == mintAuthority) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.freezeAuthority, freezeAuthority) ||
                other.freezeAuthority == freezeAuthority));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, supply, decimals,
      mintAuthority, isInitialized, freezeAuthority);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
  Ed25519HDPublicKey get address;
  @override

  /// Total supply of tokens.
  BigInt get supply;
  @override

  /// Number of base 10 digits to the right of the decimal place.
  int get decimals;
  @override

  /// Optional authority used to mint new tokens.
  ///
  /// The mint authority may only be provided during mint creation. If no mint
  /// authority is present then the mint has a fixed supply and no further
  /// tokens may be minted.
  Ed25519HDPublicKey? get mintAuthority;
  @override

  /// Is this mint initialized
  bool get isInitialized;
  @override

  /// Optional authority to freeze token accounts.
  Ed25519HDPublicKey? get freezeAuthority;
  @override
  @JsonKey(ignore: true)
  _$$_MintCopyWith<_$_Mint> get copyWith => throw _privateConstructorUsedError;
}
