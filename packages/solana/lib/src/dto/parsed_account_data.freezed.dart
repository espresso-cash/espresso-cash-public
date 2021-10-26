// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parsed_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedAccountData _$ParsedAccountDataFromJson(Map<String, dynamic> json) {
  switch (json['program'] as String?) {
    case 'spl-token':
      return SplTokenProgramAccountData.fromJson(json);
    case 'stake':
      return StakeProgramAccountData.fromJson(json);

    default:
      return UnsupportedProgramAccountData.fromJson(json);
  }
}

/// @nodoc
class _$ParsedAccountDataTearOff {
  const _$ParsedAccountDataTearOff();

  SplTokenProgramAccountData splToken(ParsedSplTokenAccountData parsed) {
    return SplTokenProgramAccountData(
      parsed,
    );
  }

  StakeProgramAccountData stake(ParsedStakeAccountData parsed) {
    return StakeProgramAccountData(
      parsed,
    );
  }

  UnsupportedProgramAccountData unsupported(Map<String, dynamic> parsed) {
    return UnsupportedProgramAccountData(
      parsed,
    );
  }

  ParsedAccountData fromJson(Map<String, Object> json) {
    return ParsedAccountData.fromJson(json);
  }
}

/// @nodoc
const $ParsedAccountData = _$ParsedAccountDataTearOff();

/// @nodoc
mixin _$ParsedAccountData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(ParsedStakeAccountData parsed) stake,
    required TResult Function(Map<String, dynamic> parsed) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(ParsedStakeAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(ParsedStakeAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SplTokenProgramAccountData value) splToken,
    required TResult Function(StakeProgramAccountData value) stake,
    required TResult Function(UnsupportedProgramAccountData value) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData value)? splToken,
    TResult Function(StakeProgramAccountData value)? stake,
    TResult Function(UnsupportedProgramAccountData value)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData value)? splToken,
    TResult Function(StakeProgramAccountData value)? stake,
    TResult Function(UnsupportedProgramAccountData value)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedAccountDataCopyWith<$Res> {
  factory $ParsedAccountDataCopyWith(
          ParsedAccountData value, $Res Function(ParsedAccountData) then) =
      _$ParsedAccountDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$ParsedAccountDataCopyWithImpl<$Res>
    implements $ParsedAccountDataCopyWith<$Res> {
  _$ParsedAccountDataCopyWithImpl(this._value, this._then);

  final ParsedAccountData _value;
  // ignore: unused_field
  final $Res Function(ParsedAccountData) _then;
}

/// @nodoc
abstract class $SplTokenProgramAccountDataCopyWith<$Res> {
  factory $SplTokenProgramAccountDataCopyWith(SplTokenProgramAccountData value,
          $Res Function(SplTokenProgramAccountData) then) =
      _$SplTokenProgramAccountDataCopyWithImpl<$Res>;
  $Res call({ParsedSplTokenAccountData parsed});

  $ParsedSplTokenAccountDataCopyWith<$Res> get parsed;
}

/// @nodoc
class _$SplTokenProgramAccountDataCopyWithImpl<$Res>
    extends _$ParsedAccountDataCopyWithImpl<$Res>
    implements $SplTokenProgramAccountDataCopyWith<$Res> {
  _$SplTokenProgramAccountDataCopyWithImpl(SplTokenProgramAccountData _value,
      $Res Function(SplTokenProgramAccountData) _then)
      : super(_value, (v) => _then(v as SplTokenProgramAccountData));

  @override
  SplTokenProgramAccountData get _value =>
      super._value as SplTokenProgramAccountData;

  @override
  $Res call({
    Object? parsed = freezed,
  }) {
    return _then(SplTokenProgramAccountData(
      parsed == freezed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as ParsedSplTokenAccountData,
    ));
  }

  @override
  $ParsedSplTokenAccountDataCopyWith<$Res> get parsed {
    return $ParsedSplTokenAccountDataCopyWith<$Res>(_value.parsed, (value) {
      return _then(_value.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('spl-token')
class _$SplTokenProgramAccountData extends SplTokenProgramAccountData {
  const _$SplTokenProgramAccountData(this.parsed) : super._();

  factory _$SplTokenProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$$SplTokenProgramAccountDataFromJson(json);

  @override
  final ParsedSplTokenAccountData parsed;

  @override
  String toString() {
    return 'ParsedAccountData.splToken(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SplTokenProgramAccountData &&
            (identical(other.parsed, parsed) ||
                const DeepCollectionEquality().equals(other.parsed, parsed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(parsed);

  @JsonKey(ignore: true)
  @override
  $SplTokenProgramAccountDataCopyWith<SplTokenProgramAccountData>
      get copyWith =>
          _$SplTokenProgramAccountDataCopyWithImpl<SplTokenProgramAccountData>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(ParsedStakeAccountData parsed) stake,
    required TResult Function(Map<String, dynamic> parsed) unsupported,
  }) {
    return splToken(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(ParsedStakeAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
  }) {
    return splToken?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(ParsedStakeAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
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
    required TResult Function(SplTokenProgramAccountData value) splToken,
    required TResult Function(StakeProgramAccountData value) stake,
    required TResult Function(UnsupportedProgramAccountData value) unsupported,
  }) {
    return splToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData value)? splToken,
    TResult Function(StakeProgramAccountData value)? stake,
    TResult Function(UnsupportedProgramAccountData value)? unsupported,
  }) {
    return splToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData value)? splToken,
    TResult Function(StakeProgramAccountData value)? stake,
    TResult Function(UnsupportedProgramAccountData value)? unsupported,
    required TResult orElse(),
  }) {
    if (splToken != null) {
      return splToken(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SplTokenProgramAccountDataToJson(this)..['program'] = 'spl-token';
  }
}

abstract class SplTokenProgramAccountData extends ParsedAccountData {
  const factory SplTokenProgramAccountData(ParsedSplTokenAccountData parsed) =
      _$SplTokenProgramAccountData;
  const SplTokenProgramAccountData._() : super._();

  factory SplTokenProgramAccountData.fromJson(Map<String, dynamic> json) =
      _$SplTokenProgramAccountData.fromJson;

  ParsedSplTokenAccountData get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SplTokenProgramAccountDataCopyWith<SplTokenProgramAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakeProgramAccountDataCopyWith<$Res> {
  factory $StakeProgramAccountDataCopyWith(StakeProgramAccountData value,
          $Res Function(StakeProgramAccountData) then) =
      _$StakeProgramAccountDataCopyWithImpl<$Res>;
  $Res call({ParsedStakeAccountData parsed});

  $ParsedStakeAccountDataCopyWith<$Res> get parsed;
}

/// @nodoc
class _$StakeProgramAccountDataCopyWithImpl<$Res>
    extends _$ParsedAccountDataCopyWithImpl<$Res>
    implements $StakeProgramAccountDataCopyWith<$Res> {
  _$StakeProgramAccountDataCopyWithImpl(StakeProgramAccountData _value,
      $Res Function(StakeProgramAccountData) _then)
      : super(_value, (v) => _then(v as StakeProgramAccountData));

  @override
  StakeProgramAccountData get _value => super._value as StakeProgramAccountData;

  @override
  $Res call({
    Object? parsed = freezed,
  }) {
    return _then(StakeProgramAccountData(
      parsed == freezed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as ParsedStakeAccountData,
    ));
  }

  @override
  $ParsedStakeAccountDataCopyWith<$Res> get parsed {
    return $ParsedStakeAccountDataCopyWith<$Res>(_value.parsed, (value) {
      return _then(_value.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$StakeProgramAccountData extends StakeProgramAccountData {
  const _$StakeProgramAccountData(this.parsed) : super._();

  factory _$StakeProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$$StakeProgramAccountDataFromJson(json);

  @override
  final ParsedStakeAccountData parsed;

  @override
  String toString() {
    return 'ParsedAccountData.stake(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StakeProgramAccountData &&
            (identical(other.parsed, parsed) ||
                const DeepCollectionEquality().equals(other.parsed, parsed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(parsed);

  @JsonKey(ignore: true)
  @override
  $StakeProgramAccountDataCopyWith<StakeProgramAccountData> get copyWith =>
      _$StakeProgramAccountDataCopyWithImpl<StakeProgramAccountData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(ParsedStakeAccountData parsed) stake,
    required TResult Function(Map<String, dynamic> parsed) unsupported,
  }) {
    return stake(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(ParsedStakeAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
  }) {
    return stake?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(ParsedStakeAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
    required TResult orElse(),
  }) {
    if (stake != null) {
      return stake(parsed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SplTokenProgramAccountData value) splToken,
    required TResult Function(StakeProgramAccountData value) stake,
    required TResult Function(UnsupportedProgramAccountData value) unsupported,
  }) {
    return stake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData value)? splToken,
    TResult Function(StakeProgramAccountData value)? stake,
    TResult Function(UnsupportedProgramAccountData value)? unsupported,
  }) {
    return stake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData value)? splToken,
    TResult Function(StakeProgramAccountData value)? stake,
    TResult Function(UnsupportedProgramAccountData value)? unsupported,
    required TResult orElse(),
  }) {
    if (stake != null) {
      return stake(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StakeProgramAccountDataToJson(this)..['program'] = 'stake';
  }
}

abstract class StakeProgramAccountData extends ParsedAccountData {
  const factory StakeProgramAccountData(ParsedStakeAccountData parsed) =
      _$StakeProgramAccountData;
  const StakeProgramAccountData._() : super._();

  factory StakeProgramAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeProgramAccountData.fromJson;

  ParsedStakeAccountData get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StakeProgramAccountDataCopyWith<StakeProgramAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnsupportedProgramAccountDataCopyWith<$Res> {
  factory $UnsupportedProgramAccountDataCopyWith(
          UnsupportedProgramAccountData value,
          $Res Function(UnsupportedProgramAccountData) then) =
      _$UnsupportedProgramAccountDataCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> parsed});
}

/// @nodoc
class _$UnsupportedProgramAccountDataCopyWithImpl<$Res>
    extends _$ParsedAccountDataCopyWithImpl<$Res>
    implements $UnsupportedProgramAccountDataCopyWith<$Res> {
  _$UnsupportedProgramAccountDataCopyWithImpl(
      UnsupportedProgramAccountData _value,
      $Res Function(UnsupportedProgramAccountData) _then)
      : super(_value, (v) => _then(v as UnsupportedProgramAccountData));

  @override
  UnsupportedProgramAccountData get _value =>
      super._value as UnsupportedProgramAccountData;

  @override
  $Res call({
    Object? parsed = freezed,
  }) {
    return _then(UnsupportedProgramAccountData(
      parsed == freezed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnsupportedProgramAccountData extends UnsupportedProgramAccountData {
  const _$UnsupportedProgramAccountData(this.parsed) : super._();

  factory _$UnsupportedProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$$UnsupportedProgramAccountDataFromJson(json);

  @override
  final Map<String, dynamic> parsed;

  @override
  String toString() {
    return 'ParsedAccountData.unsupported(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UnsupportedProgramAccountData &&
            (identical(other.parsed, parsed) ||
                const DeepCollectionEquality().equals(other.parsed, parsed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(parsed);

  @JsonKey(ignore: true)
  @override
  $UnsupportedProgramAccountDataCopyWith<UnsupportedProgramAccountData>
      get copyWith => _$UnsupportedProgramAccountDataCopyWithImpl<
          UnsupportedProgramAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParsedSplTokenAccountData parsed) splToken,
    required TResult Function(ParsedStakeAccountData parsed) stake,
    required TResult Function(Map<String, dynamic> parsed) unsupported,
  }) {
    return unsupported(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(ParsedStakeAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
  }) {
    return unsupported?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParsedSplTokenAccountData parsed)? splToken,
    TResult Function(ParsedStakeAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(parsed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SplTokenProgramAccountData value) splToken,
    required TResult Function(StakeProgramAccountData value) stake,
    required TResult Function(UnsupportedProgramAccountData value) unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData value)? splToken,
    TResult Function(StakeProgramAccountData value)? stake,
    TResult Function(UnsupportedProgramAccountData value)? unsupported,
  }) {
    return unsupported?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData value)? splToken,
    TResult Function(StakeProgramAccountData value)? stake,
    TResult Function(UnsupportedProgramAccountData value)? unsupported,
    required TResult orElse(),
  }) {
    if (unsupported != null) {
      return unsupported(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnsupportedProgramAccountDataToJson(this)
      ..['program'] = 'unsupported';
  }
}

abstract class UnsupportedProgramAccountData extends ParsedAccountData {
  const factory UnsupportedProgramAccountData(Map<String, dynamic> parsed) =
      _$UnsupportedProgramAccountData;
  const UnsupportedProgramAccountData._() : super._();

  factory UnsupportedProgramAccountData.fromJson(Map<String, dynamic> json) =
      _$UnsupportedProgramAccountData.fromJson;

  Map<String, dynamic> get parsed => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnsupportedProgramAccountDataCopyWith<UnsupportedProgramAccountData>
      get copyWith => throw _privateConstructorUsedError;
}
