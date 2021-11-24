// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'parsed_stake_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParsedStakeAccountData _$ParsedStakeAccountDataFromJson(
    Map<String, dynamic> json) {
  switch (json['type'] as String?) {
    case 'delegated':
      return StakeDelegatedAccountData.fromJson(json);

    default:
      return StakeUnknownAccountData.fromJson(json);
  }
}

/// @nodoc
class _$ParsedStakeAccountDataTearOff {
  const _$ParsedStakeAccountDataTearOff();

  StakeDelegatedAccountData delegated(
      {required StakeDelegatedAccountInfo info}) {
    return StakeDelegatedAccountData(
      info: info,
    );
  }

  StakeUnknownAccountData unknown(Map<String, dynamic> data) {
    return StakeUnknownAccountData(
      data,
    );
  }

  ParsedStakeAccountData fromJson(Map<String, Object> json) {
    return ParsedStakeAccountData.fromJson(json);
  }
}

/// @nodoc
const $ParsedStakeAccountData = _$ParsedStakeAccountDataTearOff();

/// @nodoc
mixin _$ParsedStakeAccountData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(Map<String, dynamic> data) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic> data)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic> data)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountData value) delegated,
    required TResult Function(StakeUnknownAccountData value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountData value)? delegated,
    TResult Function(StakeUnknownAccountData value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountData value)? delegated,
    TResult Function(StakeUnknownAccountData value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParsedStakeAccountDataCopyWith<$Res> {
  factory $ParsedStakeAccountDataCopyWith(ParsedStakeAccountData value,
          $Res Function(ParsedStakeAccountData) then) =
      _$ParsedStakeAccountDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$ParsedStakeAccountDataCopyWithImpl<$Res>
    implements $ParsedStakeAccountDataCopyWith<$Res> {
  _$ParsedStakeAccountDataCopyWithImpl(this._value, this._then);

  final ParsedStakeAccountData _value;
  // ignore: unused_field
  final $Res Function(ParsedStakeAccountData) _then;
}

/// @nodoc
abstract class $StakeDelegatedAccountDataCopyWith<$Res> {
  factory $StakeDelegatedAccountDataCopyWith(StakeDelegatedAccountData value,
          $Res Function(StakeDelegatedAccountData) then) =
      _$StakeDelegatedAccountDataCopyWithImpl<$Res>;
  $Res call({StakeDelegatedAccountInfo info});
}

/// @nodoc
class _$StakeDelegatedAccountDataCopyWithImpl<$Res>
    extends _$ParsedStakeAccountDataCopyWithImpl<$Res>
    implements $StakeDelegatedAccountDataCopyWith<$Res> {
  _$StakeDelegatedAccountDataCopyWithImpl(StakeDelegatedAccountData _value,
      $Res Function(StakeDelegatedAccountData) _then)
      : super(_value, (v) => _then(v as StakeDelegatedAccountData));

  @override
  StakeDelegatedAccountData get _value =>
      super._value as StakeDelegatedAccountData;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(StakeDelegatedAccountData(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as StakeDelegatedAccountInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StakeDelegatedAccountData implements StakeDelegatedAccountData {
  const _$StakeDelegatedAccountData({required this.info});

  factory _$StakeDelegatedAccountData.fromJson(Map<String, dynamic> json) =>
      _$$StakeDelegatedAccountDataFromJson(json);

  @override
  final StakeDelegatedAccountInfo info;

  @override
  String toString() {
    return 'ParsedStakeAccountData.delegated(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StakeDelegatedAccountData &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(info);

  @JsonKey(ignore: true)
  @override
  $StakeDelegatedAccountDataCopyWith<StakeDelegatedAccountData> get copyWith =>
      _$StakeDelegatedAccountDataCopyWithImpl<StakeDelegatedAccountData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(Map<String, dynamic> data) unknown,
  }) {
    return delegated(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic> data)? unknown,
  }) {
    return delegated?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic> data)? unknown,
    required TResult orElse(),
  }) {
    if (delegated != null) {
      return delegated(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountData value) delegated,
    required TResult Function(StakeUnknownAccountData value) unknown,
  }) {
    return delegated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountData value)? delegated,
    TResult Function(StakeUnknownAccountData value)? unknown,
  }) {
    return delegated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountData value)? delegated,
    TResult Function(StakeUnknownAccountData value)? unknown,
    required TResult orElse(),
  }) {
    if (delegated != null) {
      return delegated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StakeDelegatedAccountDataToJson(this)..['type'] = 'delegated';
  }
}

abstract class StakeDelegatedAccountData implements ParsedStakeAccountData {
  const factory StakeDelegatedAccountData(
      {required StakeDelegatedAccountInfo info}) = _$StakeDelegatedAccountData;

  factory StakeDelegatedAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeDelegatedAccountData.fromJson;

  StakeDelegatedAccountInfo get info => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StakeDelegatedAccountDataCopyWith<StakeDelegatedAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakeUnknownAccountDataCopyWith<$Res> {
  factory $StakeUnknownAccountDataCopyWith(StakeUnknownAccountData value,
          $Res Function(StakeUnknownAccountData) then) =
      _$StakeUnknownAccountDataCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class _$StakeUnknownAccountDataCopyWithImpl<$Res>
    extends _$ParsedStakeAccountDataCopyWithImpl<$Res>
    implements $StakeUnknownAccountDataCopyWith<$Res> {
  _$StakeUnknownAccountDataCopyWithImpl(StakeUnknownAccountData _value,
      $Res Function(StakeUnknownAccountData) _then)
      : super(_value, (v) => _then(v as StakeUnknownAccountData));

  @override
  StakeUnknownAccountData get _value => super._value as StakeUnknownAccountData;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(StakeUnknownAccountData(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StakeUnknownAccountData implements StakeUnknownAccountData {
  const _$StakeUnknownAccountData(this.data);

  factory _$StakeUnknownAccountData.fromJson(Map<String, dynamic> json) =>
      _$$StakeUnknownAccountDataFromJson(json);

  @override
  final Map<String, dynamic> data;

  @override
  String toString() {
    return 'ParsedStakeAccountData.unknown(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StakeUnknownAccountData &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $StakeUnknownAccountDataCopyWith<StakeUnknownAccountData> get copyWith =>
      _$StakeUnknownAccountDataCopyWithImpl<StakeUnknownAccountData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(Map<String, dynamic> data) unknown,
  }) {
    return unknown(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic> data)? unknown,
  }) {
    return unknown?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic> data)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountData value) delegated,
    required TResult Function(StakeUnknownAccountData value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountData value)? delegated,
    TResult Function(StakeUnknownAccountData value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountData value)? delegated,
    TResult Function(StakeUnknownAccountData value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StakeUnknownAccountDataToJson(this)..['type'] = 'unknown';
  }
}

abstract class StakeUnknownAccountData implements ParsedStakeAccountData {
  const factory StakeUnknownAccountData(Map<String, dynamic> data) =
      _$StakeUnknownAccountData;

  factory StakeUnknownAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeUnknownAccountData.fromJson;

  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StakeUnknownAccountDataCopyWith<StakeUnknownAccountData> get copyWith =>
      throw _privateConstructorUsedError;
}
