// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parsed_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedAccountData _$ParsedAccountDataFromJson(Map<String, dynamic> json) {
  switch (json['program']) {
    case 'spl-token':
      return ParsedSplTokenProgramAccountData.fromJson(json);
    case 'stake':
      return ParsedStakeProgramAccountData.fromJson(json);

    default:
      return UnsupportedProgramAccountData.fromJson(json);
  }
}

/// @nodoc
mixin _$ParsedAccountData {
  Object get parsed => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SplTokenProgramAccountData parsed) splToken,
    required TResult Function(StakeProgramAccountData parsed) stake,
    required TResult Function(Map<String, dynamic> parsed) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SplTokenProgramAccountData parsed)? splToken,
    TResult? Function(StakeProgramAccountData parsed)? stake,
    TResult? Function(Map<String, dynamic> parsed)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData parsed)? splToken,
    TResult Function(StakeProgramAccountData parsed)? stake,
    TResult Function(Map<String, dynamic> parsed)? unsupported,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ParsedSplTokenProgramAccountData value) splToken,
    required TResult Function(ParsedStakeProgramAccountData value) stake,
    required TResult Function(UnsupportedProgramAccountData value) unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParsedSplTokenProgramAccountData value)? splToken,
    TResult? Function(ParsedStakeProgramAccountData value)? stake,
    TResult? Function(UnsupportedProgramAccountData value)? unsupported,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenProgramAccountData value)? splToken,
    TResult Function(ParsedStakeProgramAccountData value)? stake,
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
      _$ParsedAccountDataCopyWithImpl<$Res, ParsedAccountData>;
}

/// @nodoc
class _$ParsedAccountDataCopyWithImpl<$Res, $Val extends ParsedAccountData>
    implements $ParsedAccountDataCopyWith<$Res> {
  _$ParsedAccountDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ParsedSplTokenProgramAccountDataCopyWith<$Res> {
  factory _$$ParsedSplTokenProgramAccountDataCopyWith(
          _$ParsedSplTokenProgramAccountData value,
          $Res Function(_$ParsedSplTokenProgramAccountData) then) =
      __$$ParsedSplTokenProgramAccountDataCopyWithImpl<$Res>;
  @useResult
  $Res call({SplTokenProgramAccountData parsed});

  $SplTokenProgramAccountDataCopyWith<$Res> get parsed;
}

/// @nodoc
class __$$ParsedSplTokenProgramAccountDataCopyWithImpl<$Res>
    extends _$ParsedAccountDataCopyWithImpl<$Res,
        _$ParsedSplTokenProgramAccountData>
    implements _$$ParsedSplTokenProgramAccountDataCopyWith<$Res> {
  __$$ParsedSplTokenProgramAccountDataCopyWithImpl(
      _$ParsedSplTokenProgramAccountData _value,
      $Res Function(_$ParsedSplTokenProgramAccountData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parsed = null,
  }) {
    return _then(_$ParsedSplTokenProgramAccountData(
      null == parsed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as SplTokenProgramAccountData,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SplTokenProgramAccountDataCopyWith<$Res> get parsed {
    return $SplTokenProgramAccountDataCopyWith<$Res>(_value.parsed, (value) {
      return _then(_value.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedSplTokenProgramAccountData
    implements ParsedSplTokenProgramAccountData {
  const _$ParsedSplTokenProgramAccountData(this.parsed, {final String? $type})
      : $type = $type ?? 'spl-token';

  factory _$ParsedSplTokenProgramAccountData.fromJson(
          Map<String, dynamic> json) =>
      _$$ParsedSplTokenProgramAccountDataFromJson(json);

  @override
  final SplTokenProgramAccountData parsed;

  @JsonKey(name: 'program')
  final String $type;

  @override
  String toString() {
    return 'ParsedAccountData.splToken(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedSplTokenProgramAccountData &&
            (identical(other.parsed, parsed) || other.parsed == parsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, parsed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedSplTokenProgramAccountDataCopyWith<
          _$ParsedSplTokenProgramAccountData>
      get copyWith => __$$ParsedSplTokenProgramAccountDataCopyWithImpl<
          _$ParsedSplTokenProgramAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SplTokenProgramAccountData parsed) splToken,
    required TResult Function(StakeProgramAccountData parsed) stake,
    required TResult Function(Map<String, dynamic> parsed) unsupported,
  }) {
    return splToken(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SplTokenProgramAccountData parsed)? splToken,
    TResult? Function(StakeProgramAccountData parsed)? stake,
    TResult? Function(Map<String, dynamic> parsed)? unsupported,
  }) {
    return splToken?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData parsed)? splToken,
    TResult Function(StakeProgramAccountData parsed)? stake,
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
    required TResult Function(ParsedSplTokenProgramAccountData value) splToken,
    required TResult Function(ParsedStakeProgramAccountData value) stake,
    required TResult Function(UnsupportedProgramAccountData value) unsupported,
  }) {
    return splToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParsedSplTokenProgramAccountData value)? splToken,
    TResult? Function(ParsedStakeProgramAccountData value)? stake,
    TResult? Function(UnsupportedProgramAccountData value)? unsupported,
  }) {
    return splToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenProgramAccountData value)? splToken,
    TResult Function(ParsedStakeProgramAccountData value)? stake,
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
    return _$$ParsedSplTokenProgramAccountDataToJson(
      this,
    );
  }
}

abstract class ParsedSplTokenProgramAccountData implements ParsedAccountData {
  const factory ParsedSplTokenProgramAccountData(
          final SplTokenProgramAccountData parsed) =
      _$ParsedSplTokenProgramAccountData;

  factory ParsedSplTokenProgramAccountData.fromJson(Map<String, dynamic> json) =
      _$ParsedSplTokenProgramAccountData.fromJson;

  @override
  SplTokenProgramAccountData get parsed;
  @JsonKey(ignore: true)
  _$$ParsedSplTokenProgramAccountDataCopyWith<
          _$ParsedSplTokenProgramAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParsedStakeProgramAccountDataCopyWith<$Res> {
  factory _$$ParsedStakeProgramAccountDataCopyWith(
          _$ParsedStakeProgramAccountData value,
          $Res Function(_$ParsedStakeProgramAccountData) then) =
      __$$ParsedStakeProgramAccountDataCopyWithImpl<$Res>;
  @useResult
  $Res call({StakeProgramAccountData parsed});

  $StakeProgramAccountDataCopyWith<$Res> get parsed;
}

/// @nodoc
class __$$ParsedStakeProgramAccountDataCopyWithImpl<$Res>
    extends _$ParsedAccountDataCopyWithImpl<$Res,
        _$ParsedStakeProgramAccountData>
    implements _$$ParsedStakeProgramAccountDataCopyWith<$Res> {
  __$$ParsedStakeProgramAccountDataCopyWithImpl(
      _$ParsedStakeProgramAccountData _value,
      $Res Function(_$ParsedStakeProgramAccountData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parsed = null,
  }) {
    return _then(_$ParsedStakeProgramAccountData(
      null == parsed
          ? _value.parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as StakeProgramAccountData,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $StakeProgramAccountDataCopyWith<$Res> get parsed {
    return $StakeProgramAccountDataCopyWith<$Res>(_value.parsed, (value) {
      return _then(_value.copyWith(parsed: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ParsedStakeProgramAccountData implements ParsedStakeProgramAccountData {
  const _$ParsedStakeProgramAccountData(this.parsed, {final String? $type})
      : $type = $type ?? 'stake';

  factory _$ParsedStakeProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$$ParsedStakeProgramAccountDataFromJson(json);

  @override
  final StakeProgramAccountData parsed;

  @JsonKey(name: 'program')
  final String $type;

  @override
  String toString() {
    return 'ParsedAccountData.stake(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParsedStakeProgramAccountData &&
            (identical(other.parsed, parsed) || other.parsed == parsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, parsed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParsedStakeProgramAccountDataCopyWith<_$ParsedStakeProgramAccountData>
      get copyWith => __$$ParsedStakeProgramAccountDataCopyWithImpl<
          _$ParsedStakeProgramAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SplTokenProgramAccountData parsed) splToken,
    required TResult Function(StakeProgramAccountData parsed) stake,
    required TResult Function(Map<String, dynamic> parsed) unsupported,
  }) {
    return stake(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SplTokenProgramAccountData parsed)? splToken,
    TResult? Function(StakeProgramAccountData parsed)? stake,
    TResult? Function(Map<String, dynamic> parsed)? unsupported,
  }) {
    return stake?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData parsed)? splToken,
    TResult Function(StakeProgramAccountData parsed)? stake,
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
    required TResult Function(ParsedSplTokenProgramAccountData value) splToken,
    required TResult Function(ParsedStakeProgramAccountData value) stake,
    required TResult Function(UnsupportedProgramAccountData value) unsupported,
  }) {
    return stake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParsedSplTokenProgramAccountData value)? splToken,
    TResult? Function(ParsedStakeProgramAccountData value)? stake,
    TResult? Function(UnsupportedProgramAccountData value)? unsupported,
  }) {
    return stake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenProgramAccountData value)? splToken,
    TResult Function(ParsedStakeProgramAccountData value)? stake,
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
    return _$$ParsedStakeProgramAccountDataToJson(
      this,
    );
  }
}

abstract class ParsedStakeProgramAccountData implements ParsedAccountData {
  const factory ParsedStakeProgramAccountData(
      final StakeProgramAccountData parsed) = _$ParsedStakeProgramAccountData;

  factory ParsedStakeProgramAccountData.fromJson(Map<String, dynamic> json) =
      _$ParsedStakeProgramAccountData.fromJson;

  @override
  StakeProgramAccountData get parsed;
  @JsonKey(ignore: true)
  _$$ParsedStakeProgramAccountDataCopyWith<_$ParsedStakeProgramAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnsupportedProgramAccountDataCopyWith<$Res> {
  factory _$$UnsupportedProgramAccountDataCopyWith(
          _$UnsupportedProgramAccountData value,
          $Res Function(_$UnsupportedProgramAccountData) then) =
      __$$UnsupportedProgramAccountDataCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> parsed});
}

/// @nodoc
class __$$UnsupportedProgramAccountDataCopyWithImpl<$Res>
    extends _$ParsedAccountDataCopyWithImpl<$Res,
        _$UnsupportedProgramAccountData>
    implements _$$UnsupportedProgramAccountDataCopyWith<$Res> {
  __$$UnsupportedProgramAccountDataCopyWithImpl(
      _$UnsupportedProgramAccountData _value,
      $Res Function(_$UnsupportedProgramAccountData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parsed = null,
  }) {
    return _then(_$UnsupportedProgramAccountData(
      null == parsed
          ? _value._parsed
          : parsed // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnsupportedProgramAccountData implements UnsupportedProgramAccountData {
  const _$UnsupportedProgramAccountData(final Map<String, dynamic> parsed,
      {final String? $type})
      : _parsed = parsed,
        $type = $type ?? 'unsupported';

  factory _$UnsupportedProgramAccountData.fromJson(Map<String, dynamic> json) =>
      _$$UnsupportedProgramAccountDataFromJson(json);

  final Map<String, dynamic> _parsed;
  @override
  Map<String, dynamic> get parsed {
    if (_parsed is EqualUnmodifiableMapView) return _parsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parsed);
  }

  @JsonKey(name: 'program')
  final String $type;

  @override
  String toString() {
    return 'ParsedAccountData.unsupported(parsed: $parsed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnsupportedProgramAccountData &&
            const DeepCollectionEquality().equals(other._parsed, _parsed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_parsed));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnsupportedProgramAccountDataCopyWith<_$UnsupportedProgramAccountData>
      get copyWith => __$$UnsupportedProgramAccountDataCopyWithImpl<
          _$UnsupportedProgramAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SplTokenProgramAccountData parsed) splToken,
    required TResult Function(StakeProgramAccountData parsed) stake,
    required TResult Function(Map<String, dynamic> parsed) unsupported,
  }) {
    return unsupported(parsed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SplTokenProgramAccountData parsed)? splToken,
    TResult? Function(StakeProgramAccountData parsed)? stake,
    TResult? Function(Map<String, dynamic> parsed)? unsupported,
  }) {
    return unsupported?.call(parsed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SplTokenProgramAccountData parsed)? splToken,
    TResult Function(StakeProgramAccountData parsed)? stake,
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
    required TResult Function(ParsedSplTokenProgramAccountData value) splToken,
    required TResult Function(ParsedStakeProgramAccountData value) stake,
    required TResult Function(UnsupportedProgramAccountData value) unsupported,
  }) {
    return unsupported(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ParsedSplTokenProgramAccountData value)? splToken,
    TResult? Function(ParsedStakeProgramAccountData value)? stake,
    TResult? Function(UnsupportedProgramAccountData value)? unsupported,
  }) {
    return unsupported?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ParsedSplTokenProgramAccountData value)? splToken,
    TResult Function(ParsedStakeProgramAccountData value)? stake,
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
    return _$$UnsupportedProgramAccountDataToJson(
      this,
    );
  }
}

abstract class UnsupportedProgramAccountData implements ParsedAccountData {
  const factory UnsupportedProgramAccountData(
      final Map<String, dynamic> parsed) = _$UnsupportedProgramAccountData;

  factory UnsupportedProgramAccountData.fromJson(Map<String, dynamic> json) =
      _$UnsupportedProgramAccountData.fromJson;

  @override
  Map<String, dynamic> get parsed;
  @JsonKey(ignore: true)
  _$$UnsupportedProgramAccountDataCopyWith<_$UnsupportedProgramAccountData>
      get copyWith => throw _privateConstructorUsedError;
}
