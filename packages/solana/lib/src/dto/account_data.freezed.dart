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

  BinaryAccountData fromBytes(List<int> bytes) {
    return BinaryAccountData(
      bytes,
    );
  }

  StringAccountData fromString(String string) {
    return StringAccountData(
      string,
    );
  }

  EmptyAccountData empty() {
    return const EmptyAccountData();
  }

  SplTokenAccountData splToken(ParsedSplTokenAccountData parsed) {
    return SplTokenAccountData(
      parsed,
    );
  }

  GenericAccountData generic(Map<String, dynamic> data) {
    return GenericAccountData(
      data,
    );
  }
}

/// @nodoc
const $AccountData = _$AccountDataTearOff();

/// @nodoc
mixin _$AccountData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function(String string) fromString,
    required TResult Function() empty,
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(Map<String, dynamic> data) generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(EmptyAccountData value) empty,
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(GenericAccountData value) generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
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
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function(String string) fromString,
    required TResult Function() empty,
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(Map<String, dynamic> data) generic,
  }) {
    return fromBytes(bytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
  }) {
    return fromBytes?.call(bytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
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
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(EmptyAccountData value) empty,
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(GenericAccountData value) generic,
  }) {
    return fromBytes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
  }) {
    return fromBytes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
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
abstract class $StringAccountDataCopyWith<$Res> {
  factory $StringAccountDataCopyWith(
          StringAccountData value, $Res Function(StringAccountData) then) =
      _$StringAccountDataCopyWithImpl<$Res>;
  $Res call({String string});
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
    Object? string = freezed,
  }) {
    return _then(StringAccountData(
      string == freezed
          ? _value.string
          : string // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$StringAccountData implements StringAccountData {
  const _$StringAccountData(this.string);

  @override
  final String string;

  @override
  String toString() {
    return 'AccountData.fromString(string: $string)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StringAccountData &&
            (identical(other.string, string) ||
                const DeepCollectionEquality().equals(other.string, string)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(string);

  @JsonKey(ignore: true)
  @override
  $StringAccountDataCopyWith<StringAccountData> get copyWith =>
      _$StringAccountDataCopyWithImpl<StringAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function(String string) fromString,
    required TResult Function() empty,
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(Map<String, dynamic> data) generic,
  }) {
    return fromString(string);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
  }) {
    return fromString?.call(string);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
    required TResult orElse(),
  }) {
    if (fromString != null) {
      return fromString(string);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(EmptyAccountData value) empty,
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(GenericAccountData value) generic,
  }) {
    return fromString(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
  }) {
    return fromString?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
    required TResult orElse(),
  }) {
    if (fromString != null) {
      return fromString(this);
    }
    return orElse();
  }
}

abstract class StringAccountData implements AccountData {
  const factory StringAccountData(String string) = _$StringAccountData;

  String get string => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StringAccountDataCopyWith<StringAccountData> get copyWith =>
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
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function(String string) fromString,
    required TResult Function() empty,
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(Map<String, dynamic> data) generic,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
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
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(EmptyAccountData value) empty,
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(GenericAccountData value) generic,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
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

/// @nodoc
abstract class $SplTokenAccountDataCopyWith<$Res> {
  factory $SplTokenAccountDataCopyWith(
          SplTokenAccountData value, $Res Function(SplTokenAccountData) then) =
      _$SplTokenAccountDataCopyWithImpl<$Res>;
  $Res call({ParsedSplTokenAccountData parsed});
}

/// @nodoc
class _$SplTokenAccountDataCopyWithImpl<$Res>
    extends _$AccountDataCopyWithImpl<$Res>
    implements $SplTokenAccountDataCopyWith<$Res> {
  _$SplTokenAccountDataCopyWithImpl(
      SplTokenAccountData _value, $Res Function(SplTokenAccountData) _then)
      : super(_value, (v) => _then(v as SplTokenAccountData));

  @override
  SplTokenAccountData get _value => super._value as SplTokenAccountData;

  @override
  $Res call({
    Object? parsed = freezed,
  }) {
    return _then(SplTokenAccountData(
      parsed == freezed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as ParsedSplTokenAccountData,
    ));
  }
}

/// @nodoc

class _$SplTokenAccountData implements SplTokenAccountData {
  const _$SplTokenAccountData(this.parsed);

  @override
  final ParsedSplTokenAccountData parsed;

  @override
  String toString() {
    return 'AccountData.splToken(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SplTokenAccountData &&
            (identical(other.parsed, parsed) ||
                const DeepCollectionEquality().equals(other.parsed, parsed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(parsed);

  @JsonKey(ignore: true)
  @override
  $SplTokenAccountDataCopyWith<SplTokenAccountData> get copyWith =>
      _$SplTokenAccountDataCopyWithImpl<SplTokenAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function(String string) fromString,
    required TResult Function() empty,
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(Map<String, dynamic> data) generic,
  }) {
    return splToken(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
  }) {
    return splToken?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
    required TResult orElse(),
  }) {
    if (splToken != null) {
      return splToken(parsed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(EmptyAccountData value) empty,
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(GenericAccountData value) generic,
  }) {
    return splToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
  }) {
    return splToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
    required TResult orElse(),
  }) {
    if (splToken != null) {
      return splToken(this);
    }
    return orElse();
  }
}

abstract class SplTokenAccountData implements AccountData {
  const factory SplTokenAccountData(ParsedSplTokenAccountData parsed) =
      _$SplTokenAccountData;

  ParsedSplTokenAccountData get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SplTokenAccountDataCopyWith<SplTokenAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenericAccountDataCopyWith<$Res> {
  factory $GenericAccountDataCopyWith(
          GenericAccountData value, $Res Function(GenericAccountData) then) =
      _$GenericAccountDataCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class _$GenericAccountDataCopyWithImpl<$Res>
    extends _$AccountDataCopyWithImpl<$Res>
    implements $GenericAccountDataCopyWith<$Res> {
  _$GenericAccountDataCopyWithImpl(
      GenericAccountData _value, $Res Function(GenericAccountData) _then)
      : super(_value, (v) => _then(v as GenericAccountData));

  @override
  GenericAccountData get _value => super._value as GenericAccountData;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(GenericAccountData(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$GenericAccountData implements GenericAccountData {
  const _$GenericAccountData(this.data);

  @override
  final Map<String, dynamic> data;

  @override
  String toString() {
    return 'AccountData.generic(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GenericAccountData &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $GenericAccountDataCopyWith<GenericAccountData> get copyWith =>
      _$GenericAccountDataCopyWithImpl<GenericAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> bytes) fromBytes,
    required TResult Function(String string) fromString,
    required TResult Function() empty,
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(Map<String, dynamic> data) generic,
  }) {
    return generic(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
  }) {
    return generic?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? fromBytes,
    TResult Function(String string)? fromString,
    TResult Function()? empty,
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(Map<String, dynamic> data)? generic,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) fromBytes,
    required TResult Function(StringAccountData value) fromString,
    required TResult Function(EmptyAccountData value) empty,
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(GenericAccountData value) generic,
  }) {
    return generic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
  }) {
    return generic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? fromBytes,
    TResult Function(StringAccountData value)? fromString,
    TResult Function(EmptyAccountData value)? empty,
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(GenericAccountData value)? generic,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(this);
    }
    return orElse();
  }
}

abstract class GenericAccountData implements AccountData {
  const factory GenericAccountData(Map<String, dynamic> data) =
      _$GenericAccountData;

  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenericAccountDataCopyWith<GenericAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}
