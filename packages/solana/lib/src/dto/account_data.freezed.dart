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

  ParsedAccountData jsonParsed(ParsedAccountDataParsed jsonParsed) {
    return ParsedAccountData(
      jsonParsed,
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
    required TResult Function(ParsedAccountDataParsed jsonParsed) jsonParsed,
    required TResult Function() empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(ParsedAccountDataParsed jsonParsed)? jsonParsed,
    TResult Function()? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(ParsedAccountDataParsed jsonParsed)? jsonParsed,
    TResult Function()? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) binary,
    required TResult Function(ParsedAccountData value) jsonParsed,
    required TResult Function(EmptyAccountData value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? jsonParsed,
    TResult Function(EmptyAccountData value)? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? jsonParsed,
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
    required TResult Function(ParsedAccountDataParsed jsonParsed) jsonParsed,
    required TResult Function() empty,
  }) {
    return binary(bytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(ParsedAccountDataParsed jsonParsed)? jsonParsed,
    TResult Function()? empty,
  }) {
    return binary?.call(bytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(ParsedAccountDataParsed jsonParsed)? jsonParsed,
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
    required TResult Function(ParsedAccountData value) jsonParsed,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return binary(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? jsonParsed,
    TResult Function(EmptyAccountData value)? empty,
  }) {
    return binary?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? jsonParsed,
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
  $Res call({ParsedAccountDataParsed jsonParsed});

  $ParsedAccountDataParsedCopyWith<$Res> get jsonParsed;
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
    Object? jsonParsed = freezed,
  }) {
    return _then(ParsedAccountData(
      jsonParsed == freezed
          ? _value.jsonParsed
          : jsonParsed // ignore: cast_nullable_to_non_nullable
              as ParsedAccountDataParsed,
    ));
  }

  @override
  $ParsedAccountDataParsedCopyWith<$Res> get jsonParsed {
    return $ParsedAccountDataParsedCopyWith<$Res>(_value.jsonParsed, (value) {
      return _then(_value.copyWith(jsonParsed: value));
    });
  }
}

/// @nodoc

class _$ParsedAccountData implements ParsedAccountData {
  const _$ParsedAccountData(this.jsonParsed);

  @override
  final ParsedAccountDataParsed jsonParsed;

  @override
  String toString() {
    return 'AccountData.jsonParsed(jsonParsed: $jsonParsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ParsedAccountData &&
            (identical(other.jsonParsed, jsonParsed) ||
                const DeepCollectionEquality()
                    .equals(other.jsonParsed, jsonParsed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(jsonParsed);

  @JsonKey(ignore: true)
  @override
  $ParsedAccountDataCopyWith<ParsedAccountData> get copyWith =>
      _$ParsedAccountDataCopyWithImpl<ParsedAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<int> bytes) binary,
    required TResult Function(ParsedAccountDataParsed jsonParsed) jsonParsed,
    required TResult Function() empty,
  }) {
    return jsonParsed(this.jsonParsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(ParsedAccountDataParsed jsonParsed)? jsonParsed,
    TResult Function()? empty,
  }) {
    return jsonParsed?.call(this.jsonParsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(ParsedAccountDataParsed jsonParsed)? jsonParsed,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (jsonParsed != null) {
      return jsonParsed(this.jsonParsed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BinaryAccountData value) binary,
    required TResult Function(ParsedAccountData value) jsonParsed,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return jsonParsed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? jsonParsed,
    TResult Function(EmptyAccountData value)? empty,
  }) {
    return jsonParsed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? jsonParsed,
    TResult Function(EmptyAccountData value)? empty,
    required TResult orElse(),
  }) {
    if (jsonParsed != null) {
      return jsonParsed(this);
    }
    return orElse();
  }
}

abstract class ParsedAccountData implements AccountData {
  const factory ParsedAccountData(ParsedAccountDataParsed jsonParsed) =
      _$ParsedAccountData;

  ParsedAccountDataParsed get jsonParsed => throw _privateConstructorUsedError;
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
    required TResult Function(ParsedAccountDataParsed jsonParsed) jsonParsed,
    required TResult Function() empty,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(ParsedAccountDataParsed jsonParsed)? jsonParsed,
    TResult Function()? empty,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<int> bytes)? binary,
    TResult Function(ParsedAccountDataParsed jsonParsed)? jsonParsed,
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
    required TResult Function(ParsedAccountData value) jsonParsed,
    required TResult Function(EmptyAccountData value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? jsonParsed,
    TResult Function(EmptyAccountData value)? empty,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BinaryAccountData value)? binary,
    TResult Function(ParsedAccountData value)? jsonParsed,
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

ParsedAccountDataParsed _$ParsedAccountDataParsedFromJson(
    Map<String, dynamic> json) {
  switch (json['program'] as String?) {
    case 'spl-token':
      return SplTokenAccountData.fromJson(json);

    default:
      return UnsupportedParsedAccountData.fromJson(json);
  }
}

/// @nodoc
class _$ParsedAccountDataParsedTearOff {
  const _$ParsedAccountDataParsedTearOff();

  SplTokenAccountData splToken(ParsedSplTokenAccountData parsed) {
    return SplTokenAccountData(
      parsed,
    );
  }

  UnsupportedParsedAccountData unsupported() {
    return const UnsupportedParsedAccountData();
  }

  ParsedAccountDataParsed fromJson(Map<String, Object> json) {
    return ParsedAccountDataParsed.fromJson(json);
  }
}

/// @nodoc
const $ParsedAccountDataParsed = _$ParsedAccountDataParsedTearOff();

/// @nodoc
mixin _$ParsedAccountDataParsed {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function() unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function()? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function()? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(UnsupportedParsedAccountData value) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(UnsupportedParsedAccountData value)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(UnsupportedParsedAccountData value)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedAccountDataParsedCopyWith<$Res> {
  factory $ParsedAccountDataParsedCopyWith(ParsedAccountDataParsed value,
          $Res Function(ParsedAccountDataParsed) then) =
      _$ParsedAccountDataParsedCopyWithImpl<$Res>;
}

/// @nodoc
class _$ParsedAccountDataParsedCopyWithImpl<$Res>
    implements $ParsedAccountDataParsedCopyWith<$Res> {
  _$ParsedAccountDataParsedCopyWithImpl(this._value, this._then);

  final ParsedAccountDataParsed _value;
  // ignore: unused_field
  final $Res Function(ParsedAccountDataParsed) _then;
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
    extends _$ParsedAccountDataParsedCopyWithImpl<$Res>
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
@JsonSerializable()
@FreezedUnionValue('spl-token')
class _$SplTokenAccountData implements SplTokenAccountData {
  const _$SplTokenAccountData(this.parsed);

  factory _$SplTokenAccountData.fromJson(Map<String, dynamic> json) =>
      _$$SplTokenAccountDataFromJson(json);

  @override
  final ParsedSplTokenAccountData parsed;

  @override
  String toString() {
    return 'ParsedAccountDataParsed.splToken(parsed: $parsed)';
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
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function() unsupported,
  }) {
    return splToken(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function()? unsupported,
  }) {
    return splToken?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function()? unsupported,
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
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(UnsupportedParsedAccountData value) unsupported,
  }) {
    return splToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(UnsupportedParsedAccountData value)? unsupported,
  }) {
    return splToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(UnsupportedParsedAccountData value)? unsupported,
    required TResult orElse(),
  }) {
    if (splToken != null) {
      return splToken(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SplTokenAccountDataToJson(this)..['program'] = 'spl-token';
  }
}

abstract class SplTokenAccountData implements ParsedAccountDataParsed {
  const factory SplTokenAccountData(ParsedSplTokenAccountData parsed) =
      _$SplTokenAccountData;

  factory SplTokenAccountData.fromJson(Map<String, dynamic> json) =
      _$SplTokenAccountData.fromJson;

  ParsedSplTokenAccountData get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SplTokenAccountDataCopyWith<SplTokenAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnsupportedParsedAccountDataCopyWith<$Res> {
  factory $UnsupportedParsedAccountDataCopyWith(
          UnsupportedParsedAccountData value,
          $Res Function(UnsupportedParsedAccountData) then) =
      _$UnsupportedParsedAccountDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnsupportedParsedAccountDataCopyWithImpl<$Res>
    extends _$ParsedAccountDataParsedCopyWithImpl<$Res>
    implements $UnsupportedParsedAccountDataCopyWith<$Res> {
  _$UnsupportedParsedAccountDataCopyWithImpl(
      UnsupportedParsedAccountData _value,
      $Res Function(UnsupportedParsedAccountData) _then)
      : super(_value, (v) => _then(v as UnsupportedParsedAccountData));

  @override
  UnsupportedParsedAccountData get _value =>
      super._value as UnsupportedParsedAccountData;
}

/// @nodoc
@JsonSerializable()
class _$UnsupportedParsedAccountData implements UnsupportedParsedAccountData {
  const _$UnsupportedParsedAccountData();

  factory _$UnsupportedParsedAccountData.fromJson(Map<String, dynamic> json) =>
      _$$UnsupportedParsedAccountDataFromJson(json);

  @override
  String toString() {
    return 'ParsedAccountDataParsed.unsupported()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is UnsupportedParsedAccountData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function() unsupported,
  }) {
    return unsupported();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function()? unsupported,
  }) {
    return unsupported?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function()? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SplTokenAccountData value) splToken,
    required TResult Function(UnsupportedParsedAccountData value) unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(UnsupportedParsedAccountData value)? unsupported,
  }) {
    return unsupported?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SplTokenAccountData value)? splToken,
    TResult Function(UnsupportedParsedAccountData value)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnsupportedParsedAccountDataToJson(this)
      ..['program'] = 'unsupported';
  }
}

abstract class UnsupportedParsedAccountData implements ParsedAccountDataParsed {
  const factory UnsupportedParsedAccountData() = _$UnsupportedParsedAccountData;

  factory UnsupportedParsedAccountData.fromJson(Map<String, dynamic> json) =
      _$UnsupportedParsedAccountData.fromJson;
}
