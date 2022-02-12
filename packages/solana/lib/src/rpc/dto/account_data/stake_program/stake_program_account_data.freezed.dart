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
  switch (json['type']) {
    case 'delegated':
      return StakeProgramDelegatedAccountData.fromJson(json);
    case 'initialize':
      return StakeProgramInitializedAccountData.fromJson(json);

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

  StakeProgramInitializedAccountData initialize(
      {required StakeInitializedAccountInfo info}) {
    return StakeProgramInitializedAccountData(
      info: info,
    );
  }

  StakeProgramUnknownAccountData unknown(Map<String, dynamic> info) {
    return StakeProgramUnknownAccountData(
      info,
    );
  }

  StakeProgramAccountData fromJson(Map<String, Object?> json) {
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
    required TResult Function(StakeInitializedAccountInfo info) initialize,
    required TResult Function(Map<String, dynamic> info) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(StakeInitializedAccountInfo info)? initialize,
    TResult Function(Map<String, dynamic> info)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(StakeInitializedAccountInfo info)? initialize,
    TResult Function(Map<String, dynamic> info)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StakeProgramDelegatedAccountData value) delegated,
    required TResult Function(StakeProgramInitializedAccountData value)
        initialize,
    required TResult Function(StakeProgramUnknownAccountData value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramInitializedAccountData value)? initialize,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramInitializedAccountData value)? initialize,
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
  const _$StakeProgramDelegatedAccountData({required this.info, String? $type})
      : $type = $type ?? 'delegated';

  factory _$StakeProgramDelegatedAccountData.fromJson(
          Map<String, dynamic> json) =>
      _$$StakeProgramDelegatedAccountDataFromJson(json);

  @override
  final StakeDelegatedAccountInfo info;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'StakeProgramAccountData.delegated(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StakeProgramDelegatedAccountData &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  $StakeProgramDelegatedAccountDataCopyWith<StakeProgramDelegatedAccountData>
      get copyWith => _$StakeProgramDelegatedAccountDataCopyWithImpl<
          StakeProgramDelegatedAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(StakeInitializedAccountInfo info) initialize,
    required TResult Function(Map<String, dynamic> info) unknown,
  }) {
    return delegated(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(StakeInitializedAccountInfo info)? initialize,
    TResult Function(Map<String, dynamic> info)? unknown,
  }) {
    return delegated?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(StakeInitializedAccountInfo info)? initialize,
    TResult Function(Map<String, dynamic> info)? unknown,
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
    required TResult Function(StakeProgramInitializedAccountData value)
        initialize,
    required TResult Function(StakeProgramUnknownAccountData value) unknown,
  }) {
    return delegated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramInitializedAccountData value)? initialize,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
  }) {
    return delegated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramInitializedAccountData value)? initialize,
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
    return _$$StakeProgramDelegatedAccountDataToJson(this);
  }
}

abstract class StakeProgramDelegatedAccountData
    implements StakeProgramAccountData {
  const factory StakeProgramDelegatedAccountData(
          {required StakeDelegatedAccountInfo info}) =
      _$StakeProgramDelegatedAccountData;

  factory StakeProgramDelegatedAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeProgramDelegatedAccountData.fromJson;

  StakeDelegatedAccountInfo get info;
  @JsonKey(ignore: true)
  $StakeProgramDelegatedAccountDataCopyWith<StakeProgramDelegatedAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakeProgramInitializedAccountDataCopyWith<$Res> {
  factory $StakeProgramInitializedAccountDataCopyWith(
          StakeProgramInitializedAccountData value,
          $Res Function(StakeProgramInitializedAccountData) then) =
      _$StakeProgramInitializedAccountDataCopyWithImpl<$Res>;
  $Res call({StakeInitializedAccountInfo info});
}

/// @nodoc
class _$StakeProgramInitializedAccountDataCopyWithImpl<$Res>
    extends _$StakeProgramAccountDataCopyWithImpl<$Res>
    implements $StakeProgramInitializedAccountDataCopyWith<$Res> {
  _$StakeProgramInitializedAccountDataCopyWithImpl(
      StakeProgramInitializedAccountData _value,
      $Res Function(StakeProgramInitializedAccountData) _then)
      : super(_value, (v) => _then(v as StakeProgramInitializedAccountData));

  @override
  StakeProgramInitializedAccountData get _value =>
      super._value as StakeProgramInitializedAccountData;

  @override
  $Res call({
    Object? info = freezed,
  }) {
    return _then(StakeProgramInitializedAccountData(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as StakeInitializedAccountInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StakeProgramInitializedAccountData
    implements StakeProgramInitializedAccountData {
  const _$StakeProgramInitializedAccountData(
      {required this.info, String? $type})
      : $type = $type ?? 'initialize';

  factory _$StakeProgramInitializedAccountData.fromJson(
          Map<String, dynamic> json) =>
      _$$StakeProgramInitializedAccountDataFromJson(json);

  @override
  final StakeInitializedAccountInfo info;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'StakeProgramAccountData.initialize(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StakeProgramInitializedAccountData &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  $StakeProgramInitializedAccountDataCopyWith<
          StakeProgramInitializedAccountData>
      get copyWith => _$StakeProgramInitializedAccountDataCopyWithImpl<
          StakeProgramInitializedAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(StakeInitializedAccountInfo info) initialize,
    required TResult Function(Map<String, dynamic> info) unknown,
  }) {
    return initialize(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(StakeInitializedAccountInfo info)? initialize,
    TResult Function(Map<String, dynamic> info)? unknown,
  }) {
    return initialize?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(StakeInitializedAccountInfo info)? initialize,
    TResult Function(Map<String, dynamic> info)? unknown,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StakeProgramDelegatedAccountData value) delegated,
    required TResult Function(StakeProgramInitializedAccountData value)
        initialize,
    required TResult Function(StakeProgramUnknownAccountData value) unknown,
  }) {
    return initialize(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramInitializedAccountData value)? initialize,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
  }) {
    return initialize?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramInitializedAccountData value)? initialize,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
    required TResult orElse(),
  }) {
    if (initialize != null) {
      return initialize(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StakeProgramInitializedAccountDataToJson(this);
  }
}

abstract class StakeProgramInitializedAccountData
    implements StakeProgramAccountData {
  const factory StakeProgramInitializedAccountData(
          {required StakeInitializedAccountInfo info}) =
      _$StakeProgramInitializedAccountData;

  factory StakeProgramInitializedAccountData.fromJson(
          Map<String, dynamic> json) =
      _$StakeProgramInitializedAccountData.fromJson;

  StakeInitializedAccountInfo get info;
  @JsonKey(ignore: true)
  $StakeProgramInitializedAccountDataCopyWith<
          StakeProgramInitializedAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakeProgramUnknownAccountDataCopyWith<$Res> {
  factory $StakeProgramUnknownAccountDataCopyWith(
          StakeProgramUnknownAccountData value,
          $Res Function(StakeProgramUnknownAccountData) then) =
      _$StakeProgramUnknownAccountDataCopyWithImpl<$Res>;
  $Res call({Map<String, dynamic> info});
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
    Object? info = freezed,
  }) {
    return _then(StakeProgramUnknownAccountData(
      info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StakeProgramUnknownAccountData
    implements StakeProgramUnknownAccountData {
  const _$StakeProgramUnknownAccountData(this.info, {String? $type})
      : $type = $type ?? 'unknown';

  factory _$StakeProgramUnknownAccountData.fromJson(
          Map<String, dynamic> json) =>
      _$$StakeProgramUnknownAccountDataFromJson(json);

  @override
  final Map<String, dynamic> info;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'StakeProgramAccountData.unknown(info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StakeProgramUnknownAccountData &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(info));

  @JsonKey(ignore: true)
  @override
  $StakeProgramUnknownAccountDataCopyWith<StakeProgramUnknownAccountData>
      get copyWith => _$StakeProgramUnknownAccountDataCopyWithImpl<
          StakeProgramUnknownAccountData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(StakeInitializedAccountInfo info) initialize,
    required TResult Function(Map<String, dynamic> info) unknown,
  }) {
    return unknown(info);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(StakeInitializedAccountInfo info)? initialize,
    TResult Function(Map<String, dynamic> info)? unknown,
  }) {
    return unknown?.call(info);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(StakeDelegatedAccountInfo info)? delegated,
    TResult Function(StakeInitializedAccountInfo info)? initialize,
    TResult Function(Map<String, dynamic> info)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(info);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(StakeProgramDelegatedAccountData value) delegated,
    required TResult Function(StakeProgramInitializedAccountData value)
        initialize,
    required TResult Function(StakeProgramUnknownAccountData value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramInitializedAccountData value)? initialize,
    TResult Function(StakeProgramUnknownAccountData value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult Function(StakeProgramInitializedAccountData value)? initialize,
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
    return _$$StakeProgramUnknownAccountDataToJson(this);
  }
}

abstract class StakeProgramUnknownAccountData
    implements StakeProgramAccountData {
  const factory StakeProgramUnknownAccountData(Map<String, dynamic> info) =
      _$StakeProgramUnknownAccountData;

  factory StakeProgramUnknownAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeProgramUnknownAccountData.fromJson;

  Map<String, dynamic> get info;
  @JsonKey(ignore: true)
  $StakeProgramUnknownAccountDataCopyWith<StakeProgramUnknownAccountData>
      get copyWith => throw _privateConstructorUsedError;
}
