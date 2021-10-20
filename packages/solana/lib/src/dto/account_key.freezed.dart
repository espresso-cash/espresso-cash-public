// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'account_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AccountKey _$AccountKeyFromJson(Map<String, dynamic> json) {
  return _AccountKey.fromJson(json);
}

/// @nodoc
class _$AccountKeyTearOff {
  const _$AccountKeyTearOff();

  _AccountKey call(
      {required String pubkey, required bool writable, required bool signer}) {
    return _AccountKey(
      pubkey: pubkey,
      writable: writable,
      signer: signer,
    );
  }

  AccountKey fromJson(Map<String, Object> json) {
    return AccountKey.fromJson(json);
  }
}

/// @nodoc
const $AccountKey = _$AccountKeyTearOff();

/// @nodoc
mixin _$AccountKey {
  String get pubkey => throw _privateConstructorUsedError;
  bool get writable => throw _privateConstructorUsedError;
  bool get signer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountKeyCopyWith<AccountKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountKeyCopyWith<$Res> {
  factory $AccountKeyCopyWith(
          AccountKey value, $Res Function(AccountKey) then) =
      _$AccountKeyCopyWithImpl<$Res>;
  $Res call({String pubkey, bool writable, bool signer});
}

/// @nodoc
class _$AccountKeyCopyWithImpl<$Res> implements $AccountKeyCopyWith<$Res> {
  _$AccountKeyCopyWithImpl(this._value, this._then);

  final AccountKey _value;
  // ignore: unused_field
  final $Res Function(AccountKey) _then;

  @override
  $Res call({
    Object? pubkey = freezed,
    Object? writable = freezed,
    Object? signer = freezed,
  }) {
    return _then(_value.copyWith(
      pubkey: pubkey == freezed
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      writable: writable == freezed
          ? _value.writable
          : writable // ignore: cast_nullable_to_non_nullable
              as bool,
      signer: signer == freezed
          ? _value.signer
          : signer // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$AccountKeyCopyWith<$Res> implements $AccountKeyCopyWith<$Res> {
  factory _$AccountKeyCopyWith(
          _AccountKey value, $Res Function(_AccountKey) then) =
      __$AccountKeyCopyWithImpl<$Res>;
  @override
  $Res call({String pubkey, bool writable, bool signer});
}

/// @nodoc
class __$AccountKeyCopyWithImpl<$Res> extends _$AccountKeyCopyWithImpl<$Res>
    implements _$AccountKeyCopyWith<$Res> {
  __$AccountKeyCopyWithImpl(
      _AccountKey _value, $Res Function(_AccountKey) _then)
      : super(_value, (v) => _then(v as _AccountKey));

  @override
  _AccountKey get _value => super._value as _AccountKey;

  @override
  $Res call({
    Object? pubkey = freezed,
    Object? writable = freezed,
    Object? signer = freezed,
  }) {
    return _then(_AccountKey(
      pubkey: pubkey == freezed
          ? _value.pubkey
          : pubkey // ignore: cast_nullable_to_non_nullable
              as String,
      writable: writable == freezed
          ? _value.writable
          : writable // ignore: cast_nullable_to_non_nullable
              as bool,
      signer: signer == freezed
          ? _value.signer
          : signer // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AccountKey implements _AccountKey {
  const _$_AccountKey(
      {required this.pubkey, required this.writable, required this.signer});

  factory _$_AccountKey.fromJson(Map<String, dynamic> json) =>
      _$$_AccountKeyFromJson(json);

  @override
  final String pubkey;
  @override
  final bool writable;
  @override
  final bool signer;

  @override
  String toString() {
    return 'AccountKey(pubkey: $pubkey, writable: $writable, signer: $signer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AccountKey &&
            (identical(other.pubkey, pubkey) ||
                const DeepCollectionEquality().equals(other.pubkey, pubkey)) &&
            (identical(other.writable, writable) ||
                const DeepCollectionEquality()
                    .equals(other.writable, writable)) &&
            (identical(other.signer, signer) ||
                const DeepCollectionEquality().equals(other.signer, signer)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(pubkey) ^
      const DeepCollectionEquality().hash(writable) ^
      const DeepCollectionEquality().hash(signer);

  @JsonKey(ignore: true)
  @override
  _$AccountKeyCopyWith<_AccountKey> get copyWith =>
      __$AccountKeyCopyWithImpl<_AccountKey>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccountKeyToJson(this);
  }
}

abstract class _AccountKey implements AccountKey {
  const factory _AccountKey(
      {required String pubkey,
      required bool writable,
      required bool signer}) = _$_AccountKey;

  factory _AccountKey.fromJson(Map<String, dynamic> json) =
      _$_AccountKey.fromJson;

  @override
  String get pubkey => throw _privateConstructorUsedError;
  @override
  bool get writable => throw _privateConstructorUsedError;
  @override
  bool get signer => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AccountKeyCopyWith<_AccountKey> get copyWith =>
      throw _privateConstructorUsedError;
}
