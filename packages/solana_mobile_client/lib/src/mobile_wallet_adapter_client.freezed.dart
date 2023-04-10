// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mobile_wallet_adapter_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GetCapabilitiesResult {
  bool get supportsCloneAuthorization => throw _privateConstructorUsedError;
  bool get supportsSignAndSendTransactions =>
      throw _privateConstructorUsedError;
  int get maxTransactionsPerSigningRequest =>
      throw _privateConstructorUsedError;
  int get maxMessagesPerSigningRequest => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GetCapabilitiesResultCopyWith<GetCapabilitiesResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCapabilitiesResultCopyWith<$Res> {
  factory $GetCapabilitiesResultCopyWith(GetCapabilitiesResult value,
          $Res Function(GetCapabilitiesResult) then) =
      _$GetCapabilitiesResultCopyWithImpl<$Res, GetCapabilitiesResult>;
  @useResult
  $Res call(
      {bool supportsCloneAuthorization,
      bool supportsSignAndSendTransactions,
      int maxTransactionsPerSigningRequest,
      int maxMessagesPerSigningRequest});
}

/// @nodoc
class _$GetCapabilitiesResultCopyWithImpl<$Res,
        $Val extends GetCapabilitiesResult>
    implements $GetCapabilitiesResultCopyWith<$Res> {
  _$GetCapabilitiesResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supportsCloneAuthorization = null,
    Object? supportsSignAndSendTransactions = null,
    Object? maxTransactionsPerSigningRequest = null,
    Object? maxMessagesPerSigningRequest = null,
  }) {
    return _then(_value.copyWith(
      supportsCloneAuthorization: null == supportsCloneAuthorization
          ? _value.supportsCloneAuthorization
          : supportsCloneAuthorization // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsSignAndSendTransactions: null == supportsSignAndSendTransactions
          ? _value.supportsSignAndSendTransactions
          : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
              as bool,
      maxTransactionsPerSigningRequest: null == maxTransactionsPerSigningRequest
          ? _value.maxTransactionsPerSigningRequest
          : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
      maxMessagesPerSigningRequest: null == maxMessagesPerSigningRequest
          ? _value.maxMessagesPerSigningRequest
          : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetCapabilitiesResultCopyWith<$Res>
    implements $GetCapabilitiesResultCopyWith<$Res> {
  factory _$$_GetCapabilitiesResultCopyWith(_$_GetCapabilitiesResult value,
          $Res Function(_$_GetCapabilitiesResult) then) =
      __$$_GetCapabilitiesResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool supportsCloneAuthorization,
      bool supportsSignAndSendTransactions,
      int maxTransactionsPerSigningRequest,
      int maxMessagesPerSigningRequest});
}

/// @nodoc
class __$$_GetCapabilitiesResultCopyWithImpl<$Res>
    extends _$GetCapabilitiesResultCopyWithImpl<$Res, _$_GetCapabilitiesResult>
    implements _$$_GetCapabilitiesResultCopyWith<$Res> {
  __$$_GetCapabilitiesResultCopyWithImpl(_$_GetCapabilitiesResult _value,
      $Res Function(_$_GetCapabilitiesResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supportsCloneAuthorization = null,
    Object? supportsSignAndSendTransactions = null,
    Object? maxTransactionsPerSigningRequest = null,
    Object? maxMessagesPerSigningRequest = null,
  }) {
    return _then(_$_GetCapabilitiesResult(
      supportsCloneAuthorization: null == supportsCloneAuthorization
          ? _value.supportsCloneAuthorization
          : supportsCloneAuthorization // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsSignAndSendTransactions: null == supportsSignAndSendTransactions
          ? _value.supportsSignAndSendTransactions
          : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
              as bool,
      maxTransactionsPerSigningRequest: null == maxTransactionsPerSigningRequest
          ? _value.maxTransactionsPerSigningRequest
          : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
      maxMessagesPerSigningRequest: null == maxMessagesPerSigningRequest
          ? _value.maxMessagesPerSigningRequest
          : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GetCapabilitiesResult implements _GetCapabilitiesResult {
  const _$_GetCapabilitiesResult(
      {required this.supportsCloneAuthorization,
      required this.supportsSignAndSendTransactions,
      required this.maxTransactionsPerSigningRequest,
      required this.maxMessagesPerSigningRequest});

  @override
  final bool supportsCloneAuthorization;
  @override
  final bool supportsSignAndSendTransactions;
  @override
  final int maxTransactionsPerSigningRequest;
  @override
  final int maxMessagesPerSigningRequest;

  @override
  String toString() {
    return 'GetCapabilitiesResult(supportsCloneAuthorization: $supportsCloneAuthorization, supportsSignAndSendTransactions: $supportsSignAndSendTransactions, maxTransactionsPerSigningRequest: $maxTransactionsPerSigningRequest, maxMessagesPerSigningRequest: $maxMessagesPerSigningRequest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetCapabilitiesResult &&
            (identical(other.supportsCloneAuthorization,
                    supportsCloneAuthorization) ||
                other.supportsCloneAuthorization ==
                    supportsCloneAuthorization) &&
            (identical(other.supportsSignAndSendTransactions,
                    supportsSignAndSendTransactions) ||
                other.supportsSignAndSendTransactions ==
                    supportsSignAndSendTransactions) &&
            (identical(other.maxTransactionsPerSigningRequest,
                    maxTransactionsPerSigningRequest) ||
                other.maxTransactionsPerSigningRequest ==
                    maxTransactionsPerSigningRequest) &&
            (identical(other.maxMessagesPerSigningRequest,
                    maxMessagesPerSigningRequest) ||
                other.maxMessagesPerSigningRequest ==
                    maxMessagesPerSigningRequest));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      supportsCloneAuthorization,
      supportsSignAndSendTransactions,
      maxTransactionsPerSigningRequest,
      maxMessagesPerSigningRequest);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetCapabilitiesResultCopyWith<_$_GetCapabilitiesResult> get copyWith =>
      __$$_GetCapabilitiesResultCopyWithImpl<_$_GetCapabilitiesResult>(
          this, _$identity);
}

abstract class _GetCapabilitiesResult implements GetCapabilitiesResult {
  const factory _GetCapabilitiesResult(
          {required final bool supportsCloneAuthorization,
          required final bool supportsSignAndSendTransactions,
          required final int maxTransactionsPerSigningRequest,
          required final int maxMessagesPerSigningRequest}) =
      _$_GetCapabilitiesResult;

  @override
  bool get supportsCloneAuthorization;
  @override
  bool get supportsSignAndSendTransactions;
  @override
  int get maxTransactionsPerSigningRequest;
  @override
  int get maxMessagesPerSigningRequest;
  @override
  @JsonKey(ignore: true)
  _$$_GetCapabilitiesResultCopyWith<_$_GetCapabilitiesResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthorizationResult {
  String get authToken => throw _privateConstructorUsedError;
  Uint8List get publicKey => throw _privateConstructorUsedError;
  String? get accountLabel => throw _privateConstructorUsedError;
  Uri? get walletUriBase => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthorizationResultCopyWith<AuthorizationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorizationResultCopyWith<$Res> {
  factory $AuthorizationResultCopyWith(
          AuthorizationResult value, $Res Function(AuthorizationResult) then) =
      _$AuthorizationResultCopyWithImpl<$Res, AuthorizationResult>;
  @useResult
  $Res call(
      {String authToken,
      Uint8List publicKey,
      String? accountLabel,
      Uri? walletUriBase});
}

/// @nodoc
class _$AuthorizationResultCopyWithImpl<$Res, $Val extends AuthorizationResult>
    implements $AuthorizationResultCopyWith<$Res> {
  _$AuthorizationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authToken = null,
    Object? publicKey = null,
    Object? accountLabel = freezed,
    Object? walletUriBase = freezed,
  }) {
    return _then(_value.copyWith(
      authToken: null == authToken
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      accountLabel: freezed == accountLabel
          ? _value.accountLabel
          : accountLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      walletUriBase: freezed == walletUriBase
          ? _value.walletUriBase
          : walletUriBase // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthorizationResultCopyWith<$Res>
    implements $AuthorizationResultCopyWith<$Res> {
  factory _$$_AuthorizationResultCopyWith(_$_AuthorizationResult value,
          $Res Function(_$_AuthorizationResult) then) =
      __$$_AuthorizationResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String authToken,
      Uint8List publicKey,
      String? accountLabel,
      Uri? walletUriBase});
}

/// @nodoc
class __$$_AuthorizationResultCopyWithImpl<$Res>
    extends _$AuthorizationResultCopyWithImpl<$Res, _$_AuthorizationResult>
    implements _$$_AuthorizationResultCopyWith<$Res> {
  __$$_AuthorizationResultCopyWithImpl(_$_AuthorizationResult _value,
      $Res Function(_$_AuthorizationResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authToken = null,
    Object? publicKey = null,
    Object? accountLabel = freezed,
    Object? walletUriBase = freezed,
  }) {
    return _then(_$_AuthorizationResult(
      authToken: null == authToken
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      accountLabel: freezed == accountLabel
          ? _value.accountLabel
          : accountLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      walletUriBase: freezed == walletUriBase
          ? _value.walletUriBase
          : walletUriBase // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc

class _$_AuthorizationResult implements _AuthorizationResult {
  const _$_AuthorizationResult(
      {required this.authToken,
      required this.publicKey,
      required this.accountLabel,
      required this.walletUriBase});

  @override
  final String authToken;
  @override
  final Uint8List publicKey;
  @override
  final String? accountLabel;
  @override
  final Uri? walletUriBase;

  @override
  String toString() {
    return 'AuthorizationResult(authToken: $authToken, publicKey: $publicKey, accountLabel: $accountLabel, walletUriBase: $walletUriBase)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthorizationResult &&
            (identical(other.authToken, authToken) ||
                other.authToken == authToken) &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            (identical(other.accountLabel, accountLabel) ||
                other.accountLabel == accountLabel) &&
            (identical(other.walletUriBase, walletUriBase) ||
                other.walletUriBase == walletUriBase));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      authToken,
      const DeepCollectionEquality().hash(publicKey),
      accountLabel,
      walletUriBase);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthorizationResultCopyWith<_$_AuthorizationResult> get copyWith =>
      __$$_AuthorizationResultCopyWithImpl<_$_AuthorizationResult>(
          this, _$identity);
}

abstract class _AuthorizationResult implements AuthorizationResult {
  const factory _AuthorizationResult(
      {required final String authToken,
      required final Uint8List publicKey,
      required final String? accountLabel,
      required final Uri? walletUriBase}) = _$_AuthorizationResult;

  @override
  String get authToken;
  @override
  Uint8List get publicKey;
  @override
  String? get accountLabel;
  @override
  Uri? get walletUriBase;
  @override
  @JsonKey(ignore: true)
  _$$_AuthorizationResultCopyWith<_$_AuthorizationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignPayloadsResult {
  List<Uint8List> get signedPayloads => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignPayloadsResultCopyWith<SignPayloadsResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignPayloadsResultCopyWith<$Res> {
  factory $SignPayloadsResultCopyWith(
          SignPayloadsResult value, $Res Function(SignPayloadsResult) then) =
      _$SignPayloadsResultCopyWithImpl<$Res, SignPayloadsResult>;
  @useResult
  $Res call({List<Uint8List> signedPayloads});
}

/// @nodoc
class _$SignPayloadsResultCopyWithImpl<$Res, $Val extends SignPayloadsResult>
    implements $SignPayloadsResultCopyWith<$Res> {
  _$SignPayloadsResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedPayloads = null,
  }) {
    return _then(_value.copyWith(
      signedPayloads: null == signedPayloads
          ? _value.signedPayloads
          : signedPayloads // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignPayloadsResultCopyWith<$Res>
    implements $SignPayloadsResultCopyWith<$Res> {
  factory _$$_SignPayloadsResultCopyWith(_$_SignPayloadsResult value,
          $Res Function(_$_SignPayloadsResult) then) =
      __$$_SignPayloadsResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Uint8List> signedPayloads});
}

/// @nodoc
class __$$_SignPayloadsResultCopyWithImpl<$Res>
    extends _$SignPayloadsResultCopyWithImpl<$Res, _$_SignPayloadsResult>
    implements _$$_SignPayloadsResultCopyWith<$Res> {
  __$$_SignPayloadsResultCopyWithImpl(
      _$_SignPayloadsResult _value, $Res Function(_$_SignPayloadsResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedPayloads = null,
  }) {
    return _then(_$_SignPayloadsResult(
      signedPayloads: null == signedPayloads
          ? _value._signedPayloads
          : signedPayloads // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ));
  }
}

/// @nodoc

class _$_SignPayloadsResult implements _SignPayloadsResult {
  const _$_SignPayloadsResult({required final List<Uint8List> signedPayloads})
      : _signedPayloads = signedPayloads;

  final List<Uint8List> _signedPayloads;
  @override
  List<Uint8List> get signedPayloads {
    if (_signedPayloads is EqualUnmodifiableListView) return _signedPayloads;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signedPayloads);
  }

  @override
  String toString() {
    return 'SignPayloadsResult(signedPayloads: $signedPayloads)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignPayloadsResult &&
            const DeepCollectionEquality()
                .equals(other._signedPayloads, _signedPayloads));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_signedPayloads));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignPayloadsResultCopyWith<_$_SignPayloadsResult> get copyWith =>
      __$$_SignPayloadsResultCopyWithImpl<_$_SignPayloadsResult>(
          this, _$identity);
}

abstract class _SignPayloadsResult implements SignPayloadsResult {
  const factory _SignPayloadsResult(
      {required final List<Uint8List> signedPayloads}) = _$_SignPayloadsResult;

  @override
  List<Uint8List> get signedPayloads;
  @override
  @JsonKey(ignore: true)
  _$$_SignPayloadsResultCopyWith<_$_SignPayloadsResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignAndSendTransactionsResult {
  List<Uint8List> get signatures => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignAndSendTransactionsResultCopyWith<SignAndSendTransactionsResult>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignAndSendTransactionsResultCopyWith<$Res> {
  factory $SignAndSendTransactionsResultCopyWith(
          SignAndSendTransactionsResult value,
          $Res Function(SignAndSendTransactionsResult) then) =
      _$SignAndSendTransactionsResultCopyWithImpl<$Res,
          SignAndSendTransactionsResult>;
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class _$SignAndSendTransactionsResultCopyWithImpl<$Res,
        $Val extends SignAndSendTransactionsResult>
    implements $SignAndSendTransactionsResultCopyWith<$Res> {
  _$SignAndSendTransactionsResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signatures = null,
  }) {
    return _then(_value.copyWith(
      signatures: null == signatures
          ? _value.signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignAndSendTransactionsResultCopyWith<$Res>
    implements $SignAndSendTransactionsResultCopyWith<$Res> {
  factory _$$_SignAndSendTransactionsResultCopyWith(
          _$_SignAndSendTransactionsResult value,
          $Res Function(_$_SignAndSendTransactionsResult) then) =
      __$$_SignAndSendTransactionsResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Uint8List> signatures});
}

/// @nodoc
class __$$_SignAndSendTransactionsResultCopyWithImpl<$Res>
    extends _$SignAndSendTransactionsResultCopyWithImpl<$Res,
        _$_SignAndSendTransactionsResult>
    implements _$$_SignAndSendTransactionsResultCopyWith<$Res> {
  __$$_SignAndSendTransactionsResultCopyWithImpl(
      _$_SignAndSendTransactionsResult _value,
      $Res Function(_$_SignAndSendTransactionsResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signatures = null,
  }) {
    return _then(_$_SignAndSendTransactionsResult(
      signatures: null == signatures
          ? _value._signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ));
  }
}

/// @nodoc

class _$_SignAndSendTransactionsResult
    implements _SignAndSendTransactionsResult {
  const _$_SignAndSendTransactionsResult(
      {required final List<Uint8List> signatures})
      : _signatures = signatures;

  final List<Uint8List> _signatures;
  @override
  List<Uint8List> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  @override
  String toString() {
    return 'SignAndSendTransactionsResult(signatures: $signatures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignAndSendTransactionsResult &&
            const DeepCollectionEquality()
                .equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_signatures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignAndSendTransactionsResultCopyWith<_$_SignAndSendTransactionsResult>
      get copyWith => __$$_SignAndSendTransactionsResultCopyWithImpl<
          _$_SignAndSendTransactionsResult>(this, _$identity);
}

abstract class _SignAndSendTransactionsResult
    implements SignAndSendTransactionsResult {
  const factory _SignAndSendTransactionsResult(
          {required final List<Uint8List> signatures}) =
      _$_SignAndSendTransactionsResult;

  @override
  List<Uint8List> get signatures;
  @override
  @JsonKey(ignore: true)
  _$$_SignAndSendTransactionsResultCopyWith<_$_SignAndSendTransactionsResult>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignedMessage {
  Uint8List get message => throw _privateConstructorUsedError;
  List<Uint8List> get addresses => throw _privateConstructorUsedError;
  List<Uint8List> get signatures => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignedMessageCopyWith<SignedMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignedMessageCopyWith<$Res> {
  factory $SignedMessageCopyWith(
          SignedMessage value, $Res Function(SignedMessage) then) =
      _$SignedMessageCopyWithImpl<$Res, SignedMessage>;
  @useResult
  $Res call(
      {Uint8List message,
      List<Uint8List> addresses,
      List<Uint8List> signatures});
}

/// @nodoc
class _$SignedMessageCopyWithImpl<$Res, $Val extends SignedMessage>
    implements $SignedMessageCopyWith<$Res> {
  _$SignedMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? addresses = null,
    Object? signatures = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      addresses: null == addresses
          ? _value.addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
      signatures: null == signatures
          ? _value.signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignedMessageCopyWith<$Res>
    implements $SignedMessageCopyWith<$Res> {
  factory _$$_SignedMessageCopyWith(
          _$_SignedMessage value, $Res Function(_$_SignedMessage) then) =
      __$$_SignedMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uint8List message,
      List<Uint8List> addresses,
      List<Uint8List> signatures});
}

/// @nodoc
class __$$_SignedMessageCopyWithImpl<$Res>
    extends _$SignedMessageCopyWithImpl<$Res, _$_SignedMessage>
    implements _$$_SignedMessageCopyWith<$Res> {
  __$$_SignedMessageCopyWithImpl(
      _$_SignedMessage _value, $Res Function(_$_SignedMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? addresses = null,
    Object? signatures = null,
  }) {
    return _then(_$_SignedMessage(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      addresses: null == addresses
          ? _value._addresses
          : addresses // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
      signatures: null == signatures
          ? _value._signatures
          : signatures // ignore: cast_nullable_to_non_nullable
              as List<Uint8List>,
    ));
  }
}

/// @nodoc

class _$_SignedMessage implements _SignedMessage {
  const _$_SignedMessage(
      {required this.message,
      required final List<Uint8List> addresses,
      required final List<Uint8List> signatures})
      : _addresses = addresses,
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

  @override
  String toString() {
    return 'SignedMessage(message: $message, addresses: $addresses, signatures: $signatures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignedMessage &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other._addresses, _addresses) &&
            const DeepCollectionEquality()
                .equals(other._signatures, _signatures));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(_addresses),
      const DeepCollectionEquality().hash(_signatures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignedMessageCopyWith<_$_SignedMessage> get copyWith =>
      __$$_SignedMessageCopyWithImpl<_$_SignedMessage>(this, _$identity);
}

abstract class _SignedMessage implements SignedMessage {
  const factory _SignedMessage(
      {required final Uint8List message,
      required final List<Uint8List> addresses,
      required final List<Uint8List> signatures}) = _$_SignedMessage;

  @override
  Uint8List get message;
  @override
  List<Uint8List> get addresses;
  @override
  List<Uint8List> get signatures;
  @override
  @JsonKey(ignore: true)
  _$$_SignedMessageCopyWith<_$_SignedMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignMessagesResult {
  List<SignedMessage> get signedMessages => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignMessagesResultCopyWith<SignMessagesResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignMessagesResultCopyWith<$Res> {
  factory $SignMessagesResultCopyWith(
          SignMessagesResult value, $Res Function(SignMessagesResult) then) =
      _$SignMessagesResultCopyWithImpl<$Res, SignMessagesResult>;
  @useResult
  $Res call({List<SignedMessage> signedMessages});
}

/// @nodoc
class _$SignMessagesResultCopyWithImpl<$Res, $Val extends SignMessagesResult>
    implements $SignMessagesResultCopyWith<$Res> {
  _$SignMessagesResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedMessages = null,
  }) {
    return _then(_value.copyWith(
      signedMessages: null == signedMessages
          ? _value.signedMessages
          : signedMessages // ignore: cast_nullable_to_non_nullable
              as List<SignedMessage>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignMessagesResultCopyWith<$Res>
    implements $SignMessagesResultCopyWith<$Res> {
  factory _$$_SignMessagesResultCopyWith(_$_SignMessagesResult value,
          $Res Function(_$_SignMessagesResult) then) =
      __$$_SignMessagesResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SignedMessage> signedMessages});
}

/// @nodoc
class __$$_SignMessagesResultCopyWithImpl<$Res>
    extends _$SignMessagesResultCopyWithImpl<$Res, _$_SignMessagesResult>
    implements _$$_SignMessagesResultCopyWith<$Res> {
  __$$_SignMessagesResultCopyWithImpl(
      _$_SignMessagesResult _value, $Res Function(_$_SignMessagesResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedMessages = null,
  }) {
    return _then(_$_SignMessagesResult(
      signedMessages: null == signedMessages
          ? _value._signedMessages
          : signedMessages // ignore: cast_nullable_to_non_nullable
              as List<SignedMessage>,
    ));
  }
}

/// @nodoc

class _$_SignMessagesResult implements _SignMessagesResult {
  const _$_SignMessagesResult(
      {required final List<SignedMessage> signedMessages})
      : _signedMessages = signedMessages;

  final List<SignedMessage> _signedMessages;
  @override
  List<SignedMessage> get signedMessages {
    if (_signedMessages is EqualUnmodifiableListView) return _signedMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signedMessages);
  }

  @override
  String toString() {
    return 'SignMessagesResult(signedMessages: $signedMessages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignMessagesResult &&
            const DeepCollectionEquality()
                .equals(other._signedMessages, _signedMessages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_signedMessages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignMessagesResultCopyWith<_$_SignMessagesResult> get copyWith =>
      __$$_SignMessagesResultCopyWithImpl<_$_SignMessagesResult>(
          this, _$identity);
}

abstract class _SignMessagesResult implements SignMessagesResult {
  const factory _SignMessagesResult(
          {required final List<SignedMessage> signedMessages}) =
      _$_SignMessagesResult;

  @override
  List<SignedMessage> get signedMessages;
  @override
  @JsonKey(ignore: true)
  _$$_SignMessagesResultCopyWith<_$_SignMessagesResult> get copyWith =>
      throw _privateConstructorUsedError;
}
