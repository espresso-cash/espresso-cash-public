// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authorize.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthorizeRequest {
  String? get identityName;
  Uri? get identityUri;
  Uri? get iconUri;

  /// Create a copy of AuthorizeRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthorizeRequestCopyWith<AuthorizeRequest> get copyWith =>
      _$AuthorizeRequestCopyWithImpl<AuthorizeRequest>(this as AuthorizeRequest, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthorizeRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconUri, iconUri) || other.iconUri == iconUri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identityName, identityUri, iconUri);

  @override
  String toString() {
    return 'AuthorizeRequest(identityName: $identityName, identityUri: $identityUri, iconUri: $iconUri)';
  }
}

/// @nodoc
abstract mixin class $AuthorizeRequestCopyWith<$Res> {
  factory $AuthorizeRequestCopyWith(AuthorizeRequest value, $Res Function(AuthorizeRequest) _then) =
      _$AuthorizeRequestCopyWithImpl;
  @useResult
  $Res call({String? identityName, Uri? identityUri, Uri? iconUri});
}

/// @nodoc
class _$AuthorizeRequestCopyWithImpl<$Res> implements $AuthorizeRequestCopyWith<$Res> {
  _$AuthorizeRequestCopyWithImpl(this._self, this._then);

  final AuthorizeRequest _self;
  final $Res Function(AuthorizeRequest) _then;

  /// Create a copy of AuthorizeRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconUri = freezed,
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
        iconUri:
            freezed == iconUri
                ? _self.iconUri
                : iconUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
      ),
    );
  }
}

/// @nodoc

class _AuthorizeRequest implements AuthorizeRequest {
  const _AuthorizeRequest({
    required this.identityName,
    required this.identityUri,
    required this.iconUri,
  });

  @override
  final String? identityName;
  @override
  final Uri? identityUri;
  @override
  final Uri? iconUri;

  /// Create a copy of AuthorizeRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthorizeRequestCopyWith<_AuthorizeRequest> get copyWith =>
      __$AuthorizeRequestCopyWithImpl<_AuthorizeRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthorizeRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconUri, iconUri) || other.iconUri == iconUri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, identityName, identityUri, iconUri);

  @override
  String toString() {
    return 'AuthorizeRequest(identityName: $identityName, identityUri: $identityUri, iconUri: $iconUri)';
  }
}

/// @nodoc
abstract mixin class _$AuthorizeRequestCopyWith<$Res> implements $AuthorizeRequestCopyWith<$Res> {
  factory _$AuthorizeRequestCopyWith(
    _AuthorizeRequest value,
    $Res Function(_AuthorizeRequest) _then,
  ) = __$AuthorizeRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String? identityName, Uri? identityUri, Uri? iconUri});
}

/// @nodoc
class __$AuthorizeRequestCopyWithImpl<$Res> implements _$AuthorizeRequestCopyWith<$Res> {
  __$AuthorizeRequestCopyWithImpl(this._self, this._then);

  final _AuthorizeRequest _self;
  final $Res Function(_AuthorizeRequest) _then;

  /// Create a copy of AuthorizeRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconUri = freezed,
  }) {
    return _then(
      _AuthorizeRequest(
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
        iconUri:
            freezed == iconUri
                ? _self.iconUri
                : iconUri // ignore: cast_nullable_to_non_nullable
                    as Uri?,
      ),
    );
  }
}

/// @nodoc
mixin _$AuthorizeResult {
  Uint8List get publicKey;
  String? get accountLabel;
  Uri? get walletUriBase;
  Uint8List? get scope;

  /// Create a copy of AuthorizeResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthorizeResultCopyWith<AuthorizeResult> get copyWith =>
      _$AuthorizeResultCopyWithImpl<AuthorizeResult>(this as AuthorizeResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthorizeResult &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            (identical(other.accountLabel, accountLabel) || other.accountLabel == accountLabel) &&
            (identical(other.walletUriBase, walletUriBase) ||
                other.walletUriBase == walletUriBase) &&
            const DeepCollectionEquality().equals(other.scope, scope));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(publicKey),
    accountLabel,
    walletUriBase,
    const DeepCollectionEquality().hash(scope),
  );

  @override
  String toString() {
    return 'AuthorizeResult(publicKey: $publicKey, accountLabel: $accountLabel, walletUriBase: $walletUriBase, scope: $scope)';
  }
}

/// @nodoc
abstract mixin class $AuthorizeResultCopyWith<$Res> {
  factory $AuthorizeResultCopyWith(AuthorizeResult value, $Res Function(AuthorizeResult) _then) =
      _$AuthorizeResultCopyWithImpl;
  @useResult
  $Res call({Uint8List publicKey, String? accountLabel, Uri? walletUriBase, Uint8List? scope});
}

/// @nodoc
class _$AuthorizeResultCopyWithImpl<$Res> implements $AuthorizeResultCopyWith<$Res> {
  _$AuthorizeResultCopyWithImpl(this._self, this._then);

  final AuthorizeResult _self;
  final $Res Function(AuthorizeResult) _then;

  /// Create a copy of AuthorizeResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? accountLabel = freezed,
    Object? walletUriBase = freezed,
    Object? scope = freezed,
  }) {
    return _then(
      _self.copyWith(
        publicKey:
            null == publicKey
                ? _self.publicKey
                : publicKey // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        accountLabel:
            freezed == accountLabel
                ? _self.accountLabel
                : accountLabel // ignore: cast_nullable_to_non_nullable
                    as String?,
        walletUriBase:
            freezed == walletUriBase
                ? _self.walletUriBase
                : walletUriBase // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        scope:
            freezed == scope
                ? _self.scope
                : scope // ignore: cast_nullable_to_non_nullable
                    as Uint8List?,
      ),
    );
  }
}

/// @nodoc

class _AuthorizeResult implements AuthorizeResult {
  const _AuthorizeResult({
    required this.publicKey,
    this.accountLabel,
    this.walletUriBase,
    this.scope,
  });

  @override
  final Uint8List publicKey;
  @override
  final String? accountLabel;
  @override
  final Uri? walletUriBase;
  @override
  final Uint8List? scope;

  /// Create a copy of AuthorizeResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthorizeResultCopyWith<_AuthorizeResult> get copyWith =>
      __$AuthorizeResultCopyWithImpl<_AuthorizeResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthorizeResult &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            (identical(other.accountLabel, accountLabel) || other.accountLabel == accountLabel) &&
            (identical(other.walletUriBase, walletUriBase) ||
                other.walletUriBase == walletUriBase) &&
            const DeepCollectionEquality().equals(other.scope, scope));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(publicKey),
    accountLabel,
    walletUriBase,
    const DeepCollectionEquality().hash(scope),
  );

  @override
  String toString() {
    return 'AuthorizeResult(publicKey: $publicKey, accountLabel: $accountLabel, walletUriBase: $walletUriBase, scope: $scope)';
  }
}

/// @nodoc
abstract mixin class _$AuthorizeResultCopyWith<$Res> implements $AuthorizeResultCopyWith<$Res> {
  factory _$AuthorizeResultCopyWith(_AuthorizeResult value, $Res Function(_AuthorizeResult) _then) =
      __$AuthorizeResultCopyWithImpl;
  @override
  @useResult
  $Res call({Uint8List publicKey, String? accountLabel, Uri? walletUriBase, Uint8List? scope});
}

/// @nodoc
class __$AuthorizeResultCopyWithImpl<$Res> implements _$AuthorizeResultCopyWith<$Res> {
  __$AuthorizeResultCopyWithImpl(this._self, this._then);

  final _AuthorizeResult _self;
  final $Res Function(_AuthorizeResult) _then;

  /// Create a copy of AuthorizeResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? publicKey = null,
    Object? accountLabel = freezed,
    Object? walletUriBase = freezed,
    Object? scope = freezed,
  }) {
    return _then(
      _AuthorizeResult(
        publicKey:
            null == publicKey
                ? _self.publicKey
                : publicKey // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        accountLabel:
            freezed == accountLabel
                ? _self.accountLabel
                : accountLabel // ignore: cast_nullable_to_non_nullable
                    as String?,
        walletUriBase:
            freezed == walletUriBase
                ? _self.walletUriBase
                : walletUriBase // ignore: cast_nullable_to_non_nullable
                    as Uri?,
        scope:
            freezed == scope
                ? _self.scope
                : scope // ignore: cast_nullable_to_non_nullable
                    as Uint8List?,
      ),
    );
  }
}
