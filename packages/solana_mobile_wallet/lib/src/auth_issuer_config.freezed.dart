// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_issuer_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthIssuerConfig {
  String get name;
  int get maxOutstandingTokensPerIdentity;
  Duration get authorizationValidity;
  Duration get reauthorizationValidity;
  Duration get reauthorizationNopDuration;

  /// Create a copy of AuthIssuerConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthIssuerConfigCopyWith<AuthIssuerConfig> get copyWith =>
      _$AuthIssuerConfigCopyWithImpl<AuthIssuerConfig>(this as AuthIssuerConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthIssuerConfig &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxOutstandingTokensPerIdentity, maxOutstandingTokensPerIdentity) ||
                other.maxOutstandingTokensPerIdentity == maxOutstandingTokensPerIdentity) &&
            (identical(other.authorizationValidity, authorizationValidity) ||
                other.authorizationValidity == authorizationValidity) &&
            (identical(other.reauthorizationValidity, reauthorizationValidity) ||
                other.reauthorizationValidity == reauthorizationValidity) &&
            (identical(other.reauthorizationNopDuration, reauthorizationNopDuration) ||
                other.reauthorizationNopDuration == reauthorizationNopDuration));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    maxOutstandingTokensPerIdentity,
    authorizationValidity,
    reauthorizationValidity,
    reauthorizationNopDuration,
  );

  @override
  String toString() {
    return 'AuthIssuerConfig(name: $name, maxOutstandingTokensPerIdentity: $maxOutstandingTokensPerIdentity, authorizationValidity: $authorizationValidity, reauthorizationValidity: $reauthorizationValidity, reauthorizationNopDuration: $reauthorizationNopDuration)';
  }
}

/// @nodoc
abstract mixin class $AuthIssuerConfigCopyWith<$Res> {
  factory $AuthIssuerConfigCopyWith(AuthIssuerConfig value, $Res Function(AuthIssuerConfig) _then) =
      _$AuthIssuerConfigCopyWithImpl;
  @useResult
  $Res call({
    String name,
    int maxOutstandingTokensPerIdentity,
    Duration authorizationValidity,
    Duration reauthorizationValidity,
    Duration reauthorizationNopDuration,
  });
}

/// @nodoc
class _$AuthIssuerConfigCopyWithImpl<$Res> implements $AuthIssuerConfigCopyWith<$Res> {
  _$AuthIssuerConfigCopyWithImpl(this._self, this._then);

  final AuthIssuerConfig _self;
  final $Res Function(AuthIssuerConfig) _then;

  /// Create a copy of AuthIssuerConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxOutstandingTokensPerIdentity = null,
    Object? authorizationValidity = null,
    Object? reauthorizationValidity = null,
    Object? reauthorizationNopDuration = null,
  }) {
    return _then(
      _self.copyWith(
        name:
            null == name
                ? _self.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        maxOutstandingTokensPerIdentity:
            null == maxOutstandingTokensPerIdentity
                ? _self.maxOutstandingTokensPerIdentity
                : maxOutstandingTokensPerIdentity // ignore: cast_nullable_to_non_nullable
                    as int,
        authorizationValidity:
            null == authorizationValidity
                ? _self.authorizationValidity
                : authorizationValidity // ignore: cast_nullable_to_non_nullable
                    as Duration,
        reauthorizationValidity:
            null == reauthorizationValidity
                ? _self.reauthorizationValidity
                : reauthorizationValidity // ignore: cast_nullable_to_non_nullable
                    as Duration,
        reauthorizationNopDuration:
            null == reauthorizationNopDuration
                ? _self.reauthorizationNopDuration
                : reauthorizationNopDuration // ignore: cast_nullable_to_non_nullable
                    as Duration,
      ),
    );
  }
}

/// @nodoc

class _AuthIssuerConfig implements AuthIssuerConfig {
  const _AuthIssuerConfig({
    required this.name,
    this.maxOutstandingTokensPerIdentity = 50,
    this.authorizationValidity = const Duration(hours: 1),
    this.reauthorizationValidity = const Duration(days: 30),
    this.reauthorizationNopDuration = const Duration(minutes: 10),
  });

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

  /// Create a copy of AuthIssuerConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthIssuerConfigCopyWith<_AuthIssuerConfig> get copyWith =>
      __$AuthIssuerConfigCopyWithImpl<_AuthIssuerConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthIssuerConfig &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxOutstandingTokensPerIdentity, maxOutstandingTokensPerIdentity) ||
                other.maxOutstandingTokensPerIdentity == maxOutstandingTokensPerIdentity) &&
            (identical(other.authorizationValidity, authorizationValidity) ||
                other.authorizationValidity == authorizationValidity) &&
            (identical(other.reauthorizationValidity, reauthorizationValidity) ||
                other.reauthorizationValidity == reauthorizationValidity) &&
            (identical(other.reauthorizationNopDuration, reauthorizationNopDuration) ||
                other.reauthorizationNopDuration == reauthorizationNopDuration));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    maxOutstandingTokensPerIdentity,
    authorizationValidity,
    reauthorizationValidity,
    reauthorizationNopDuration,
  );

  @override
  String toString() {
    return 'AuthIssuerConfig(name: $name, maxOutstandingTokensPerIdentity: $maxOutstandingTokensPerIdentity, authorizationValidity: $authorizationValidity, reauthorizationValidity: $reauthorizationValidity, reauthorizationNopDuration: $reauthorizationNopDuration)';
  }
}

/// @nodoc
abstract mixin class _$AuthIssuerConfigCopyWith<$Res> implements $AuthIssuerConfigCopyWith<$Res> {
  factory _$AuthIssuerConfigCopyWith(
    _AuthIssuerConfig value,
    $Res Function(_AuthIssuerConfig) _then,
  ) = __$AuthIssuerConfigCopyWithImpl;
  @override
  @useResult
  $Res call({
    String name,
    int maxOutstandingTokensPerIdentity,
    Duration authorizationValidity,
    Duration reauthorizationValidity,
    Duration reauthorizationNopDuration,
  });
}

/// @nodoc
class __$AuthIssuerConfigCopyWithImpl<$Res> implements _$AuthIssuerConfigCopyWith<$Res> {
  __$AuthIssuerConfigCopyWithImpl(this._self, this._then);

  final _AuthIssuerConfig _self;
  final $Res Function(_AuthIssuerConfig) _then;

  /// Create a copy of AuthIssuerConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? maxOutstandingTokensPerIdentity = null,
    Object? authorizationValidity = null,
    Object? reauthorizationValidity = null,
    Object? reauthorizationNopDuration = null,
  }) {
    return _then(
      _AuthIssuerConfig(
        name:
            null == name
                ? _self.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        maxOutstandingTokensPerIdentity:
            null == maxOutstandingTokensPerIdentity
                ? _self.maxOutstandingTokensPerIdentity
                : maxOutstandingTokensPerIdentity // ignore: cast_nullable_to_non_nullable
                    as int,
        authorizationValidity:
            null == authorizationValidity
                ? _self.authorizationValidity
                : authorizationValidity // ignore: cast_nullable_to_non_nullable
                    as Duration,
        reauthorizationValidity:
            null == reauthorizationValidity
                ? _self.reauthorizationValidity
                : reauthorizationValidity // ignore: cast_nullable_to_non_nullable
                    as Duration,
        reauthorizationNopDuration:
            null == reauthorizationNopDuration
                ? _self.reauthorizationNopDuration
                : reauthorizationNopDuration // ignore: cast_nullable_to_non_nullable
                    as Duration,
      ),
    );
  }
}
