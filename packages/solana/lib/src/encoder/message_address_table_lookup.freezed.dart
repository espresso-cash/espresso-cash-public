// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$MessageAddressTableLookupCopyWithImpl<$Res>;
  $Res call(
      {Ed25519HDPublicKey accountKey,
      List<int> writableIndexes,
      List<int> readonlyIndexes});
}

/// @nodoc
class _$MessageAddressTableLookupCopyWithImpl<$Res>
    implements $MessageAddressTableLookupCopyWith<$Res> {
  _$MessageAddressTableLookupCopyWithImpl(this._value, this._then);

  final MessageAddressTableLookup _value;
  // ignore: unused_field
  final $Res Function(MessageAddressTableLookup) _then;

  @override
  $Res call({
    Object? accountKey = freezed,
    Object? writableIndexes = freezed,
    Object? readonlyIndexes = freezed,
  }) {
    return _then(_value.copyWith(
      accountKey: accountKey == freezed
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      writableIndexes: writableIndexes == freezed
          ? _value.writableIndexes
          : writableIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      readonlyIndexes: readonlyIndexes == freezed
          ? _value.readonlyIndexes
          : readonlyIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
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
  $Res call(
      {Ed25519HDPublicKey accountKey,
      List<int> writableIndexes,
      List<int> readonlyIndexes});
}

/// @nodoc
class __$$_MessageAddressTableLookupCopyWithImpl<$Res>
    extends _$MessageAddressTableLookupCopyWithImpl<$Res>
    implements _$$_MessageAddressTableLookupCopyWith<$Res> {
  __$$_MessageAddressTableLookupCopyWithImpl(
      _$_MessageAddressTableLookup _value,
      $Res Function(_$_MessageAddressTableLookup) _then)
      : super(_value, (v) => _then(v as _$_MessageAddressTableLookup));

  @override
  _$_MessageAddressTableLookup get _value =>
      super._value as _$_MessageAddressTableLookup;

  @override
  $Res call({
    Object? accountKey = freezed,
    Object? writableIndexes = freezed,
    Object? readonlyIndexes = freezed,
  }) {
    return _then(_$_MessageAddressTableLookup(
      accountKey: accountKey == freezed
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as Ed25519HDPublicKey,
      writableIndexes: writableIndexes == freezed
          ? _value._writableIndexes
          : writableIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      readonlyIndexes: readonlyIndexes == freezed
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
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_writableIndexes);
  }

  final List<int> _readonlyIndexes;
  @override
  List<int> get readonlyIndexes {
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
            const DeepCollectionEquality()
                .equals(other.accountKey, accountKey) &&
            const DeepCollectionEquality()
                .equals(other._writableIndexes, _writableIndexes) &&
            const DeepCollectionEquality()
                .equals(other._readonlyIndexes, _readonlyIndexes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(accountKey),
      const DeepCollectionEquality().hash(_writableIndexes),
      const DeepCollectionEquality().hash(_readonlyIndexes));

  @JsonKey(ignore: true)
  @override
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

/// @nodoc
mixin _$MessageCompiledInstruction {
  int get programIdIndex => throw _privateConstructorUsedError;
  List<int> get accountKeyIndexes => throw _privateConstructorUsedError;
  ByteArray get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageCompiledInstructionCopyWith<MessageCompiledInstruction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCompiledInstructionCopyWith<$Res> {
  factory $MessageCompiledInstructionCopyWith(MessageCompiledInstruction value,
          $Res Function(MessageCompiledInstruction) then) =
      _$MessageCompiledInstructionCopyWithImpl<$Res>;
  $Res call({int programIdIndex, List<int> accountKeyIndexes, ByteArray data});
}

/// @nodoc
class _$MessageCompiledInstructionCopyWithImpl<$Res>
    implements $MessageCompiledInstructionCopyWith<$Res> {
  _$MessageCompiledInstructionCopyWithImpl(this._value, this._then);

  final MessageCompiledInstruction _value;
  // ignore: unused_field
  final $Res Function(MessageCompiledInstruction) _then;

  @override
  $Res call({
    Object? programIdIndex = freezed,
    Object? accountKeyIndexes = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      programIdIndex: programIdIndex == freezed
          ? _value.programIdIndex
          : programIdIndex // ignore: cast_nullable_to_non_nullable
              as int,
      accountKeyIndexes: accountKeyIndexes == freezed
          ? _value.accountKeyIndexes
          : accountKeyIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ByteArray,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageCompiledInstructionCopyWith<$Res>
    implements $MessageCompiledInstructionCopyWith<$Res> {
  factory _$$_MessageCompiledInstructionCopyWith(
          _$_MessageCompiledInstruction value,
          $Res Function(_$_MessageCompiledInstruction) then) =
      __$$_MessageCompiledInstructionCopyWithImpl<$Res>;
  @override
  $Res call({int programIdIndex, List<int> accountKeyIndexes, ByteArray data});
}

/// @nodoc
class __$$_MessageCompiledInstructionCopyWithImpl<$Res>
    extends _$MessageCompiledInstructionCopyWithImpl<$Res>
    implements _$$_MessageCompiledInstructionCopyWith<$Res> {
  __$$_MessageCompiledInstructionCopyWithImpl(
      _$_MessageCompiledInstruction _value,
      $Res Function(_$_MessageCompiledInstruction) _then)
      : super(_value, (v) => _then(v as _$_MessageCompiledInstruction));

  @override
  _$_MessageCompiledInstruction get _value =>
      super._value as _$_MessageCompiledInstruction;

  @override
  $Res call({
    Object? programIdIndex = freezed,
    Object? accountKeyIndexes = freezed,
    Object? data = freezed,
  }) {
    return _then(_$_MessageCompiledInstruction(
      programIdIndex: programIdIndex == freezed
          ? _value.programIdIndex
          : programIdIndex // ignore: cast_nullable_to_non_nullable
              as int,
      accountKeyIndexes: accountKeyIndexes == freezed
          ? _value._accountKeyIndexes
          : accountKeyIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ByteArray,
    ));
  }
}

/// @nodoc

class _$_MessageCompiledInstruction implements _MessageCompiledInstruction {
  const _$_MessageCompiledInstruction(
      {required this.programIdIndex,
      required final List<int> accountKeyIndexes,
      required this.data})
      : _accountKeyIndexes = accountKeyIndexes;

  @override
  final int programIdIndex;
  final List<int> _accountKeyIndexes;
  @override
  List<int> get accountKeyIndexes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accountKeyIndexes);
  }

  @override
  final ByteArray data;

  @override
  String toString() {
    return 'MessageCompiledInstruction(programIdIndex: $programIdIndex, accountKeyIndexes: $accountKeyIndexes, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageCompiledInstruction &&
            const DeepCollectionEquality()
                .equals(other.programIdIndex, programIdIndex) &&
            const DeepCollectionEquality()
                .equals(other._accountKeyIndexes, _accountKeyIndexes) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(programIdIndex),
      const DeepCollectionEquality().hash(_accountKeyIndexes),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$_MessageCompiledInstructionCopyWith<_$_MessageCompiledInstruction>
      get copyWith => __$$_MessageCompiledInstructionCopyWithImpl<
          _$_MessageCompiledInstruction>(this, _$identity);
}

abstract class _MessageCompiledInstruction
    implements MessageCompiledInstruction {
  const factory _MessageCompiledInstruction(
      {required final int programIdIndex,
      required final List<int> accountKeyIndexes,
      required final ByteArray data}) = _$_MessageCompiledInstruction;

  @override
  int get programIdIndex;
  @override
  List<int> get accountKeyIndexes;
  @override
  ByteArray get data;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCompiledInstructionCopyWith<_$_MessageCompiledInstruction>
      get copyWith => throw _privateConstructorUsedError;
}
