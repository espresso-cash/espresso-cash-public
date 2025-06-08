// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mobile_wallet_adapter_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetCapabilitiesResult {
  bool get supportsCloneAuthorization;
  bool get supportsSignAndSendTransactions;
  int get maxTransactionsPerSigningRequest;
  int get maxMessagesPerSigningRequest;

  /// Create a copy of GetCapabilitiesResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GetCapabilitiesResultCopyWith<GetCapabilitiesResult> get copyWith =>
      _$GetCapabilitiesResultCopyWithImpl<GetCapabilitiesResult>(
        this as GetCapabilitiesResult,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetCapabilitiesResult &&
            (identical(other.supportsCloneAuthorization, supportsCloneAuthorization) ||
                other.supportsCloneAuthorization == supportsCloneAuthorization) &&
            (identical(other.supportsSignAndSendTransactions, supportsSignAndSendTransactions) ||
                other.supportsSignAndSendTransactions == supportsSignAndSendTransactions) &&
            (identical(other.maxTransactionsPerSigningRequest, maxTransactionsPerSigningRequest) ||
                other.maxTransactionsPerSigningRequest == maxTransactionsPerSigningRequest) &&
            (identical(other.maxMessagesPerSigningRequest, maxMessagesPerSigningRequest) ||
                other.maxMessagesPerSigningRequest == maxMessagesPerSigningRequest));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    supportsCloneAuthorization,
    supportsSignAndSendTransactions,
    maxTransactionsPerSigningRequest,
    maxMessagesPerSigningRequest,
  );

  @override
  String toString() {
    return 'GetCapabilitiesResult(supportsCloneAuthorization: $supportsCloneAuthorization, supportsSignAndSendTransactions: $supportsSignAndSendTransactions, maxTransactionsPerSigningRequest: $maxTransactionsPerSigningRequest, maxMessagesPerSigningRequest: $maxMessagesPerSigningRequest)';
  }
}

/// @nodoc
abstract mixin class $GetCapabilitiesResultCopyWith<$Res> {
  factory $GetCapabilitiesResultCopyWith(
    GetCapabilitiesResult value,
    $Res Function(GetCapabilitiesResult) _then,
  ) = _$GetCapabilitiesResultCopyWithImpl;
  @useResult
  $Res call({
    bool supportsCloneAuthorization,
    bool supportsSignAndSendTransactions,
    int maxTransactionsPerSigningRequest,
    int maxMessagesPerSigningRequest,
  });
}

/// @nodoc
class _$GetCapabilitiesResultCopyWithImpl<$Res> implements $GetCapabilitiesResultCopyWith<$Res> {
  _$GetCapabilitiesResultCopyWithImpl(this._self, this._then);

  final GetCapabilitiesResult _self;
  final $Res Function(GetCapabilitiesResult) _then;

  /// Create a copy of GetCapabilitiesResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supportsCloneAuthorization = null,
    Object? supportsSignAndSendTransactions = null,
    Object? maxTransactionsPerSigningRequest = null,
    Object? maxMessagesPerSigningRequest = null,
  }) {
    return _then(
      _self.copyWith(
        supportsCloneAuthorization:
            null == supportsCloneAuthorization
                ? _self.supportsCloneAuthorization
                : supportsCloneAuthorization // ignore: cast_nullable_to_non_nullable
                    as bool,
        supportsSignAndSendTransactions:
            null == supportsSignAndSendTransactions
                ? _self.supportsSignAndSendTransactions
                : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
                    as bool,
        maxTransactionsPerSigningRequest:
            null == maxTransactionsPerSigningRequest
                ? _self.maxTransactionsPerSigningRequest
                : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
        maxMessagesPerSigningRequest:
            null == maxMessagesPerSigningRequest
                ? _self.maxMessagesPerSigningRequest
                : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _GetCapabilitiesResult implements GetCapabilitiesResult {
  const _GetCapabilitiesResult({
    required this.supportsCloneAuthorization,
    required this.supportsSignAndSendTransactions,
    required this.maxTransactionsPerSigningRequest,
    required this.maxMessagesPerSigningRequest,
  });

  @override
  final bool supportsCloneAuthorization;
  @override
  final bool supportsSignAndSendTransactions;
  @override
  final int maxTransactionsPerSigningRequest;
  @override
  final int maxMessagesPerSigningRequest;

  /// Create a copy of GetCapabilitiesResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GetCapabilitiesResultCopyWith<_GetCapabilitiesResult> get copyWith =>
      __$GetCapabilitiesResultCopyWithImpl<_GetCapabilitiesResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GetCapabilitiesResult &&
            (identical(other.supportsCloneAuthorization, supportsCloneAuthorization) ||
                other.supportsCloneAuthorization == supportsCloneAuthorization) &&
            (identical(other.supportsSignAndSendTransactions, supportsSignAndSendTransactions) ||
                other.supportsSignAndSendTransactions == supportsSignAndSendTransactions) &&
            (identical(other.maxTransactionsPerSigningRequest, maxTransactionsPerSigningRequest) ||
                other.maxTransactionsPerSigningRequest == maxTransactionsPerSigningRequest) &&
            (identical(other.maxMessagesPerSigningRequest, maxMessagesPerSigningRequest) ||
                other.maxMessagesPerSigningRequest == maxMessagesPerSigningRequest));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    supportsCloneAuthorization,
    supportsSignAndSendTransactions,
    maxTransactionsPerSigningRequest,
    maxMessagesPerSigningRequest,
  );

  @override
  String toString() {
    return 'GetCapabilitiesResult(supportsCloneAuthorization: $supportsCloneAuthorization, supportsSignAndSendTransactions: $supportsSignAndSendTransactions, maxTransactionsPerSigningRequest: $maxTransactionsPerSigningRequest, maxMessagesPerSigningRequest: $maxMessagesPerSigningRequest)';
  }
}

/// @nodoc
abstract mixin class _$GetCapabilitiesResultCopyWith<$Res>
    implements $GetCapabilitiesResultCopyWith<$Res> {
  factory _$GetCapabilitiesResultCopyWith(
    _GetCapabilitiesResult value,
    $Res Function(_GetCapabilitiesResult) _then,
  ) = __$GetCapabilitiesResultCopyWithImpl;
  @override
  @useResult
  $Res call({
    bool supportsCloneAuthorization,
    bool supportsSignAndSendTransactions,
    int maxTransactionsPerSigningRequest,
    int maxMessagesPerSigningRequest,
  });
}

/// @nodoc
class __$GetCapabilitiesResultCopyWithImpl<$Res> implements _$GetCapabilitiesResultCopyWith<$Res> {
  __$GetCapabilitiesResultCopyWithImpl(this._self, this._then);

  final _GetCapabilitiesResult _self;
  final $Res Function(_GetCapabilitiesResult) _then;

  /// Create a copy of GetCapabilitiesResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? supportsCloneAuthorization = null,
    Object? supportsSignAndSendTransactions = null,
    Object? maxTransactionsPerSigningRequest = null,
    Object? maxMessagesPerSigningRequest = null,
  }) {
    return _then(
      _GetCapabilitiesResult(
        supportsCloneAuthorization:
            null == supportsCloneAuthorization
                ? _self.supportsCloneAuthorization
                : supportsCloneAuthorization // ignore: cast_nullable_to_non_nullable
                    as bool,
        supportsSignAndSendTransactions:
            null == supportsSignAndSendTransactions
                ? _self.supportsSignAndSendTransactions
                : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
                    as bool,
        maxTransactionsPerSigningRequest:
            null == maxTransactionsPerSigningRequest
                ? _self.maxTransactionsPerSigningRequest
                : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
        maxMessagesPerSigningRequest:
            null == maxMessagesPerSigningRequest
                ? _self.maxMessagesPerSigningRequest
                : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
mixin _$AuthorizationResult {
  String get authToken;
  Uint8List get publicKey;
  String? get accountLabel;
  Uri? get walletUriBase;

  /// Create a copy of AuthorizationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthorizationResultCopyWith<AuthorizationResult> get copyWith =>
      _$AuthorizationResultCopyWithImpl<AuthorizationResult>(
        this as AuthorizationResult,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthorizationResult &&
            (identical(other.authToken, authToken) || other.authToken == authToken) &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            (identical(other.accountLabel, accountLabel) || other.accountLabel == accountLabel) &&
            (identical(other.walletUriBase, walletUriBase) ||
                other.walletUriBase == walletUriBase));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    authToken,
    const DeepCollectionEquality().hash(publicKey),
    accountLabel,
    walletUriBase,
  );

  @override
  String toString() {
    return 'AuthorizationResult(authToken: $authToken, publicKey: $publicKey, accountLabel: $accountLabel, walletUriBase: $walletUriBase)';
  }
}

/// @nodoc
abstract mixin class $AuthorizationResultCopyWith<$Res> {
  factory $AuthorizationResultCopyWith(
    AuthorizationResult value,
    $Res Function(AuthorizationResult) _then,
  ) = _$AuthorizationResultCopyWithImpl;
  @useResult
  $Res call({String authToken, Uint8List publicKey, String? accountLabel, Uri? walletUriBase});
}

/// @nodoc
class _$AuthorizationResultCopyWithImpl<$Res> implements $AuthorizationResultCopyWith<$Res> {
  _$AuthorizationResultCopyWithImpl(this._self, this._then);

  final AuthorizationResult _self;
  final $Res Function(AuthorizationResult) _then;

  /// Create a copy of AuthorizationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authToken = null,
    Object? publicKey = null,
    Object? accountLabel = freezed,
    Object? walletUriBase = freezed,
  }) {
    return _then(
      _self.copyWith(
        authToken:
            null == authToken
                ? _self.authToken
                : authToken // ignore: cast_nullable_to_non_nullable
                    as String,
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
      ),
    );
  }
}

/// @nodoc

class _AuthorizationResult implements AuthorizationResult {
  const _AuthorizationResult({
    required this.authToken,
    required this.publicKey,
    required this.accountLabel,
    required this.walletUriBase,
  });

  @override
  final String authToken;
  @override
  final Uint8List publicKey;
  @override
  final String? accountLabel;
  @override
  final Uri? walletUriBase;

  /// Create a copy of AuthorizationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthorizationResultCopyWith<_AuthorizationResult> get copyWith =>
      __$AuthorizationResultCopyWithImpl<_AuthorizationResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthorizationResult &&
            (identical(other.authToken, authToken) || other.authToken == authToken) &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            (identical(other.accountLabel, accountLabel) || other.accountLabel == accountLabel) &&
            (identical(other.walletUriBase, walletUriBase) ||
                other.walletUriBase == walletUriBase));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    authToken,
    const DeepCollectionEquality().hash(publicKey),
    accountLabel,
    walletUriBase,
  );

  @override
  String toString() {
    return 'AuthorizationResult(authToken: $authToken, publicKey: $publicKey, accountLabel: $accountLabel, walletUriBase: $walletUriBase)';
  }
}

/// @nodoc
abstract mixin class _$AuthorizationResultCopyWith<$Res>
    implements $AuthorizationResultCopyWith<$Res> {
  factory _$AuthorizationResultCopyWith(
    _AuthorizationResult value,
    $Res Function(_AuthorizationResult) _then,
  ) = __$AuthorizationResultCopyWithImpl;
  @override
  @useResult
  $Res call({String authToken, Uint8List publicKey, String? accountLabel, Uri? walletUriBase});
}

/// @nodoc
class __$AuthorizationResultCopyWithImpl<$Res> implements _$AuthorizationResultCopyWith<$Res> {
  __$AuthorizationResultCopyWithImpl(this._self, this._then);

  final _AuthorizationResult _self;
  final $Res Function(_AuthorizationResult) _then;

  /// Create a copy of AuthorizationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? authToken = null,
    Object? publicKey = null,
    Object? accountLabel = freezed,
    Object? walletUriBase = freezed,
  }) {
    return _then(
      _AuthorizationResult(
        authToken:
            null == authToken
                ? _self.authToken
                : authToken // ignore: cast_nullable_to_non_nullable
                    as String,
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
      ),
    );
  }
}

/// @nodoc
mixin _$SignPayloadsResult {
  List<Uint8List> get signedPayloads;

  /// Create a copy of SignPayloadsResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignPayloadsResultCopyWith<SignPayloadsResult> get copyWith =>
      _$SignPayloadsResultCopyWithImpl<SignPayloadsResult>(this as SignPayloadsResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignPayloadsResult &&
            const DeepCollectionEquality().equals(other.signedPayloads, signedPayloads));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(signedPayloads));

  @override
  String toString() {
    return 'SignPayloadsResult(signedPayloads: $signedPayloads)';
  }
}

/// @nodoc
abstract mixin class $SignPayloadsResultCopyWith<$Res> {
  factory $SignPayloadsResultCopyWith(
    SignPayloadsResult value,
    $Res Function(SignPayloadsResult) _then,
  ) = _$SignPayloadsResultCopyWithImpl;
  @useResult
  $Res call({List<Uint8List> signedPayloads});
}

/// @nodoc
class _$SignPayloadsResultCopyWithImpl<$Res> implements $SignPayloadsResultCopyWith<$Res> {
  _$SignPayloadsResultCopyWithImpl(this._self, this._then);

  final SignPayloadsResult _self;
  final $Res Function(SignPayloadsResult) _then;

  /// Create a copy of SignPayloadsResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signedPayloads = null}) {
    return _then(
      _self.copyWith(
        signedPayloads:
            null == signedPayloads
                ? _self.signedPayloads
                : signedPayloads // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class _SignPayloadsResult implements SignPayloadsResult {
  const _SignPayloadsResult({required final List<Uint8List> signedPayloads})
    : _signedPayloads = signedPayloads;

  final List<Uint8List> _signedPayloads;
  @override
  List<Uint8List> get signedPayloads {
    if (_signedPayloads is EqualUnmodifiableListView) return _signedPayloads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signedPayloads);
  }

  /// Create a copy of SignPayloadsResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignPayloadsResultCopyWith<_SignPayloadsResult> get copyWith =>
      __$SignPayloadsResultCopyWithImpl<_SignPayloadsResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignPayloadsResult &&
            const DeepCollectionEquality().equals(other._signedPayloads, _signedPayloads));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_signedPayloads));

  @override
  String toString() {
    return 'SignPayloadsResult(signedPayloads: $signedPayloads)';
  }
}

/// @nodoc
abstract mixin class _$SignPayloadsResultCopyWith<$Res>
    implements $SignPayloadsResultCopyWith<$Res> {
  factory _$SignPayloadsResultCopyWith(
    _SignPayloadsResult value,
    $Res Function(_SignPayloadsResult) _then,
  ) = __$SignPayloadsResultCopyWithImpl;
  @override
  @useResult
  $Res call({List<Uint8List> signedPayloads});
}

/// @nodoc
class __$SignPayloadsResultCopyWithImpl<$Res> implements _$SignPayloadsResultCopyWith<$Res> {
  __$SignPayloadsResultCopyWithImpl(this._self, this._then);

  final _SignPayloadsResult _self;
  final $Res Function(_SignPayloadsResult) _then;

  /// Create a copy of SignPayloadsResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? signedPayloads = null}) {
    return _then(
      _SignPayloadsResult(
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
mixin _$SignAndSendTransactionsResult {
  List<Uint8List> get signatures;

  /// Create a copy of SignAndSendTransactionsResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignAndSendTransactionsResultCopyWith<SignAndSendTransactionsResult> get copyWith =>
      _$SignAndSendTransactionsResultCopyWithImpl<SignAndSendTransactionsResult>(
        this as SignAndSendTransactionsResult,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignAndSendTransactionsResult &&
            const DeepCollectionEquality().equals(other.signatures, signatures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(signatures));

  @override
  String toString() {
    return 'SignAndSendTransactionsResult(signatures: $signatures)';
  }
}

/// @nodoc
abstract mixin class $SignAndSendTransactionsResultCopyWith<$Res> {
  factory $SignAndSendTransactionsResultCopyWith(
    SignAndSendTransactionsResult value,
    $Res Function(SignAndSendTransactionsResult) _then,
  ) = _$SignAndSendTransactionsResultCopyWithImpl;
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class _$SignAndSendTransactionsResultCopyWithImpl<$Res>
    implements $SignAndSendTransactionsResultCopyWith<$Res> {
  _$SignAndSendTransactionsResultCopyWithImpl(this._self, this._then);

  final SignAndSendTransactionsResult _self;
  final $Res Function(SignAndSendTransactionsResult) _then;

  /// Create a copy of SignAndSendTransactionsResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signatures = null}) {
    return _then(
      _self.copyWith(
        signatures:
            null == signatures
                ? _self.signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class _SignAndSendTransactionsResult implements SignAndSendTransactionsResult {
  const _SignAndSendTransactionsResult({required final List<Uint8List> signatures})
    : _signatures = signatures;

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  /// Create a copy of SignAndSendTransactionsResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignAndSendTransactionsResultCopyWith<_SignAndSendTransactionsResult> get copyWith =>
      __$SignAndSendTransactionsResultCopyWithImpl<_SignAndSendTransactionsResult>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignAndSendTransactionsResult &&
            const DeepCollectionEquality().equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_signatures));

  @override
  String toString() {
    return 'SignAndSendTransactionsResult(signatures: $signatures)';
  }
}

/// @nodoc
abstract mixin class _$SignAndSendTransactionsResultCopyWith<$Res>
    implements $SignAndSendTransactionsResultCopyWith<$Res> {
  factory _$SignAndSendTransactionsResultCopyWith(
    _SignAndSendTransactionsResult value,
    $Res Function(_SignAndSendTransactionsResult) _then,
  ) = __$SignAndSendTransactionsResultCopyWithImpl;
  @override
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class __$SignAndSendTransactionsResultCopyWithImpl<$Res>
    implements _$SignAndSendTransactionsResultCopyWith<$Res> {
  __$SignAndSendTransactionsResultCopyWithImpl(this._self, this._then);

  final _SignAndSendTransactionsResult _self;
  final $Res Function(_SignAndSendTransactionsResult) _then;

  /// Create a copy of SignAndSendTransactionsResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? signatures = null}) {
    return _then(
      _SignAndSendTransactionsResult(
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
mixin _$SignedMessage {
  Uint8List get message;
  List<Uint8List> get addresses;
  List<Uint8List> get signatures;

  /// Create a copy of SignedMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignedMessageCopyWith<SignedMessage> get copyWith =>
      _$SignedMessageCopyWithImpl<SignedMessage>(this as SignedMessage, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignedMessage &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.addresses, addresses) &&
            const DeepCollectionEquality().equals(other.signatures, signatures));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(message),
    const DeepCollectionEquality().hash(addresses),
    const DeepCollectionEquality().hash(signatures),
  );

  @override
  String toString() {
    return 'SignedMessage(message: $message, addresses: $addresses, signatures: $signatures)';
  }
}

/// @nodoc
abstract mixin class $SignedMessageCopyWith<$Res> {
  factory $SignedMessageCopyWith(SignedMessage value, $Res Function(SignedMessage) _then) =
      _$SignedMessageCopyWithImpl;
  @useResult
  $Res call({Uint8List message, List<Uint8List> addresses, List<Uint8List> signatures});
}

/// @nodoc
class _$SignedMessageCopyWithImpl<$Res> implements $SignedMessageCopyWith<$Res> {
  _$SignedMessageCopyWithImpl(this._self, this._then);

  final SignedMessage _self;
  final $Res Function(SignedMessage) _then;

  /// Create a copy of SignedMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? addresses = null, Object? signatures = null}) {
    return _then(
      _self.copyWith(
        message:
            null == message
                ? _self.message
                : message // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        addresses:
            null == addresses
                ? _self.addresses
                : addresses // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
        signatures:
            null == signatures
                ? _self.signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
      ),
    );
  }
}

/// @nodoc

class _SignedMessage implements SignedMessage {
  const _SignedMessage({
    required this.message,
    required final List<Uint8List> addresses,
    required final List<Uint8List> signatures,
  }) : _addresses = addresses,
       _signatures = signatures;

  @override
  final Uint8List message;
  final List<Uint8List> _addresses;
  @override
  List<Uint8List> get addresses {
    if (_addresses is EqualUnmodifiableListView) return _addresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addresses);
  }

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  /// Create a copy of SignedMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignedMessageCopyWith<_SignedMessage> get copyWith =>
      __$SignedMessageCopyWithImpl<_SignedMessage>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignedMessage &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other._addresses, _addresses) &&
            const DeepCollectionEquality().equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(message),
    const DeepCollectionEquality().hash(_addresses),
    const DeepCollectionEquality().hash(_signatures),
  );

  @override
  String toString() {
    return 'SignedMessage(message: $message, addresses: $addresses, signatures: $signatures)';
  }
}

/// @nodoc
abstract mixin class _$SignedMessageCopyWith<$Res> implements $SignedMessageCopyWith<$Res> {
  factory _$SignedMessageCopyWith(_SignedMessage value, $Res Function(_SignedMessage) _then) =
      __$SignedMessageCopyWithImpl;
  @override
  @useResult
  $Res call({Uint8List message, List<Uint8List> addresses, List<Uint8List> signatures});
}

/// @nodoc
class __$SignedMessageCopyWithImpl<$Res> implements _$SignedMessageCopyWith<$Res> {
  __$SignedMessageCopyWithImpl(this._self, this._then);

  final _SignedMessage _self;
  final $Res Function(_SignedMessage) _then;

  /// Create a copy of SignedMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? message = null, Object? addresses = null, Object? signatures = null}) {
    return _then(
      _SignedMessage(
        message:
            null == message
                ? _self.message
                : message // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        addresses:
            null == addresses
                ? _self._addresses
                : addresses // ignore: cast_nullable_to_non_nullable
                    as List<Uint8List>,
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
mixin _$SignMessagesResult {
  List<SignedMessage> get signedMessages;

  /// Create a copy of SignMessagesResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignMessagesResultCopyWith<SignMessagesResult> get copyWith =>
      _$SignMessagesResultCopyWithImpl<SignMessagesResult>(this as SignMessagesResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignMessagesResult &&
            const DeepCollectionEquality().equals(other.signedMessages, signedMessages));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(signedMessages));

  @override
  String toString() {
    return 'SignMessagesResult(signedMessages: $signedMessages)';
  }
}

/// @nodoc
abstract mixin class $SignMessagesResultCopyWith<$Res> {
  factory $SignMessagesResultCopyWith(
    SignMessagesResult value,
    $Res Function(SignMessagesResult) _then,
  ) = _$SignMessagesResultCopyWithImpl;
  @useResult
  $Res call({List<SignedMessage> signedMessages});
}

/// @nodoc
class _$SignMessagesResultCopyWithImpl<$Res> implements $SignMessagesResultCopyWith<$Res> {
  _$SignMessagesResultCopyWithImpl(this._self, this._then);

  final SignMessagesResult _self;
  final $Res Function(SignMessagesResult) _then;

  /// Create a copy of SignMessagesResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? signedMessages = null}) {
    return _then(
      _self.copyWith(
        signedMessages:
            null == signedMessages
                ? _self.signedMessages
                : signedMessages // ignore: cast_nullable_to_non_nullable
                    as List<SignedMessage>,
      ),
    );
  }
}

/// @nodoc

class _SignMessagesResult implements SignMessagesResult {
  const _SignMessagesResult({required final List<SignedMessage> signedMessages})
    : _signedMessages = signedMessages;

  final List<SignedMessage> _signedMessages;
  @override
  List<SignedMessage> get signedMessages {
    if (_signedMessages is EqualUnmodifiableListView) return _signedMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signedMessages);
  }

  /// Create a copy of SignMessagesResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SignMessagesResultCopyWith<_SignMessagesResult> get copyWith =>
      __$SignMessagesResultCopyWithImpl<_SignMessagesResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignMessagesResult &&
            const DeepCollectionEquality().equals(other._signedMessages, _signedMessages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_signedMessages));

  @override
  String toString() {
    return 'SignMessagesResult(signedMessages: $signedMessages)';
  }
}

/// @nodoc
abstract mixin class _$SignMessagesResultCopyWith<$Res>
    implements $SignMessagesResultCopyWith<$Res> {
  factory _$SignMessagesResultCopyWith(
    _SignMessagesResult value,
    $Res Function(_SignMessagesResult) _then,
  ) = __$SignMessagesResultCopyWithImpl;
  @override
  @useResult
  $Res call({List<SignedMessage> signedMessages});
}

/// @nodoc
class __$SignMessagesResultCopyWithImpl<$Res> implements _$SignMessagesResultCopyWith<$Res> {
  __$SignMessagesResultCopyWithImpl(this._self, this._then);

  final _SignMessagesResult _self;
  final $Res Function(_SignMessagesResult) _then;

  /// Create a copy of SignMessagesResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? signedMessages = null}) {
    return _then(
      _SignMessagesResult(
        signedMessages:
            null == signedMessages
                ? _self._signedMessages
                : signedMessages // ignore: cast_nullable_to_non_nullable
                    as List<SignedMessage>,
      ),
    );
  }
}
