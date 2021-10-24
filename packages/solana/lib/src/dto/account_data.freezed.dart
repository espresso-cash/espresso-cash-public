// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AccountDataTearOff {
  const _$AccountDataTearOff();

  BinaryAccountData binary(List<int> bytes) {
    return BinaryAccountData(
      bytes,
    );
  }

  ParsedAccountData parsed(Map<String, dynamic> parsed) {
    return ParsedAccountData(
      parsed,
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
    required TResult Function(List<int> bytes) binary,
    required TResult Function(Map<String, dynamic> parsed) parsed,
    required TResult Function() empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(Map<String, dynamic> parsed)? parsed,
    TResult Function()? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(Map<String, dynamic> parsed)? parsed,
    TResult Function()? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) binary,
    required TResult Function(ParsedAccountData value) parsed,
    required TResult Function(EmptyAccountData value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? parsed,
    TResult Function(EmptyAccountData value)? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? parsed,
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
    return 'AccountData.binary(bytes: $bytes)';
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
    required TResult Function(List<int> bytes) binary,
    required TResult Function(Map<String, dynamic> parsed) parsed,
    required TResult Function() empty,
  }) {
    return binary(bytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(Map<String, dynamic> parsed)? parsed,
    TResult Function()? empty,
  }) {
    return binary?.call(bytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(Map<String, dynamic> parsed)? parsed,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (binary != null) {
      return binary(bytes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) binary,
    required TResult Function(ParsedAccountData value) parsed,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return binary(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? parsed,
    TResult Function(EmptyAccountData value)? empty,
  }) {
    return binary?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? parsed,
    TResult Function(EmptyAccountData value)? empty,
    required TResult orElse(),
  }) {
    if (binary != null) {
      return binary(this);
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
abstract class $ParsedAccountDataCopyWith<$Res> {
  factory $ParsedAccountDataCopyWith(
          ParsedAccountData value, $Res Function(ParsedAccountData) then) =
      _$ParsedAccountDataCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> parsed});
}

/// @nodoc
class _$ParsedAccountDataCopyWithImpl<$Res>
    extends _$AccountDataCopyWithImpl<$Res>
    implements $ParsedAccountDataCopyWith<$Res> {
  _$ParsedAccountDataCopyWithImpl(
      ParsedAccountData _value, $Res Function(ParsedAccountData) _then)
      : super(_value, (v) => _then(v as ParsedAccountData));

  @override
  ParsedAccountData get _value => super._value as ParsedAccountData;

  @override
  $Res call({
    Object? parsed = freezed,
  }) {
    return _then(ParsedAccountData(
      parsed == freezed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$ParsedAccountData implements ParsedAccountData {
  const _$ParsedAccountData(this.parsed);

  @override
  final Map<String, dynamic> parsed;

  @override
  String toString() {
    return 'AccountData.parsed(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedAccountData &&
            (identical(other.parsed, parsed) ||
                const DeepCollectionEquality().equals(other.parsed, parsed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(parsed);

  @JsonKey(ignore: true)
  @override
  $ParsedAccountDataCopyWith<ParsedAccountData> get copyWith =>
      _$ParsedAccountDataCopyWithImpl<ParsedAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> bytes) binary,
    required TResult Function(Map<String, dynamic> parsed) parsed,
    required TResult Function() empty,
  }) {
    return parsed(this.parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(Map<String, dynamic> parsed)? parsed,
    TResult Function()? empty,
  }) {
    return parsed?.call(this.parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(Map<String, dynamic> parsed)? parsed,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (parsed != null) {
      return parsed(this.parsed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) binary,
    required TResult Function(ParsedAccountData value) parsed,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return parsed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? parsed,
    TResult Function(EmptyAccountData value)? empty,
  }) {
    return parsed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? parsed,
    TResult Function(EmptyAccountData value)? empty,
    required TResult orElse(),
  }) {
    if (parsed != null) {
      return parsed(this);
    }
    return orElse();
  }
}

abstract class ParsedAccountData implements AccountData {
  const factory ParsedAccountData(Map<String, dynamic> parsed) =
      _$ParsedAccountData;

  Map<String, dynamic> get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParsedAccountDataCopyWith<ParsedAccountData> get copyWith =>
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
    required TResult Function(List<int> bytes) binary,
    required TResult Function(Map<String, dynamic> parsed) parsed,
    required TResult Function() empty,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(Map<String, dynamic> parsed)? parsed,
    TResult Function()? empty,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(Map<String, dynamic> parsed)? parsed,
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
    required TResult Function(BinaryAccountData value) binary,
    required TResult Function(ParsedAccountData value) parsed,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? parsed,
    TResult Function(EmptyAccountData value)? empty,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? parsed,
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
