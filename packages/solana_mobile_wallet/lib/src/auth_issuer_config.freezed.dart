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
      _$AuthIssuerConfigCopyWithImpl<$Res>;
  $Res call(
      {String name,
      int maxOutstandingTokensPerIdentity,
      Duration authorizationValidity,
      Duration reauthorizationValidity,
      Duration reauthorizationNopDuration});
}

/// @nodoc
class _$AuthIssuerConfigCopyWithImpl<$Res>
    implements $AuthIssuerConfigCopyWith<$Res> {
  _$AuthIssuerConfigCopyWithImpl(this._value, this._then);

  final AuthIssuerConfig _value;
  // ignore: unused_field
  final $Res Function(AuthIssuerConfig) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? maxOutstandingTokensPerIdentity = freezed,
    Object? authorizationValidity = freezed,
    Object? reauthorizationValidity = freezed,
    Object? reauthorizationNopDuration = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxOutstandingTokensPerIdentity: maxOutstandingTokensPerIdentity ==
              freezed
          ? _value.maxOutstandingTokensPerIdentity
          : maxOutstandingTokensPerIdentity // ignore: cast_nullable_to_non_nullable
              as int,
      authorizationValidity: authorizationValidity == freezed
          ? _value.authorizationValidity
          : authorizationValidity // ignore: cast_nullable_to_non_nullable
              as Duration,
      reauthorizationValidity: reauthorizationValidity == freezed
          ? _value.reauthorizationValidity
          : reauthorizationValidity // ignore: cast_nullable_to_non_nullable
              as Duration,
      reauthorizationNopDuration: reauthorizationNopDuration == freezed
          ? _value.reauthorizationNopDuration
          : reauthorizationNopDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
abstract class _$$_AuthIssuerConfigCopyWith<$Res>
    implements $AuthIssuerConfigCopyWith<$Res> {
  factory _$$_AuthIssuerConfigCopyWith(
          _$_AuthIssuerConfig value, $Res Function(_$_AuthIssuerConfig) then) =
      __$$_AuthIssuerConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      int maxOutstandingTokensPerIdentity,
      Duration authorizationValidity,
      Duration reauthorizationValidity,
      Duration reauthorizationNopDuration});
}

/// @nodoc
class __$$_AuthIssuerConfigCopyWithImpl<$Res>
    extends _$AuthIssuerConfigCopyWithImpl<$Res>
    implements _$$_AuthIssuerConfigCopyWith<$Res> {
  __$$_AuthIssuerConfigCopyWithImpl(
      _$_AuthIssuerConfig _value, $Res Function(_$_AuthIssuerConfig) _then)
      : super(_value, (v) => _then(v as _$_AuthIssuerConfig));

  @override
  _$_AuthIssuerConfig get _value => super._value as _$_AuthIssuerConfig;

  @override
  $Res call({
    Object? name = freezed,
    Object? maxOutstandingTokensPerIdentity = freezed,
    Object? authorizationValidity = freezed,
    Object? reauthorizationValidity = freezed,
    Object? reauthorizationNopDuration = freezed,
  }) {
    return _then(_$_AuthIssuerConfig(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxOutstandingTokensPerIdentity: maxOutstandingTokensPerIdentity ==
              freezed
          ? _value.maxOutstandingTokensPerIdentity
          : maxOutstandingTokensPerIdentity // ignore: cast_nullable_to_non_nullable
              as int,
      authorizationValidity: authorizationValidity == freezed
          ? _value.authorizationValidity
          : authorizationValidity // ignore: cast_nullable_to_non_nullable
              as Duration,
      reauthorizationValidity: reauthorizationValidity == freezed
          ? _value.reauthorizationValidity
          : reauthorizationValidity // ignore: cast_nullable_to_non_nullable
              as Duration,
      reauthorizationNopDuration: reauthorizationNopDuration == freezed
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
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(
                other.maxOutstandingTokensPerIdentity,
                maxOutstandingTokensPerIdentity) &&
            const DeepCollectionEquality()
                .equals(other.authorizationValidity, authorizationValidity) &&
            const DeepCollectionEquality().equals(
                other.reauthorizationValidity, reauthorizationValidity) &&
            const DeepCollectionEquality().equals(
                other.reauthorizationNopDuration, reauthorizationNopDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(maxOutstandingTokensPerIdentity),
      const DeepCollectionEquality().hash(authorizationValidity),
      const DeepCollectionEquality().hash(reauthorizationValidity),
      const DeepCollectionEquality().hash(reauthorizationNopDuration));

  @JsonKey(ignore: true)
  @override
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
