// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'reauthorize.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReauthorizeRequest {
  String? get identityName => throw _privateConstructorUsedError;
  Uri? get identityUri => throw _privateConstructorUsedError;
  Uri? get iconRelativeUri => throw _privateConstructorUsedError;
  String get cluster => throw _privateConstructorUsedError;
  Uint8List get authorizationScope => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReauthorizeRequestCopyWith<ReauthorizeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReauthorizeRequestCopyWith<$Res> {
  factory $ReauthorizeRequestCopyWith(
          ReauthorizeRequest value, $Res Function(ReauthorizeRequest) then) =
      _$ReauthorizeRequestCopyWithImpl<$Res>;
  $Res call(
      {String? identityName,
      Uri? identityUri,
      Uri? iconRelativeUri,
      String cluster,
      Uint8List authorizationScope});
}

/// @nodoc
class _$ReauthorizeRequestCopyWithImpl<$Res>
    implements $ReauthorizeRequestCopyWith<$Res> {
  _$ReauthorizeRequestCopyWithImpl(this._value, this._then);

  final ReauthorizeRequest _value;
  // ignore: unused_field
  final $Res Function(ReauthorizeRequest) _then;

  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = freezed,
    Object? authorizationScope = freezed,
  }) {
    return _then(_value.copyWith(
      identityName: identityName == freezed
          ? _value.identityName
          : identityName // ignore: cast_nullable_to_non_nullable
              as String?,
      identityUri: identityUri == freezed
          ? _value.identityUri
          : identityUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      iconRelativeUri: iconRelativeUri == freezed
          ? _value.iconRelativeUri
          : iconRelativeUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      cluster: cluster == freezed
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as String,
      authorizationScope: authorizationScope == freezed
          ? _value.authorizationScope
          : authorizationScope // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc
abstract class _$$_ReauthorizeRequestCopyWith<$Res>
    implements $ReauthorizeRequestCopyWith<$Res> {
  factory _$$_ReauthorizeRequestCopyWith(_$_ReauthorizeRequest value,
          $Res Function(_$_ReauthorizeRequest) then) =
      __$$_ReauthorizeRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? identityName,
      Uri? identityUri,
      Uri? iconRelativeUri,
      String cluster,
      Uint8List authorizationScope});
}

/// @nodoc
class __$$_ReauthorizeRequestCopyWithImpl<$Res>
    extends _$ReauthorizeRequestCopyWithImpl<$Res>
    implements _$$_ReauthorizeRequestCopyWith<$Res> {
  __$$_ReauthorizeRequestCopyWithImpl(
      _$_ReauthorizeRequest _value, $Res Function(_$_ReauthorizeRequest) _then)
      : super(_value, (v) => _then(v as _$_ReauthorizeRequest));

  @override
  _$_ReauthorizeRequest get _value => super._value as _$_ReauthorizeRequest;

  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = freezed,
    Object? authorizationScope = freezed,
  }) {
    return _then(_$_ReauthorizeRequest(
      identityName: identityName == freezed
          ? _value.identityName
          : identityName // ignore: cast_nullable_to_non_nullable
              as String?,
      identityUri: identityUri == freezed
          ? _value.identityUri
          : identityUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      iconRelativeUri: iconRelativeUri == freezed
          ? _value.iconRelativeUri
          : iconRelativeUri // ignore: cast_nullable_to_non_nullable
              as Uri?,
      cluster: cluster == freezed
          ? _value.cluster
          : cluster // ignore: cast_nullable_to_non_nullable
              as String,
      authorizationScope: authorizationScope == freezed
          ? _value.authorizationScope
          : authorizationScope // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc

class _$_ReauthorizeRequest implements _ReauthorizeRequest {
  const _$_ReauthorizeRequest(
      {required this.identityName,
      required this.identityUri,
      required this.iconRelativeUri,
      required this.cluster,
      required this.authorizationScope});

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

  @override
  String toString() {
    return 'ReauthorizeRequest(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReauthorizeRequest &&
            const DeepCollectionEquality()
                .equals(other.identityName, identityName) &&
            const DeepCollectionEquality()
                .equals(other.identityUri, identityUri) &&
            const DeepCollectionEquality()
                .equals(other.iconRelativeUri, iconRelativeUri) &&
            const DeepCollectionEquality().equals(other.cluster, cluster) &&
            const DeepCollectionEquality()
                .equals(other.authorizationScope, authorizationScope));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(identityName),
      const DeepCollectionEquality().hash(identityUri),
      const DeepCollectionEquality().hash(iconRelativeUri),
      const DeepCollectionEquality().hash(cluster),
      const DeepCollectionEquality().hash(authorizationScope));

  @JsonKey(ignore: true)
  @override
  _$$_ReauthorizeRequestCopyWith<_$_ReauthorizeRequest> get copyWith =>
      __$$_ReauthorizeRequestCopyWithImpl<_$_ReauthorizeRequest>(
          this, _$identity);
}

abstract class _ReauthorizeRequest implements ReauthorizeRequest {
  const factory _ReauthorizeRequest(
      {required final String? identityName,
      required final Uri? identityUri,
      required final Uri? iconRelativeUri,
      required final String cluster,
      required final Uint8List authorizationScope}) = _$_ReauthorizeRequest;

  @override
  String? get identityName;
  @override
  Uri? get identityUri;
  @override
  Uri? get iconRelativeUri;
  @override
  String get cluster;
  @override
  Uint8List get authorizationScope;
  @override
  @JsonKey(ignore: true)
  _$$_ReauthorizeRequestCopyWith<_$_ReauthorizeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
