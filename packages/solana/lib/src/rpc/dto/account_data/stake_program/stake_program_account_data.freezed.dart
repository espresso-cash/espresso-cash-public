// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stake_program_account_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
mixin _$StakeProgramAccountData {
  Object get info => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(StakeDelegatedAccountInfo info) delegated,
    required TResult Function(StakeInitializedAccountInfo info) initialize,
    required TResult Function(Map<String, dynamic> info) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(StakeDelegatedAccountInfo info)? delegated,
    TResult? Function(StakeInitializedAccountInfo info)? initialize,
    TResult? Function(Map<String, dynamic> info)? unknown,
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
    TResult? Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult? Function(StakeProgramInitializedAccountData value)? initialize,
    TResult? Function(StakeProgramUnknownAccountData value)? unknown,
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
      _$StakeProgramAccountDataCopyWithImpl<$Res, StakeProgramAccountData>;
}

/// @nodoc
class _$StakeProgramAccountDataCopyWithImpl<$Res,
        $Val extends StakeProgramAccountData>
    implements $StakeProgramAccountDataCopyWith<$Res> {
  _$StakeProgramAccountDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StakeProgramDelegatedAccountDataCopyWith<$Res> {
  factory _$$StakeProgramDelegatedAccountDataCopyWith(
          _$StakeProgramDelegatedAccountData value,
          $Res Function(_$StakeProgramDelegatedAccountData) then) =
      __$$StakeProgramDelegatedAccountDataCopyWithImpl<$Res>;
  @useResult
  $Res call({StakeDelegatedAccountInfo info});
}

/// @nodoc
class __$$StakeProgramDelegatedAccountDataCopyWithImpl<$Res>
    extends _$StakeProgramAccountDataCopyWithImpl<$Res,
        _$StakeProgramDelegatedAccountData>
    implements _$$StakeProgramDelegatedAccountDataCopyWith<$Res> {
  __$$StakeProgramDelegatedAccountDataCopyWithImpl(
      _$StakeProgramDelegatedAccountData _value,
      $Res Function(_$StakeProgramDelegatedAccountData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$StakeProgramDelegatedAccountData(
      info: null == info
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
  const _$StakeProgramDelegatedAccountData(
      {required this.info, final String? $type})
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
            other is _$StakeProgramDelegatedAccountData &&
            (identical(other.info, info) || other.info == info));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StakeProgramDelegatedAccountDataCopyWith<
          _$StakeProgramDelegatedAccountData>
      get copyWith => __$$StakeProgramDelegatedAccountDataCopyWithImpl<
          _$StakeProgramDelegatedAccountData>(this, _$identity);

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
    TResult? Function(StakeDelegatedAccountInfo info)? delegated,
    TResult? Function(StakeInitializedAccountInfo info)? initialize,
    TResult? Function(Map<String, dynamic> info)? unknown,
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
    TResult? Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult? Function(StakeProgramInitializedAccountData value)? initialize,
    TResult? Function(StakeProgramUnknownAccountData value)? unknown,
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
    return _$$StakeProgramDelegatedAccountDataToJson(
      this,
    );
  }
}

abstract class StakeProgramDelegatedAccountData
    implements StakeProgramAccountData {
  const factory StakeProgramDelegatedAccountData(
          {required final StakeDelegatedAccountInfo info}) =
      _$StakeProgramDelegatedAccountData;

  factory StakeProgramDelegatedAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeProgramDelegatedAccountData.fromJson;

  @override
  StakeDelegatedAccountInfo get info;
  @JsonKey(ignore: true)
  _$$StakeProgramDelegatedAccountDataCopyWith<
          _$StakeProgramDelegatedAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StakeProgramInitializedAccountDataCopyWith<$Res> {
  factory _$$StakeProgramInitializedAccountDataCopyWith(
          _$StakeProgramInitializedAccountData value,
          $Res Function(_$StakeProgramInitializedAccountData) then) =
      __$$StakeProgramInitializedAccountDataCopyWithImpl<$Res>;
  @useResult
  $Res call({StakeInitializedAccountInfo info});
}

/// @nodoc
class __$$StakeProgramInitializedAccountDataCopyWithImpl<$Res>
    extends _$StakeProgramAccountDataCopyWithImpl<$Res,
        _$StakeProgramInitializedAccountData>
    implements _$$StakeProgramInitializedAccountDataCopyWith<$Res> {
  __$$StakeProgramInitializedAccountDataCopyWithImpl(
      _$StakeProgramInitializedAccountData _value,
      $Res Function(_$StakeProgramInitializedAccountData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$StakeProgramInitializedAccountData(
      info: null == info
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
      {required this.info, final String? $type})
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
            other is _$StakeProgramInitializedAccountData &&
            (identical(other.info, info) || other.info == info));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, info);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StakeProgramInitializedAccountDataCopyWith<
          _$StakeProgramInitializedAccountData>
      get copyWith => __$$StakeProgramInitializedAccountDataCopyWithImpl<
          _$StakeProgramInitializedAccountData>(this, _$identity);

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
    TResult? Function(StakeDelegatedAccountInfo info)? delegated,
    TResult? Function(StakeInitializedAccountInfo info)? initialize,
    TResult? Function(Map<String, dynamic> info)? unknown,
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
    TResult? Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult? Function(StakeProgramInitializedAccountData value)? initialize,
    TResult? Function(StakeProgramUnknownAccountData value)? unknown,
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
    return _$$StakeProgramInitializedAccountDataToJson(
      this,
    );
  }
}

abstract class StakeProgramInitializedAccountData
    implements StakeProgramAccountData {
  const factory StakeProgramInitializedAccountData(
          {required final StakeInitializedAccountInfo info}) =
      _$StakeProgramInitializedAccountData;

  factory StakeProgramInitializedAccountData.fromJson(
          Map<String, dynamic> json) =
      _$StakeProgramInitializedAccountData.fromJson;

  @override
  StakeInitializedAccountInfo get info;
  @JsonKey(ignore: true)
  _$$StakeProgramInitializedAccountDataCopyWith<
          _$StakeProgramInitializedAccountData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StakeProgramUnknownAccountDataCopyWith<$Res> {
  factory _$$StakeProgramUnknownAccountDataCopyWith(
          _$StakeProgramUnknownAccountData value,
          $Res Function(_$StakeProgramUnknownAccountData) then) =
      __$$StakeProgramUnknownAccountDataCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> info});
}

/// @nodoc
class __$$StakeProgramUnknownAccountDataCopyWithImpl<$Res>
    extends _$StakeProgramAccountDataCopyWithImpl<$Res,
        _$StakeProgramUnknownAccountData>
    implements _$$StakeProgramUnknownAccountDataCopyWith<$Res> {
  __$$StakeProgramUnknownAccountDataCopyWithImpl(
      _$StakeProgramUnknownAccountData _value,
      $Res Function(_$StakeProgramUnknownAccountData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
  }) {
    return _then(_$StakeProgramUnknownAccountData(
      null == info
          ? _value._info
          : info // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StakeProgramUnknownAccountData
    implements StakeProgramUnknownAccountData {
  const _$StakeProgramUnknownAccountData(final Map<String, dynamic> info,
      {final String? $type})
      : _info = info,
        $type = $type ?? 'unknown';

  factory _$StakeProgramUnknownAccountData.fromJson(
          Map<String, dynamic> json) =>
      _$$StakeProgramUnknownAccountDataFromJson(json);

  final Map<String, dynamic> _info;
  @override
  Map<String, dynamic> get info {
    if (_info is EqualUnmodifiableMapView) return _info;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_info);
  }

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
            other is _$StakeProgramUnknownAccountData &&
            const DeepCollectionEquality().equals(other._info, _info));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_info));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StakeProgramUnknownAccountDataCopyWith<_$StakeProgramUnknownAccountData>
      get copyWith => __$$StakeProgramUnknownAccountDataCopyWithImpl<
          _$StakeProgramUnknownAccountData>(this, _$identity);

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
    TResult? Function(StakeDelegatedAccountInfo info)? delegated,
    TResult? Function(StakeInitializedAccountInfo info)? initialize,
    TResult? Function(Map<String, dynamic> info)? unknown,
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
    TResult? Function(StakeProgramDelegatedAccountData value)? delegated,
    TResult? Function(StakeProgramInitializedAccountData value)? initialize,
    TResult? Function(StakeProgramUnknownAccountData value)? unknown,
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
    return _$$StakeProgramUnknownAccountDataToJson(
      this,
    );
  }
}

abstract class StakeProgramUnknownAccountData
    implements StakeProgramAccountData {
  const factory StakeProgramUnknownAccountData(
      final Map<String, dynamic> info) = _$StakeProgramUnknownAccountData;

  factory StakeProgramUnknownAccountData.fromJson(Map<String, dynamic> json) =
      _$StakeProgramUnknownAccountData.fromJson;

  @override
  Map<String, dynamic> get info;
  @JsonKey(ignore: true)
  _$$StakeProgramUnknownAccountDataCopyWith<_$StakeProgramUnknownAccountData>
      get copyWith => throw _privateConstructorUsedError;
}
