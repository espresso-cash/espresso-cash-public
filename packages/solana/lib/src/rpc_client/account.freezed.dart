// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AccountDataTearOff {
  const _$AccountDataTearOff();

  StringAccountData fromString(String value) {
    return StringAccountData(
      value,
    );
  }

  BinaryAccountData fromBytes(List<int> bytes) {
    return BinaryAccountData(
      bytes,
    );
  }

  EmptyAccountData empty() {
    return const EmptyAccountData();
  }
}

/// @nodoc
const $AccountData = _$AccountDataTearOff();

/// @nodoc
mixin _$AccountData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) fromString,
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function() empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? fromString,
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function()? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(EmptyAccountData value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringAccountData value)? fromString,
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(EmptyAccountData value)? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountDataCopyWith<$Res> {
  factory $AccountDataCopyWith(
          AccountData value, $Res Function(AccountData) then) =
      _$AccountDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$AccountDataCopyWithImpl<$Res> implements $AccountDataCopyWith<$Res> {
  _$AccountDataCopyWithImpl(this._value, this._then);

  final AccountData _value;
  // ignore: unused_field
  final $Res Function(AccountData) _then;
}

/// @nodoc
abstract class $StringAccountDataCopyWith<$Res> {
  factory $StringAccountDataCopyWith(
          StringAccountData value, $Res Function(StringAccountData) then) =
      _$StringAccountDataCopyWithImpl<$Res>;
  $Res call({String value});
}

/// @nodoc
class _$StringAccountDataCopyWithImpl<$Res>
    extends _$AccountDataCopyWithImpl<$Res>
    implements $StringAccountDataCopyWith<$Res> {
  _$StringAccountDataCopyWithImpl(
      StringAccountData _value, $Res Function(StringAccountData) _then)
      : super(_value, (v) => _then(v as StringAccountData));

  @override
  StringAccountData get _value => super._value as StringAccountData;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(StringAccountData(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StringAccountData implements StringAccountData {
  const _$StringAccountData(this.value);

  @override
  final String value;

  @override
  String toString() {
    return 'AccountData.fromString(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StringAccountData &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  $StringAccountDataCopyWith<StringAccountData> get copyWith =>
      _$StringAccountDataCopyWithImpl<StringAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) fromString,
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function() empty,
  }) {
    return fromString(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? fromString,
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (fromString != null) {
      return fromString(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return fromString(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringAccountData value)? fromString,
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(EmptyAccountData value)? empty,
    required TResult orElse(),
  }) {
    if (fromString != null) {
      return fromString(this);
    }
    return orElse();
  }
}

abstract class StringAccountData implements AccountData {
  const factory StringAccountData(String value) = _$StringAccountData;

  String get value => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StringAccountDataCopyWith<StringAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BinaryAccountDataCopyWith<$Res> {
  factory $BinaryAccountDataCopyWith(
          BinaryAccountData value, $Res Function(BinaryAccountData) then) =
      _$BinaryAccountDataCopyWithImpl<$Res>;
  $Res call({List<int> bytes});
}

/// @nodoc
class _$BinaryAccountDataCopyWithImpl<$Res>
    extends _$AccountDataCopyWithImpl<$Res>
    implements $BinaryAccountDataCopyWith<$Res> {
  _$BinaryAccountDataCopyWithImpl(
      BinaryAccountData _value, $Res Function(BinaryAccountData) _then)
      : super(_value, (v) => _then(v as BinaryAccountData));

  @override
  BinaryAccountData get _value => super._value as BinaryAccountData;

  @override
  $Res call({
    Object? bytes = freezed,
  }) {
    return _then(BinaryAccountData(
      bytes == freezed
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

class _$BinaryAccountData implements BinaryAccountData {
  const _$BinaryAccountData(this.bytes);

  @override
  final List<int> bytes;

  @override
  String toString() {
    return 'AccountData.fromBytes(bytes: $bytes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BinaryAccountData &&
            (identical(other.bytes, bytes) ||
                const DeepCollectionEquality().equals(other.bytes, bytes)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(bytes);

  @JsonKey(ignore: true)
  @override
  $BinaryAccountDataCopyWith<BinaryAccountData> get copyWith =>
      _$BinaryAccountDataCopyWithImpl<BinaryAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) fromString,
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function() empty,
  }) {
    return fromBytes(bytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? fromString,
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (fromBytes != null) {
      return fromBytes(bytes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return fromBytes(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringAccountData value)? fromString,
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(EmptyAccountData value)? empty,
    required TResult orElse(),
  }) {
    if (fromBytes != null) {
      return fromBytes(this);
    }
    return orElse();
  }
}

abstract class BinaryAccountData implements AccountData {
  const factory BinaryAccountData(List<int> bytes) = _$BinaryAccountData;

  List<int> get bytes => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BinaryAccountDataCopyWith<BinaryAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmptyAccountDataCopyWith<$Res> {
  factory $EmptyAccountDataCopyWith(
          EmptyAccountData value, $Res Function(EmptyAccountData) then) =
      _$EmptyAccountDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$EmptyAccountDataCopyWithImpl<$Res>
    extends _$AccountDataCopyWithImpl<$Res>
    implements $EmptyAccountDataCopyWith<$Res> {
  _$EmptyAccountDataCopyWithImpl(
      EmptyAccountData _value, $Res Function(EmptyAccountData) _then)
      : super(_value, (v) => _then(v as EmptyAccountData));

  @override
  EmptyAccountData get _value => super._value as EmptyAccountData;
}

/// @nodoc

class _$EmptyAccountData implements EmptyAccountData {
  const _$EmptyAccountData();

  @override
  String toString() {
    return 'AccountData.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is EmptyAccountData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) fromString,
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function() empty,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? fromString,
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StringAccountData value)? fromString,
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(EmptyAccountData value)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class EmptyAccountData implements AccountData {
  const factory EmptyAccountData() = _$EmptyAccountData;
}
