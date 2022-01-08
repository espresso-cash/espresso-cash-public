// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'stake_program_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StakeProgramAccountData _$StakeProgramAccountDataFromJson(
    Map<String, dynamic> json) {
  switch (json['type'] as String?) {
    case 'delegated':
      return StakeProgramDelegatedAccountData.fromJson(json);

    default:
      return StakeProgramUnknownAccountData.fromJson(json);
  }
}

/// @nodoc
class _$StakeProgramAccountDataTearOff {
  const _$StakeProgramAccountDataTearOff();

  StakeProgramDelegatedAccountData delegated(
      {required StakeDelegatedAccountInfo info}) {
    return StakeProgramDelegatedAccountData(
      info: info,
    );
  }

  StakeProgramUnknownAccountData unknown(Map<String, dynamic>? data) {
    return StakeProgramUnknownAccountData(
      data,
    );
  }

  StakeProgramAccountData fromJson(Map<String, Object> json) {
    return StakeProgramAccountData.fromJson(json);
  }
}

/// @nodoc
const $StakeProgramAccountData = _$StakeProgramAccountDataTearOff();

/// @nodoc
mixin _$StakeProgramAccountData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(Map<String, dynamic>? data) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic>? data)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic>? data)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StakeProgramDelegatedAccountData value) delegated,
    required TResult Function(StakeProgramUnknownAccountData value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakeProgramAccountDataCopyWith<$Res> {
  factory $StakeProgramAccountDataCopyWith(StakeProgramAccountData value,
          $Res Function(StakeProgramAccountData) then) =
      _$StakeProgramAccountDataCopyWithImpl<$Res>;
}

/// @nodoc
class _$StakeProgramAccountDataCopyWithImpl<$Res>
    implements $StakeProgramAccountDataCopyWith<$Res> {
  _$StakeProgramAccountDataCopyWithImpl(this._value, this._then);

  final StakeProgramAccountData _value;
  // ignore: unused_field
  final $Res Function(StakeProgramAccountData) _then;
}

/// @nodoc
abstract class $StakeProgramDelegatedAccountDataCopyWith<$Res> {
  factory $StakeProgramDelegatedAccountDataCopyWith(
          StakeProgramDelegatedAccountData value,
          $Res Function(StakeProgramDelegatedAccountData) then) =
      _$StakeProgramDelegatedAccountDataCopyWithImpl<$Res>;
  $Res call({StakeDelegatedAccountInfo info});
}

/// @nodoc
class _$StakeProgramDelegatedAccountDataCopyWithImpl<$Res>
    extends _$StakeProgramAccountDataCopyWithImpl<$Res>
    implements $StakeProgramDelegatedAccountDataCopyWith<$Res> {
  _$StakeProgramDelegatedAccountDataCopyWithImpl(
      StakeProgramDelegatedAccountData _value,
      $Res Function(StakeProgramDelegatedAccountData) _then)
      : super(_value, (v) => _then(v as StakeProgramDelegatedAccountData));

  @override
  StakeProgramDelegatedAccountData get _value =>
      super._value as StakeProgramDelegatedAccountData;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(StakeProgramDelegatedAccountData(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as StakeDelegatedAccountInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StakeProgramDelegatedAccountData
    implements StakeProgramDelegatedAccountData {
  const _$StakeProgramDelegatedAccountData({required this.info});

  factory _$StakeProgramDelegatedAccountData.fromJson(
          Map<String, dynamic> json) =>
      _$$StakeProgramDelegatedAccountDataFromJson(json);

  @override
  final StakeDelegatedAccountInfo info;

  @override
  String toString() {
    return 'StakeProgramAccountData.delegated(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StakeProgramDelegatedAccountData &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(info);

  @JsonKey(ignore: true)
  @override
  $StakeProgramDelegatedAccountDataCopyWith<StakeProgramDelegatedAccountData>
      get copyWith => _$StakeProgramDelegatedAccountDataCopyWithImpl<
          StakeProgramDelegatedAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(Map<String, dynamic>? data) unknown,
  }) {
    return delegated(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic>? data)? unknown,
  }) {
    return delegated?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic>? data)? unknown,
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
    required TResult Function(StakeProgramDelegatedAccountData value) delegated,
    required TResult Function(StakeProgramUnknownAccountData value) unknown,
  }) {
    return delegated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
  }) {
    return delegated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
    required TResult orElse(),
  }) {
    if (delegated != null) {
      return delegated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StakeProgramDelegatedAccountDataToJson(this)
      ..['type'] = 'delegated';
  }
}

abstract class StakeProgramDelegatedAccountData
    implements StakeProgramAccountData {
  const factory StakeProgramDelegatedAccountData(
          {required StakeDelegatedAccountInfo info}) =
      _$StakeProgramDelegatedAccountData;

  factory StakeProgramDelegatedAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeProgramDelegatedAccountData.fromJson;

  StakeDelegatedAccountInfo get info => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StakeProgramDelegatedAccountDataCopyWith<StakeProgramDelegatedAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakeProgramUnknownAccountDataCopyWith<$Res> {
  factory $StakeProgramUnknownAccountDataCopyWith(
          StakeProgramUnknownAccountData value,
          $Res Function(StakeProgramUnknownAccountData) then) =
      _$StakeProgramUnknownAccountDataCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic>? data});
}

/// @nodoc
class _$StakeProgramUnknownAccountDataCopyWithImpl<$Res>
    extends _$StakeProgramAccountDataCopyWithImpl<$Res>
    implements $StakeProgramUnknownAccountDataCopyWith<$Res> {
  _$StakeProgramUnknownAccountDataCopyWithImpl(
      StakeProgramUnknownAccountData _value,
      $Res Function(StakeProgramUnknownAccountData) _then)
      : super(_value, (v) => _then(v as StakeProgramUnknownAccountData));

  @override
  StakeProgramUnknownAccountData get _value =>
      super._value as StakeProgramUnknownAccountData;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(StakeProgramUnknownAccountData(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StakeProgramUnknownAccountData
    implements StakeProgramUnknownAccountData {
  const _$StakeProgramUnknownAccountData(this.data);

  factory _$StakeProgramUnknownAccountData.fromJson(
          Map<String, dynamic> json) =>
      _$$StakeProgramUnknownAccountDataFromJson(json);

  @override
  final Map<String, dynamic>? data;

  @override
  String toString() {
    return 'StakeProgramAccountData.unknown(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StakeProgramUnknownAccountData &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $StakeProgramUnknownAccountDataCopyWith<StakeProgramUnknownAccountData>
      get copyWith => _$StakeProgramUnknownAccountDataCopyWithImpl<
          StakeProgramUnknownAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(Map<String, dynamic>? data) unknown,
  }) {
    return unknown(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic>? data)? unknown,
  }) {
    return unknown?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(Map<String, dynamic>? data)? unknown,
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
    required TResult Function(StakeProgramDelegatedAccountData value) delegated,
    required TResult Function(StakeProgramUnknownAccountData value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StakeProgramUnknownAccountDataToJson(this)..['type'] = 'unknown';
  }
}

abstract class StakeProgramUnknownAccountData
    implements StakeProgramAccountData {
  const factory StakeProgramUnknownAccountData(Map<String, dynamic>? data) =
      _$StakeProgramUnknownAccountData;

  factory StakeProgramUnknownAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeProgramUnknownAccountData.fromJson;

  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StakeProgramUnknownAccountDataCopyWith<StakeProgramUnknownAccountData>
      get copyWith => throw _privateConstructorUsedError;
}
