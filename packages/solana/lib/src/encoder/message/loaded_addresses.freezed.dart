// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loaded_addresses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoadedAddresses {
  List<Ed25519HDPublicKey> get writable;
  List<Ed25519HDPublicKey> get readonly;

  /// Create a copy of LoadedAddresses
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoadedAddressesCopyWith<LoadedAddresses> get copyWith =>
      _$LoadedAddressesCopyWithImpl<LoadedAddresses>(this as LoadedAddresses, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoadedAddresses &&
            const DeepCollectionEquality().equals(other.writable, writable) &&
            const DeepCollectionEquality().equals(other.readonly, readonly));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(writable),
    const DeepCollectionEquality().hash(readonly),
  );

  @override
  String toString() {
    return 'LoadedAddresses(writable: $writable, readonly: $readonly)';
  }
}

/// @nodoc
abstract mixin class $LoadedAddressesCopyWith<$Res> {
  factory $LoadedAddressesCopyWith(LoadedAddresses value, $Res Function(LoadedAddresses) _then) =
      _$LoadedAddressesCopyWithImpl;
  @useResult
  $Res call({List<Ed25519HDPublicKey> writable, List<Ed25519HDPublicKey> readonly});
}

/// @nodoc
class _$LoadedAddressesCopyWithImpl<$Res> implements $LoadedAddressesCopyWith<$Res> {
  _$LoadedAddressesCopyWithImpl(this._self, this._then);

  final LoadedAddresses _self;
  final $Res Function(LoadedAddresses) _then;

  /// Create a copy of LoadedAddresses
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? writable = null, Object? readonly = null}) {
    return _then(
      _self.copyWith(
        writable:
            null == writable
                ? _self.writable
                : writable // ignore: cast_nullable_to_non_nullable
                    as List<Ed25519HDPublicKey>,
        readonly:
            null == readonly
                ? _self.readonly
                : readonly // ignore: cast_nullable_to_non_nullable
                    as List<Ed25519HDPublicKey>,
      ),
    );
  }
}

/// @nodoc

class _LoadedAddresses implements LoadedAddresses {
  const _LoadedAddresses({
    required final List<Ed25519HDPublicKey> writable,
    required final List<Ed25519HDPublicKey> readonly,
  }) : _writable = writable,
       _readonly = readonly;

  final List<Ed25519HDPublicKey> _writable;
  @override
  List<Ed25519HDPublicKey> get writable {
    if (_writable is EqualUnmodifiableListView) return _writable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_writable);
  }

  final List<Ed25519HDPublicKey> _readonly;
  @override
  List<Ed25519HDPublicKey> get readonly {
    if (_readonly is EqualUnmodifiableListView) return _readonly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readonly);
  }

  /// Create a copy of LoadedAddresses
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoadedAddressesCopyWith<_LoadedAddresses> get copyWith =>
      __$LoadedAddressesCopyWithImpl<_LoadedAddresses>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadedAddresses &&
            const DeepCollectionEquality().equals(other._writable, _writable) &&
            const DeepCollectionEquality().equals(other._readonly, _readonly));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_writable),
    const DeepCollectionEquality().hash(_readonly),
  );

  @override
  String toString() {
    return 'LoadedAddresses(writable: $writable, readonly: $readonly)';
  }
}

/// @nodoc
abstract mixin class _$LoadedAddressesCopyWith<$Res> implements $LoadedAddressesCopyWith<$Res> {
  factory _$LoadedAddressesCopyWith(_LoadedAddresses value, $Res Function(_LoadedAddresses) _then) =
      __$LoadedAddressesCopyWithImpl;
  @override
  @useResult
  $Res call({List<Ed25519HDPublicKey> writable, List<Ed25519HDPublicKey> readonly});
}

/// @nodoc
class __$LoadedAddressesCopyWithImpl<$Res> implements _$LoadedAddressesCopyWith<$Res> {
  __$LoadedAddressesCopyWithImpl(this._self, this._then);

  final _LoadedAddresses _self;
  final $Res Function(_LoadedAddresses) _then;

  /// Create a copy of LoadedAddresses
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? writable = null, Object? readonly = null}) {
    return _then(
      _LoadedAddresses(
        writable:
            null == writable
                ? _self._writable
                : writable // ignore: cast_nullable_to_non_nullable
                    as List<Ed25519HDPublicKey>,
        readonly:
            null == readonly
                ? _self._readonly
                : readonly // ignore: cast_nullable_to_non_nullable
                    as List<Ed25519HDPublicKey>,
      ),
    );
  }
}
