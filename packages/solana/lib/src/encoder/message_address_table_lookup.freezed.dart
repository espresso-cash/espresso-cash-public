// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_address_table_lookup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessageAddressTableLookup {
  Ed25519HDPublicKey get accountKey => throw _privateConstructorUsedError;
  List<int> get writableIndexes => throw _privateConstructorUsedError;
  List<int> get readonlyIndexes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageAddressTableLookupCopyWith<MessageAddressTableLookup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageAddressTableLookupCopyWith<$Res> {
  factory $MessageAddressTableLookupCopyWith(MessageAddressTableLookup value,
          $Res Function(MessageAddressTableLookup) then) =
      _$MessageAddressTableLookupCopyWithImpl<$Res, MessageAddressTableLookup>;
  @useResult
  $Res call(
      {Ed25519HDPublicKey accountKey,
      List<int> writableIndexes,
      List<int> readonlyIndexes});
}

/// @nodoc
class _$MessageAddressTableLookupCopyWithImpl<$Res,
        $Val extends MessageAddressTableLookup>
    implements $MessageAddressTableLookupCopyWith<$Res> {
  _$MessageAddressTableLookupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountKey = null,
    Object? writableIndexes = null,
    Object? readonlyIndexes = null,
  }) {
    return _then(_value.copyWith(
      accountKey: null == accountKey
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      writableIndexes: null == writableIndexes
          ? _value.writableIndexes
          : writableIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      readonlyIndexes: null == readonlyIndexes
          ? _value.readonlyIndexes
          : readonlyIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageAddressTableLookupCopyWith<$Res>
    implements $MessageAddressTableLookupCopyWith<$Res> {
  factory _$$_MessageAddressTableLookupCopyWith(
          _$_MessageAddressTableLookup value,
          $Res Function(_$_MessageAddressTableLookup) then) =
      __$$_MessageAddressTableLookupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Ed25519HDPublicKey accountKey,
      List<int> writableIndexes,
      List<int> readonlyIndexes});
}

/// @nodoc
class __$$_MessageAddressTableLookupCopyWithImpl<$Res>
    extends _$MessageAddressTableLookupCopyWithImpl<$Res,
        _$_MessageAddressTableLookup>
    implements _$$_MessageAddressTableLookupCopyWith<$Res> {
  __$$_MessageAddressTableLookupCopyWithImpl(
      _$_MessageAddressTableLookup _value,
      $Res Function(_$_MessageAddressTableLookup) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountKey = null,
    Object? writableIndexes = null,
    Object? readonlyIndexes = null,
  }) {
    return _then(_$_MessageAddressTableLookup(
      accountKey: null == accountKey
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      writableIndexes: null == writableIndexes
          ? _value._writableIndexes
          : writableIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      readonlyIndexes: null == readonlyIndexes
          ? _value._readonlyIndexes
          : readonlyIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$_MessageAddressTableLookup implements _MessageAddressTableLookup {
  const _$_MessageAddressTableLookup(
      {required this.accountKey,
      required final List<int> writableIndexes,
      required final List<int> readonlyIndexes})
      : _writableIndexes = writableIndexes,
        _readonlyIndexes = readonlyIndexes;

  @override
  final Ed25519HDPublicKey accountKey;
  final List<int> _writableIndexes;
  @override
  List<int> get writableIndexes {
    if (_writableIndexes is EqualUnmodifiableListView) return _writableIndexes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_writableIndexes);
  }

  final List<int> _readonlyIndexes;
  @override
  List<int> get readonlyIndexes {
    if (_readonlyIndexes is EqualUnmodifiableListView) return _readonlyIndexes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_readonlyIndexes);
  }

  @override
  String toString() {
    return 'MessageAddressTableLookup(accountKey: $accountKey, writableIndexes: $writableIndexes, readonlyIndexes: $readonlyIndexes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageAddressTableLookup &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey) &&
            const DeepCollectionEquality()
                .equals(other._writableIndexes, _writableIndexes) &&
            const DeepCollectionEquality()
                .equals(other._readonlyIndexes, _readonlyIndexes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      accountKey,
      const DeepCollectionEquality().hash(_writableIndexes),
      const DeepCollectionEquality().hash(_readonlyIndexes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageAddressTableLookupCopyWith<_$_MessageAddressTableLookup>
      get copyWith => __$$_MessageAddressTableLookupCopyWithImpl<
          _$_MessageAddressTableLookup>(this, _$identity);
}

abstract class _MessageAddressTableLookup implements MessageAddressTableLookup {
  const factory _MessageAddressTableLookup(
      {required final Ed25519HDPublicKey accountKey,
      required final List<int> writableIndexes,
      required final List<int> readonlyIndexes}) = _$_MessageAddressTableLookup;

  @override
  Ed25519HDPublicKey get accountKey;
  @override
  List<int> get writableIndexes;
  @override
  List<int> get readonlyIndexes;
  @override
  @JsonKey(ignore: true)
  _$$_MessageAddressTableLookupCopyWith<_$_MessageAddressTableLookup>
      get copyWith => throw _privateConstructorUsedError;
}
