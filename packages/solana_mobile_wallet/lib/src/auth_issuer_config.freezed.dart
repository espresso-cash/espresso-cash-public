// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_issuer_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthIssuerConfig _$AuthIssuerConfigFromJson(Map<String, dynamic> json) {
  return _AuthIssuerConfig.fromJson(json);
}

/// @nodoc
mixin _$AuthIssuerConfig {
  String get name => throw _privateConstructorUsedError;
  int get maxOutstandingTokensPerIdentity => throw _privateConstructorUsedError;
  Duration get authorizationValidity => throw _privateConstructorUsedError;
  Duration get reauthorizationValidity => throw _privateConstructorUsedError;
  Duration get reauthorizationNopDuration => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthIssuerConfigCopyWith<AuthIssuerConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthIssuerConfigCopyWith<$Res> {
  factory $AuthIssuerConfigCopyWith(
          AuthIssuerConfig value, $Res Function(AuthIssuerConfig) then) =
      _$AuthIssuerConfigCopyWithImpl<$Res, AuthIssuerConfig>;
  @useResult
  $Res call(
      {String name,
      int maxOutstandingTokensPerIdentity,
      Duration authorizationValidity,
      Duration reauthorizationValidity,
      Duration reauthorizationNopDuration});
}

/// @nodoc
class _$AuthIssuerConfigCopyWithImpl<$Res, $Val extends AuthIssuerConfig>
    implements $AuthIssuerConfigCopyWith<$Res> {
  _$AuthIssuerConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxOutstandingTokensPerIdentity = null,
    Object? authorizationValidity = null,
    Object? reauthorizationValidity = null,
    Object? reauthorizationNopDuration = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxOutstandingTokensPerIdentity: null == maxOutstandingTokensPerIdentity
          ? _value.maxOutstandingTokensPerIdentity
          : maxOutstandingTokensPerIdentity // ignore: cast_nullable_to_non_nullable
              as int,
      authorizationValidity: null == authorizationValidity
          ? _value.authorizationValidity
          : authorizationValidity // ignore: cast_nullable_to_non_nullable
              as Duration,
      reauthorizationValidity: null == reauthorizationValidity
          ? _value.reauthorizationValidity
          : reauthorizationValidity // ignore: cast_nullable_to_non_nullable
              as Duration,
      reauthorizationNopDuration: null == reauthorizationNopDuration
          ? _value.reauthorizationNopDuration
          : reauthorizationNopDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthIssuerConfigCopyWith<$Res>
    implements $AuthIssuerConfigCopyWith<$Res> {
  factory _$$_AuthIssuerConfigCopyWith(
          _$_AuthIssuerConfig value, $Res Function(_$_AuthIssuerConfig) then) =
      __$$_AuthIssuerConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int maxOutstandingTokensPerIdentity,
      Duration authorizationValidity,
      Duration reauthorizationValidity,
      Duration reauthorizationNopDuration});
}

/// @nodoc
class __$$_AuthIssuerConfigCopyWithImpl<$Res>
    extends _$AuthIssuerConfigCopyWithImpl<$Res, _$_AuthIssuerConfig>
    implements _$$_AuthIssuerConfigCopyWith<$Res> {
  __$$_AuthIssuerConfigCopyWithImpl(
      _$_AuthIssuerConfig _value, $Res Function(_$_AuthIssuerConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxOutstandingTokensPerIdentity = null,
    Object? authorizationValidity = null,
    Object? reauthorizationValidity = null,
    Object? reauthorizationNopDuration = null,
  }) {
    return _then(_$_AuthIssuerConfig(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxOutstandingTokensPerIdentity: null == maxOutstandingTokensPerIdentity
          ? _value.maxOutstandingTokensPerIdentity
          : maxOutstandingTokensPerIdentity // ignore: cast_nullable_to_non_nullable
              as int,
      authorizationValidity: null == authorizationValidity
          ? _value.authorizationValidity
          : authorizationValidity // ignore: cast_nullable_to_non_nullable
              as Duration,
      reauthorizationValidity: null == reauthorizationValidity
          ? _value.reauthorizationValidity
          : reauthorizationValidity // ignore: cast_nullable_to_non_nullable
              as Duration,
      reauthorizationNopDuration: null == reauthorizationNopDuration
          ? _value.reauthorizationNopDuration
          : reauthorizationNopDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthIssuerConfig implements _AuthIssuerConfig {
  const _$_AuthIssuerConfig(
      {required this.name,
      this.maxOutstandingTokensPerIdentity = 50,
      this.authorizationValidity = const Duration(hours: 1),
      this.reauthorizationValidity = const Duration(days: 30),
      this.reauthorizationNopDuration = const Duration(minutes: 10)});

  factory _$_AuthIssuerConfig.fromJson(Map<String, dynamic> json) =>
      _$$_AuthIssuerConfigFromJson(json);

  @override
  final String name;
  @override
  @JsonKey()
  final int maxOutstandingTokensPerIdentity;
  @override
  @JsonKey()
  final Duration authorizationValidity;
  @override
  @JsonKey()
  final Duration reauthorizationValidity;
  @override
  @JsonKey()
  final Duration reauthorizationNopDuration;

  @override
  String toString() {
    return 'AuthIssuerConfig(name: $name, maxOutstandingTokensPerIdentity: $maxOutstandingTokensPerIdentity, authorizationValidity: $authorizationValidity, reauthorizationValidity: $reauthorizationValidity, reauthorizationNopDuration: $reauthorizationNopDuration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthIssuerConfig &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxOutstandingTokensPerIdentity,
                    maxOutstandingTokensPerIdentity) ||
                other.maxOutstandingTokensPerIdentity ==
                    maxOutstandingTokensPerIdentity) &&
            (identical(other.authorizationValidity, authorizationValidity) ||
                other.authorizationValidity == authorizationValidity) &&
            (identical(
                    other.reauthorizationValidity, reauthorizationValidity) ||
                other.reauthorizationValidity == reauthorizationValidity) &&
            (identical(other.reauthorizationNopDuration,
                    reauthorizationNopDuration) ||
                other.reauthorizationNopDuration ==
                    reauthorizationNopDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      maxOutstandingTokensPerIdentity,
      authorizationValidity,
      reauthorizationValidity,
      reauthorizationNopDuration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthIssuerConfigCopyWith<_$_AuthIssuerConfig> get copyWith =>
      __$$_AuthIssuerConfigCopyWithImpl<_$_AuthIssuerConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthIssuerConfigToJson(
      this,
    );
  }
}

abstract class _AuthIssuerConfig implements AuthIssuerConfig {
  const factory _AuthIssuerConfig(
      {required final String name,
      final int maxOutstandingTokensPerIdentity,
      final Duration authorizationValidity,
      final Duration reauthorizationValidity,
      final Duration reauthorizationNopDuration}) = _$_AuthIssuerConfig;

  factory _AuthIssuerConfig.fromJson(Map<String, dynamic> json) =
      _$_AuthIssuerConfig.fromJson;

  @override
  String get name;
  @override
  int get maxOutstandingTokensPerIdentity;
  @override
  Duration get authorizationValidity;
  @override
  Duration get reauthorizationValidity;
  @override
  Duration get reauthorizationNopDuration;
  @override
  @JsonKey(ignore: true)
  _$$_AuthIssuerConfigCopyWith<_$_AuthIssuerConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
