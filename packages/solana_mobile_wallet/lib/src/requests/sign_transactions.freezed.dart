// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignPayloadsRequest {
  String? get identityName;
  Uri? get identityUri;
  Uri? get iconRelativeUri;
  String get cluster;
  Uint8List get authorizationScope;
  List<Uint8List> get payloads;

  /// Create a copy of SignPayloadsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignPayloadsRequestCopyWith<SignPayloadsRequest> get copyWith =>
      _$SignPayloadsRequestCopyWithImpl<SignPayloadsRequest>(
        this as SignPayloadsRequest,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignPayloadsRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality().equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality().equals(other.payloads, payloads));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityName,
    identityUri,
    iconRelativeUri,
    cluster,
    const DeepCollectionEquality().hash(authorizationScope),
    const DeepCollectionEquality().hash(payloads),
  );

  @override
  String toString() {
    return 'SignPayloadsRequest(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope, payloads: $payloads)';
  }
}

/// @nodoc
abstract mixin class $SignPayloadsRequestCopyWith<$Res> {
  factory $SignPayloadsRequestCopyWith(
    SignPayloadsRequest value,
    $Res Function(SignPayloadsRequest) _then,
  ) = _$SignPayloadsRequestCopyWithImpl;
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
    List<Uint8List> payloads,
  });
}

/// @nodoc
class _$SignPayloadsRequestCopyWithImpl<$Res> implements $SignPayloadsRequestCopyWith<$Res> {
  _$SignPayloadsRequestCopyWithImpl(this._self, this._then);

  final SignPayloadsRequest _self;
  final $Res Function(SignPayloadsRequest) _then;

  /// Create a copy of SignPayloadsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? payloads = null,
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
        payloads:
            null == payloads
                ? _self.payloads
                : payloads // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class SignTransactionsRequest implements SignPayloadsRequest {
  const SignTransactionsRequest({
    required this.identityName,
    required this.identityUri,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
    required final List<Uint8List> payloads,
  }) : _payloads = payloads;

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
  final List<Uint8List> _payloads;
  @override
  List<Uint8List> get payloads {
    if (_payloads is EqualUnmodifiableListView) return _payloads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payloads);
  }

  /// Create a copy of SignPayloadsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignTransactionsRequestCopyWith<SignTransactionsRequest> get copyWith =>
      _$SignTransactionsRequestCopyWithImpl<SignTransactionsRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignTransactionsRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality().equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality().equals(other._payloads, _payloads));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityName,
    identityUri,
    iconRelativeUri,
    cluster,
    const DeepCollectionEquality().hash(authorizationScope),
    const DeepCollectionEquality().hash(_payloads),
  );

  @override
  String toString() {
    return 'SignPayloadsRequest.transactions(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope, payloads: $payloads)';
  }
}

/// @nodoc
abstract mixin class $SignTransactionsRequestCopyWith<$Res>
    implements $SignPayloadsRequestCopyWith<$Res> {
  factory $SignTransactionsRequestCopyWith(
    SignTransactionsRequest value,
    $Res Function(SignTransactionsRequest) _then,
  ) = _$SignTransactionsRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
    List<Uint8List> payloads,
  });
}

/// @nodoc
class _$SignTransactionsRequestCopyWithImpl<$Res>
    implements $SignTransactionsRequestCopyWith<$Res> {
  _$SignTransactionsRequestCopyWithImpl(this._self, this._then);

  final SignTransactionsRequest _self;
  final $Res Function(SignTransactionsRequest) _then;

  /// Create a copy of SignPayloadsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? payloads = null,
  }) {
    return _then(
      SignTransactionsRequest(
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
        payloads:
            null == payloads
                ? _self._payloads
                : payloads // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class SignMessagesRequest implements SignPayloadsRequest {
  const SignMessagesRequest({
    required this.identityName,
    required this.identityUri,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
    required final List<Uint8List> payloads,
  }) : _payloads = payloads;

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
  final List<Uint8List> _payloads;
  @override
  List<Uint8List> get payloads {
    if (_payloads is EqualUnmodifiableListView) return _payloads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payloads);
  }

  /// Create a copy of SignPayloadsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignMessagesRequestCopyWith<SignMessagesRequest> get copyWith =>
      _$SignMessagesRequestCopyWithImpl<SignMessagesRequest>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignMessagesRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality().equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality().equals(other._payloads, _payloads));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityName,
    identityUri,
    iconRelativeUri,
    cluster,
    const DeepCollectionEquality().hash(authorizationScope),
    const DeepCollectionEquality().hash(_payloads),
  );

  @override
  String toString() {
    return 'SignPayloadsRequest.messages(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope, payloads: $payloads)';
  }
}

/// @nodoc
abstract mixin class $SignMessagesRequestCopyWith<$Res>
    implements $SignPayloadsRequestCopyWith<$Res> {
  factory $SignMessagesRequestCopyWith(
    SignMessagesRequest value,
    $Res Function(SignMessagesRequest) _then,
  ) = _$SignMessagesRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
    List<Uint8List> payloads,
  });
}

/// @nodoc
class _$SignMessagesRequestCopyWithImpl<$Res> implements $SignMessagesRequestCopyWith<$Res> {
  _$SignMessagesRequestCopyWithImpl(this._self, this._then);

  final SignMessagesRequest _self;
  final $Res Function(SignMessagesRequest) _then;

  /// Create a copy of SignPayloadsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? payloads = null,
  }) {
    return _then(
      SignMessagesRequest(
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
        payloads:
            null == payloads
                ? _self._payloads
                : payloads // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc
mixin _$SignedPayloadResult {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignedPayloadResult);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignedPayloadResult()';
  }
}

/// @nodoc
class $SignedPayloadResultCopyWith<$Res> {
  $SignedPayloadResultCopyWith(SignedPayloadResult _, $Res Function(SignedPayloadResult) __);
}

/// @nodoc

class SignedPayloadResultSigned extends SignedPayloadResult {
  const SignedPayloadResultSigned({required final List<Uint8List> signedPayloads})
    : _signedPayloads = signedPayloads,
      super._();

  final List<Uint8List> _signedPayloads;
  List<Uint8List> get signedPayloads {
    if (_signedPayloads is EqualUnmodifiableListView) return _signedPayloads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signedPayloads);
  }

  /// Create a copy of SignedPayloadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignedPayloadResultSignedCopyWith<SignedPayloadResultSigned> get copyWith =>
      _$SignedPayloadResultSignedCopyWithImpl<SignedPayloadResultSigned>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignedPayloadResultSigned &&
            const DeepCollectionEquality().equals(other._signedPayloads, _signedPayloads));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_signedPayloads));

  @override
  String toString() {
    return 'SignedPayloadResult(signedPayloads: $signedPayloads)';
  }
}

/// @nodoc
abstract mixin class $SignedPayloadResultSignedCopyWith<$Res>
    implements $SignedPayloadResultCopyWith<$Res> {
  factory $SignedPayloadResultSignedCopyWith(
    SignedPayloadResultSigned value,
    $Res Function(SignedPayloadResultSigned) _then,
  ) = _$SignedPayloadResultSignedCopyWithImpl;
  @useResult
  $Res call({List<Uint8List> signedPayloads});
}

/// @nodoc
class _$SignedPayloadResultSignedCopyWithImpl<$Res>
    implements $SignedPayloadResultSignedCopyWith<$Res> {
  _$SignedPayloadResultSignedCopyWithImpl(this._self, this._then);

  final SignedPayloadResultSigned _self;
  final $Res Function(SignedPayloadResultSigned) _then;

  /// Create a copy of SignedPayloadResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? signedPayloads = null}) {
    return _then(
      SignedPayloadResultSigned(
        signedPayloads:
            null == signedPayloads
                ? _self._signedPayloads
                : signedPayloads // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class SignedPayloadResultRequestDeclined extends SignedPayloadResult {
  const SignedPayloadResultRequestDeclined() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignedPayloadResultRequestDeclined);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignedPayloadResult.requestDeclined()';
  }
}

/// @nodoc

class SignedPayloadResultInvalidPayloads extends SignedPayloadResult {
  const SignedPayloadResultInvalidPayloads({required final List<bool> valid})
    : _valid = valid,
      super._();

  final List<bool> _valid;
  List<bool> get valid {
    if (_valid is EqualUnmodifiableListView) return _valid;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_valid);
  }

  /// Create a copy of SignedPayloadResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignedPayloadResultInvalidPayloadsCopyWith<SignedPayloadResultInvalidPayloads> get copyWith =>
      _$SignedPayloadResultInvalidPayloadsCopyWithImpl<SignedPayloadResultInvalidPayloads>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignedPayloadResultInvalidPayloads &&
            const DeepCollectionEquality().equals(other._valid, _valid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_valid));

  @override
  String toString() {
    return 'SignedPayloadResult.invalidPayloads(valid: $valid)';
  }
}

/// @nodoc
abstract mixin class $SignedPayloadResultInvalidPayloadsCopyWith<$Res>
    implements $SignedPayloadResultCopyWith<$Res> {
  factory $SignedPayloadResultInvalidPayloadsCopyWith(
    SignedPayloadResultInvalidPayloads value,
    $Res Function(SignedPayloadResultInvalidPayloads) _then,
  ) = _$SignedPayloadResultInvalidPayloadsCopyWithImpl;
  @useResult
  $Res call({List<bool> valid});
}

/// @nodoc
class _$SignedPayloadResultInvalidPayloadsCopyWithImpl<$Res>
    implements $SignedPayloadResultInvalidPayloadsCopyWith<$Res> {
  _$SignedPayloadResultInvalidPayloadsCopyWithImpl(this._self, this._then);

  final SignedPayloadResultInvalidPayloads _self;
  final $Res Function(SignedPayloadResultInvalidPayloads) _then;

  /// Create a copy of SignedPayloadResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? valid = null}) {
    return _then(
      SignedPayloadResultInvalidPayloads(
        valid:
            null == valid
                ? _self._valid
                : valid // ignore: cast_nullable_to_non_nullable
                    as List<bool>,
      ),
    );
  }
}

/// @nodoc

class SignedPayloadResultTooManyPayloads extends SignedPayloadResult {
  const SignedPayloadResultTooManyPayloads() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignedPayloadResultTooManyPayloads);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignedPayloadResult.tooManyPayloads()';
  }
}

/// @nodoc

class SignedPayloadResultAuthorizationNotValid extends SignedPayloadResult {
  const SignedPayloadResultAuthorizationNotValid() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignedPayloadResultAuthorizationNotValid);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignedPayloadResult.authorizationNotValid()';
  }
}
