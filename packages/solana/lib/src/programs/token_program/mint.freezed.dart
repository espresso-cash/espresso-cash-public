// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Mint {
  /// Address of the mint
  Ed25519HDPublicKey get address;

  /// Total supply of tokens.
  BigInt get supply;

  /// Number of base 10 digits to the right of the decimal place.
  int get decimals;

  /// Optional authority used to mint new tokens.
  ///
  /// The mint authority may only be provided during mint creation. If no mint
  /// authority is present then the mint has a fixed supply and no further
  /// tokens may be minted.
  Ed25519HDPublicKey? get mintAuthority;

  /// Is this mint initialized
  bool get isInitialized;

  /// Optional authority to freeze token accounts.
  Ed25519HDPublicKey? get freezeAuthority;

  /// Create a copy of Mint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MintCopyWith<Mint> get copyWith => _$MintCopyWithImpl<Mint>(this as Mint, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Mint &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.supply, supply) || other.supply == supply) &&
            (identical(other.decimals, decimals) || other.decimals == decimals) &&
            (identical(other.mintAuthority, mintAuthority) ||
                other.mintAuthority == mintAuthority) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.freezeAuthority, freezeAuthority) ||
                other.freezeAuthority == freezeAuthority));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    address,
    supply,
    decimals,
    mintAuthority,
    isInitialized,
    freezeAuthority,
  );

  @override
  String toString() {
    return 'Mint(address: $address, supply: $supply, decimals: $decimals, mintAuthority: $mintAuthority, isInitialized: $isInitialized, freezeAuthority: $freezeAuthority)';
  }
}

/// @nodoc
abstract mixin class $MintCopyWith<$Res> {
  factory $MintCopyWith(Mint value, $Res Function(Mint) _then) = _$MintCopyWithImpl;
  @useResult
  $Res call({
    Ed25519HDPublicKey address,
    BigInt supply,
    int decimals,
    Ed25519HDPublicKey? mintAuthority,
    bool isInitialized,
    Ed25519HDPublicKey? freezeAuthority,
  });
}

/// @nodoc
class _$MintCopyWithImpl<$Res> implements $MintCopyWith<$Res> {
  _$MintCopyWithImpl(this._self, this._then);

  final Mint _self;
  final $Res Function(Mint) _then;

  /// Create a copy of Mint
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(
      _self.copyWith(
        address:
            null == address
                ? _self.address
                : address // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey,
        supply:
            null == supply
                ? _self.supply
                : supply // ignore: cast_nullable_to_non_nullable
                    as BigInt,
        decimals:
            null == decimals
                ? _self.decimals
                : decimals // ignore: cast_nullable_to_non_nullable
                    as int,
        mintAuthority:
            freezed == mintAuthority
                ? _self.mintAuthority
                : mintAuthority // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey?,
        isInitialized:
            null == isInitialized
                ? _self.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                    as bool,
        freezeAuthority:
            freezed == freezeAuthority
                ? _self.freezeAuthority
                : freezeAuthority // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey?,
      ),
    );
  }
}

/// @nodoc

class _Mint implements Mint {
  const _Mint({
    required this.address,
    required this.supply,
    required this.decimals,
    this.mintAuthority,
    required this.isInitialized,
    this.freezeAuthority,
  });

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

  /// Create a copy of Mint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MintCopyWith<_Mint> get copyWith => __$MintCopyWithImpl<_Mint>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Mint &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.supply, supply) || other.supply == supply) &&
            (identical(other.decimals, decimals) || other.decimals == decimals) &&
            (identical(other.mintAuthority, mintAuthority) ||
                other.mintAuthority == mintAuthority) &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.freezeAuthority, freezeAuthority) ||
                other.freezeAuthority == freezeAuthority));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    address,
    supply,
    decimals,
    mintAuthority,
    isInitialized,
    freezeAuthority,
  );

  @override
  String toString() {
    return 'Mint(address: $address, supply: $supply, decimals: $decimals, mintAuthority: $mintAuthority, isInitialized: $isInitialized, freezeAuthority: $freezeAuthority)';
  }
}

/// @nodoc
abstract mixin class _$MintCopyWith<$Res> implements $MintCopyWith<$Res> {
  factory _$MintCopyWith(_Mint value, $Res Function(_Mint) _then) = __$MintCopyWithImpl;
  @override
  @useResult
  $Res call({
    Ed25519HDPublicKey address,
    BigInt supply,
    int decimals,
    Ed25519HDPublicKey? mintAuthority,
    bool isInitialized,
    Ed25519HDPublicKey? freezeAuthority,
  });
}

/// @nodoc
class __$MintCopyWithImpl<$Res> implements _$MintCopyWith<$Res> {
  __$MintCopyWithImpl(this._self, this._then);

  final _Mint _self;
  final $Res Function(_Mint) _then;

  /// Create a copy of Mint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? address = null,
    Object? supply = null,
    Object? decimals = null,
    Object? mintAuthority = freezed,
    Object? isInitialized = null,
    Object? freezeAuthority = freezed,
  }) {
    return _then(
      _Mint(
        address:
            null == address
                ? _self.address
                : address // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey,
        supply:
            null == supply
                ? _self.supply
                : supply // ignore: cast_nullable_to_non_nullable
                    as BigInt,
        decimals:
            null == decimals
                ? _self.decimals
                : decimals // ignore: cast_nullable_to_non_nullable
                    as int,
        mintAuthority:
            freezed == mintAuthority
                ? _self.mintAuthority
                : mintAuthority // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey?,
        isInitialized:
            null == isInitialized
                ? _self.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                    as bool,
        freezeAuthority:
            freezed == freezeAuthority
                ? _self.freezeAuthority
                : freezeAuthority // ignore: cast_nullable_to_non_nullable
                    as Ed25519HDPublicKey?,
      ),
    );
  }
}
