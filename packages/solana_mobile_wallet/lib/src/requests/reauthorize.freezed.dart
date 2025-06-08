// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reauthorize.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReauthorizeRequest {
  String? get identityName;
  Uri? get identityUri;
  Uri? get iconRelativeUri;
  String get cluster;
  Uint8List get authorizationScope;

  /// Create a copy of ReauthorizeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReauthorizeRequestCopyWith<ReauthorizeRequest> get copyWith =>
      _$ReauthorizeRequestCopyWithImpl<ReauthorizeRequest>(this as ReauthorizeRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReauthorizeRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality().equals(other.authorizationScope, authorizationScope));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityName,
    identityUri,
    iconRelativeUri,
    cluster,
    const DeepCollectionEquality().hash(authorizationScope),
  );

  @override
  String toString() {
    return 'ReauthorizeRequest(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope)';
  }
}

/// @nodoc
abstract mixin class $ReauthorizeRequestCopyWith<$Res> {
  factory $ReauthorizeRequestCopyWith(
    ReauthorizeRequest value,
    $Res Function(ReauthorizeRequest) _then,
  ) = _$ReauthorizeRequestCopyWithImpl;
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
  });
}

/// @nodoc
class _$ReauthorizeRequestCopyWithImpl<$Res> implements $ReauthorizeRequestCopyWith<$Res> {
  _$ReauthorizeRequestCopyWithImpl(this._self, this._then);

  final ReauthorizeRequest _self;
  final $Res Function(ReauthorizeRequest) _then;

  /// Create a copy of ReauthorizeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
  }) {
    return _then(
      _self.copyWith(
        identityName:
            freezed == identityName
                ? _self.identityName
                : identityName // ignore: cast_nullable_to_non_nullable
                    as String?,
        identityUri:
            freezed == identityUri
                ? _self.identityUri
                : identityUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        iconRelativeUri:
            freezed == iconRelativeUri
                ? _self.iconRelativeUri
                : iconRelativeUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        cluster:
            null == cluster
                ? _self.cluster
                : cluster // ignore: cast_nullable_to_non_nullable
                    as String,
        authorizationScope:
            null == authorizationScope
                ? _self.authorizationScope
                : authorizationScope // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
      ),
    );
  }
}

/// @nodoc

class _ReauthorizeRequest implements ReauthorizeRequest {
  const _ReauthorizeRequest({
    required this.identityName,
    required this.identityUri,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
  });

  @override
  final String? identityName;
  @override
  final Uri? identityUri;
  @override
  final Uri? iconRelativeUri;
  @override
  final String cluster;
  @override
  final Uint8List authorizationScope;

  /// Create a copy of ReauthorizeRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReauthorizeRequestCopyWith<_ReauthorizeRequest> get copyWith =>
      __$ReauthorizeRequestCopyWithImpl<_ReauthorizeRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReauthorizeRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality().equals(other.authorizationScope, authorizationScope));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityName,
    identityUri,
    iconRelativeUri,
    cluster,
    const DeepCollectionEquality().hash(authorizationScope),
  );

  @override
  String toString() {
    return 'ReauthorizeRequest(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope)';
  }
}

/// @nodoc
abstract mixin class _$ReauthorizeRequestCopyWith<$Res>
    implements $ReauthorizeRequestCopyWith<$Res> {
  factory _$ReauthorizeRequestCopyWith(
    _ReauthorizeRequest value,
    $Res Function(_ReauthorizeRequest) _then,
  ) = __$ReauthorizeRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
  });
}

/// @nodoc
class __$ReauthorizeRequestCopyWithImpl<$Res> implements _$ReauthorizeRequestCopyWith<$Res> {
  __$ReauthorizeRequestCopyWithImpl(this._self, this._then);

  final _ReauthorizeRequest _self;
  final $Res Function(_ReauthorizeRequest) _then;

  /// Create a copy of ReauthorizeRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
  }) {
    return _then(
      _ReauthorizeRequest(
        identityName:
            freezed == identityName
                ? _self.identityName
                : identityName // ignore: cast_nullable_to_non_nullable
                    as String?,
        identityUri:
            freezed == identityUri
                ? _self.identityUri
                : identityUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        iconRelativeUri:
            freezed == iconRelativeUri
                ? _self.iconRelativeUri
                : iconRelativeUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        cluster:
            null == cluster
                ? _self.cluster
                : cluster // ignore: cast_nullable_to_non_nullable
                    as String,
        authorizationScope:
            null == authorizationScope
                ? _self.authorizationScope
                : authorizationScope // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
      ),
    );
  }
}
