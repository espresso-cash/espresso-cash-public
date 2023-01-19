// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'loaded_addresses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoadedAddresses {
  List<Ed25519HDPublicKey> get writable => throw _privateConstructorUsedError;
  List<Ed25519HDPublicKey> get readonly => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoadedAddressesCopyWith<LoadedAddresses> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadedAddressesCopyWith<$Res> {
  factory $LoadedAddressesCopyWith(
          LoadedAddresses value, $Res Function(LoadedAddresses) then) =
      _$LoadedAddressesCopyWithImpl<$Res>;
  $Res call(
      {List<Ed25519HDPublicKey> writable, List<Ed25519HDPublicKey> readonly});
}

/// @nodoc
class _$LoadedAddressesCopyWithImpl<$Res>
    implements $LoadedAddressesCopyWith<$Res> {
  _$LoadedAddressesCopyWithImpl(this._value, this._then);

  final LoadedAddresses _value;
  // ignore: unused_field
  final $Res Function(LoadedAddresses) _then;

  @override
  $Res call({
    Object? writable = freezed,
    Object? readonly = freezed,
  }) {
    return _then(_value.copyWith(
      writable: writable == freezed
          ? _value.writable
          : writable // ignore: cast_nullable_to_non_nullable
              as List<Ed25519HDPublicKey>,
      readonly: readonly == freezed
          ? _value.readonly
          : readonly // ignore: cast_nullable_to_non_nullable
              as List<Ed25519HDPublicKey>,
    ));
  }
}

/// @nodoc
abstract class _$$_LoadedAddressesCopyWith<$Res>
    implements $LoadedAddressesCopyWith<$Res> {
  factory _$$_LoadedAddressesCopyWith(
          _$_LoadedAddresses value, $Res Function(_$_LoadedAddresses) then) =
      __$$_LoadedAddressesCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Ed25519HDPublicKey> writable, List<Ed25519HDPublicKey> readonly});
}

/// @nodoc
class __$$_LoadedAddressesCopyWithImpl<$Res>
    extends _$LoadedAddressesCopyWithImpl<$Res>
    implements _$$_LoadedAddressesCopyWith<$Res> {
  __$$_LoadedAddressesCopyWithImpl(
      _$_LoadedAddresses _value, $Res Function(_$_LoadedAddresses) _then)
      : super(_value, (v) => _then(v as _$_LoadedAddresses));

  @override
  _$_LoadedAddresses get _value => super._value as _$_LoadedAddresses;

  @override
  $Res call({
    Object? writable = freezed,
    Object? readonly = freezed,
  }) {
    return _then(_$_LoadedAddresses(
      writable: writable == freezed
          ? _value._writable
          : writable // ignore: cast_nullable_to_non_nullable
              as List<Ed25519HDPublicKey>,
      readonly: readonly == freezed
          ? _value._readonly
          : readonly // ignore: cast_nullable_to_non_nullable
              as List<Ed25519HDPublicKey>,
    ));
  }
}

/// @nodoc

class _$_LoadedAddresses implements _LoadedAddresses {
  const _$_LoadedAddresses(
      {required final List<Ed25519HDPublicKey> writable,
      required final List<Ed25519HDPublicKey> readonly})
      : _writable = writable,
        _readonly = readonly;

  final List<Ed25519HDPublicKey> _writable;
  @override
  List<Ed25519HDPublicKey> get writable {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_writable);
  }

  final List<Ed25519HDPublicKey> _readonly;
  @override
  List<Ed25519HDPublicKey> get readonly {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readonly);
  }

  @override
  String toString() {
    return 'LoadedAddresses(writable: $writable, readonly: $readonly)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoadedAddresses &&
            const DeepCollectionEquality().equals(other._writable, _writable) &&
            const DeepCollectionEquality().equals(other._readonly, _readonly));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_writable),
      const DeepCollectionEquality().hash(_readonly));

  @JsonKey(ignore: true)
  @override
  _$$_LoadedAddressesCopyWith<_$_LoadedAddresses> get copyWith =>
      __$$_LoadedAddressesCopyWithImpl<_$_LoadedAddresses>(this, _$identity);
}

abstract class _LoadedAddresses implements LoadedAddresses {
  const factory _LoadedAddresses(
      {required final List<Ed25519HDPublicKey> writable,
      required final List<Ed25519HDPublicKey> readonly}) = _$_LoadedAddresses;

  @override
  List<Ed25519HDPublicKey> get writable;
  @override
  List<Ed25519HDPublicKey> get readonly;
  @override
  @JsonKey(ignore: true)
  _$$_LoadedAddressesCopyWith<_$_LoadedAddresses> get copyWith =>
      throw _privateConstructorUsedError;
}
