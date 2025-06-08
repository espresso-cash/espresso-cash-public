// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_and_send_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignAndSendTransactionsRequest {
  String? get identityName;
  Uri? get identityUri;
  Uri? get iconRelativeUri;
  String get cluster;
  Uint8List get authorizationScope;
  List<Uint8List> get transactions;
  int? get minContextSlot;

  /// Create a copy of SignAndSendTransactionsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignAndSendTransactionsRequestCopyWith<SignAndSendTransactionsRequest> get copyWith =>
      _$SignAndSendTransactionsRequestCopyWithImpl<SignAndSendTransactionsRequest>(
        this as SignAndSendTransactionsRequest,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignAndSendTransactionsRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality().equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality().equals(other.transactions, transactions) &&
            (identical(other.minContextSlot, minContextSlot) ||
                other.minContextSlot == minContextSlot));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityName,
    identityUri,
    iconRelativeUri,
    cluster,
    const DeepCollectionEquality().hash(authorizationScope),
    const DeepCollectionEquality().hash(transactions),
    minContextSlot,
  );

  @override
  String toString() {
    return 'SignAndSendTransactionsRequest(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope, transactions: $transactions, minContextSlot: $minContextSlot)';
  }
}

/// @nodoc
abstract mixin class $SignAndSendTransactionsRequestCopyWith<$Res> {
  factory $SignAndSendTransactionsRequestCopyWith(
    SignAndSendTransactionsRequest value,
    $Res Function(SignAndSendTransactionsRequest) _then,
  ) = _$SignAndSendTransactionsRequestCopyWithImpl;
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
    List<Uint8List> transactions,
    int? minContextSlot,
  });
}

/// @nodoc
class _$SignAndSendTransactionsRequestCopyWithImpl<$Res>
    implements $SignAndSendTransactionsRequestCopyWith<$Res> {
  _$SignAndSendTransactionsRequestCopyWithImpl(this._self, this._then);

  final SignAndSendTransactionsRequest _self;
  final $Res Function(SignAndSendTransactionsRequest) _then;

  /// Create a copy of SignAndSendTransactionsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? transactions = null,
    Object? minContextSlot = freezed,
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
        transactions:
            null == transactions
                ? _self.transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
        minContextSlot:
            freezed == minContextSlot
                ? _self.minContextSlot
                : minContextSlot // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc

class _SignAndSendTransactionsRequest implements SignAndSendTransactionsRequest {
  const _SignAndSendTransactionsRequest({
    required this.identityName,
    required this.identityUri,
    required this.iconRelativeUri,
    required this.cluster,
    required this.authorizationScope,
    required final List<Uint8List> transactions,
    required this.minContextSlot,
  }) : _transactions = transactions;

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
  final List<Uint8List> _transactions;
  @override
  List<Uint8List> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final int? minContextSlot;

  /// Create a copy of SignAndSendTransactionsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignAndSendTransactionsRequestCopyWith<_SignAndSendTransactionsRequest> get copyWith =>
      __$SignAndSendTransactionsRequestCopyWithImpl<_SignAndSendTransactionsRequest>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignAndSendTransactionsRequest &&
            (identical(other.identityName, identityName) || other.identityName == identityName) &&
            (identical(other.identityUri, identityUri) || other.identityUri == identityUri) &&
            (identical(other.iconRelativeUri, iconRelativeUri) ||
                other.iconRelativeUri == iconRelativeUri) &&
            (identical(other.cluster, cluster) || other.cluster == cluster) &&
            const DeepCollectionEquality().equals(other.authorizationScope, authorizationScope) &&
            const DeepCollectionEquality().equals(other._transactions, _transactions) &&
            (identical(other.minContextSlot, minContextSlot) ||
                other.minContextSlot == minContextSlot));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    identityName,
    identityUri,
    iconRelativeUri,
    cluster,
    const DeepCollectionEquality().hash(authorizationScope),
    const DeepCollectionEquality().hash(_transactions),
    minContextSlot,
  );

  @override
  String toString() {
    return 'SignAndSendTransactionsRequest(identityName: $identityName, identityUri: $identityUri, iconRelativeUri: $iconRelativeUri, cluster: $cluster, authorizationScope: $authorizationScope, transactions: $transactions, minContextSlot: $minContextSlot)';
  }
}

/// @nodoc
abstract mixin class _$SignAndSendTransactionsRequestCopyWith<$Res>
    implements $SignAndSendTransactionsRequestCopyWith<$Res> {
  factory _$SignAndSendTransactionsRequestCopyWith(
    _SignAndSendTransactionsRequest value,
    $Res Function(_SignAndSendTransactionsRequest) _then,
  ) = __$SignAndSendTransactionsRequestCopyWithImpl;
  @override
  @useResult
  $Res call({
    String? identityName,
    Uri? identityUri,
    Uri? iconRelativeUri,
    String cluster,
    Uint8List authorizationScope,
    List<Uint8List> transactions,
    int? minContextSlot,
  });
}

/// @nodoc
class __$SignAndSendTransactionsRequestCopyWithImpl<$Res>
    implements _$SignAndSendTransactionsRequestCopyWith<$Res> {
  __$SignAndSendTransactionsRequestCopyWithImpl(this._self, this._then);

  final _SignAndSendTransactionsRequest _self;
  final $Res Function(_SignAndSendTransactionsRequest) _then;

  /// Create a copy of SignAndSendTransactionsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? identityName = freezed,
    Object? identityUri = freezed,
    Object? iconRelativeUri = freezed,
    Object? cluster = null,
    Object? authorizationScope = null,
    Object? transactions = null,
    Object? minContextSlot = freezed,
  }) {
    return _then(
      _SignAndSendTransactionsRequest(
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
        transactions:
            null == transactions
                ? _self._transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
        minContextSlot:
            freezed == minContextSlot
                ? _self.minContextSlot
                : minContextSlot // ignore: cast_nullable_to_non_nullable
                    as int?,
      ),
    );
  }
}

/// @nodoc
mixin _$SignaturesResult {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignaturesResult);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignaturesResult()';
  }
}

/// @nodoc
class $SignaturesResultCopyWith<$Res> {
  $SignaturesResultCopyWith(SignaturesResult _, $Res Function(SignaturesResult) __);
}

/// @nodoc

class SignaturesResultSigned extends SignaturesResult {
  const SignaturesResultSigned({required final List<Uint8List> signatures})
    : _signatures = signatures,
      super._();

  final List<Uint8List> _signatures;
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  /// Create a copy of SignaturesResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignaturesResultSignedCopyWith<SignaturesResultSigned> get copyWith =>
      _$SignaturesResultSignedCopyWithImpl<SignaturesResultSigned>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignaturesResultSigned &&
            const DeepCollectionEquality().equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_signatures));

  @override
  String toString() {
    return 'SignaturesResult(signatures: $signatures)';
  }
}

/// @nodoc
abstract mixin class $SignaturesResultSignedCopyWith<$Res>
    implements $SignaturesResultCopyWith<$Res> {
  factory $SignaturesResultSignedCopyWith(
    SignaturesResultSigned value,
    $Res Function(SignaturesResultSigned) _then,
  ) = _$SignaturesResultSignedCopyWithImpl;
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class _$SignaturesResultSignedCopyWithImpl<$Res> implements $SignaturesResultSignedCopyWith<$Res> {
  _$SignaturesResultSignedCopyWithImpl(this._self, this._then);

  final SignaturesResultSigned _self;
  final $Res Function(SignaturesResultSigned) _then;

  /// Create a copy of SignaturesResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? signatures = null}) {
    return _then(
      SignaturesResultSigned(
        signatures:
            null == signatures
                ? _self._signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class SignaturesResultRequestDeclined extends SignaturesResult {
  const SignaturesResultRequestDeclined() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignaturesResultRequestDeclined);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignaturesResult.requestDeclined()';
  }
}

/// @nodoc

class SignaturesResultInvalidPayloads extends SignaturesResult {
  const SignaturesResultInvalidPayloads({required final List<bool> valid})
    : _valid = valid,
      super._();

  final List<bool> _valid;
  List<bool> get valid {
    if (_valid is EqualUnmodifiableListView) return _valid;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_valid);
  }

  /// Create a copy of SignaturesResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignaturesResultInvalidPayloadsCopyWith<SignaturesResultInvalidPayloads> get copyWith =>
      _$SignaturesResultInvalidPayloadsCopyWithImpl<SignaturesResultInvalidPayloads>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignaturesResultInvalidPayloads &&
            const DeepCollectionEquality().equals(other._valid, _valid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_valid));

  @override
  String toString() {
    return 'SignaturesResult.invalidPayloads(valid: $valid)';
  }
}

/// @nodoc
abstract mixin class $SignaturesResultInvalidPayloadsCopyWith<$Res>
    implements $SignaturesResultCopyWith<$Res> {
  factory $SignaturesResultInvalidPayloadsCopyWith(
    SignaturesResultInvalidPayloads value,
    $Res Function(SignaturesResultInvalidPayloads) _then,
  ) = _$SignaturesResultInvalidPayloadsCopyWithImpl;
  @useResult
  $Res call({List<bool> valid});
}

/// @nodoc
class _$SignaturesResultInvalidPayloadsCopyWithImpl<$Res>
    implements $SignaturesResultInvalidPayloadsCopyWith<$Res> {
  _$SignaturesResultInvalidPayloadsCopyWithImpl(this._self, this._then);

  final SignaturesResultInvalidPayloads _self;
  final $Res Function(SignaturesResultInvalidPayloads) _then;

  /// Create a copy of SignaturesResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? valid = null}) {
    return _then(
      SignaturesResultInvalidPayloads(
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

class SignaturesResultTooManyPayloads extends SignaturesResult {
  const SignaturesResultTooManyPayloads() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignaturesResultTooManyPayloads);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignaturesResult.tooManyPayloads()';
  }
}

/// @nodoc

class SignaturesResultAuthorizationNotValid extends SignaturesResult {
  const SignaturesResultAuthorizationNotValid() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SignaturesResultAuthorizationNotValid);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SignaturesResult.authorizationNotValid()';
  }
}

/// @nodoc

class SignaturesResultNotSubmitted extends SignaturesResult {
  const SignaturesResultNotSubmitted({required final List<Uint8List> signatures})
    : _signatures = signatures,
      super._();

  final List<Uint8List> _signatures;
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  /// Create a copy of SignaturesResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignaturesResultNotSubmittedCopyWith<SignaturesResultNotSubmitted> get copyWith =>
      _$SignaturesResultNotSubmittedCopyWithImpl<SignaturesResultNotSubmitted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignaturesResultNotSubmitted &&
            const DeepCollectionEquality().equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_signatures));

  @override
  String toString() {
    return 'SignaturesResult.notSubmitted(signatures: $signatures)';
  }
}

/// @nodoc
abstract mixin class $SignaturesResultNotSubmittedCopyWith<$Res>
    implements $SignaturesResultCopyWith<$Res> {
  factory $SignaturesResultNotSubmittedCopyWith(
    SignaturesResultNotSubmitted value,
    $Res Function(SignaturesResultNotSubmitted) _then,
  ) = _$SignaturesResultNotSubmittedCopyWithImpl;
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class _$SignaturesResultNotSubmittedCopyWithImpl<$Res>
    implements $SignaturesResultNotSubmittedCopyWith<$Res> {
  _$SignaturesResultNotSubmittedCopyWithImpl(this._self, this._then);

  final SignaturesResultNotSubmitted _self;
  final $Res Function(SignaturesResultNotSubmitted) _then;

  /// Create a copy of SignaturesResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? signatures = null}) {
    return _then(
      SignaturesResultNotSubmitted(
        signatures:
            null == signatures
                ? _self._signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}
