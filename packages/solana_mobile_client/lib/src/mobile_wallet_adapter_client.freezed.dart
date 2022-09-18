// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$GetCapabilitiesResultCopyWithImpl<$Res>;
  $Res call(
      {bool supportsCloneAuthorization,
      bool supportsSignAndSendTransactions,
      int maxTransactionsPerSigningRequest,
      int maxMessagesPerSigningRequest});
}

/// @nodoc
class _$GetCapabilitiesResultCopyWithImpl<$Res>
    implements $GetCapabilitiesResultCopyWith<$Res> {
  _$GetCapabilitiesResultCopyWithImpl(this._value, this._then);

  final GetCapabilitiesResult _value;
  // ignore: unused_field
  final $Res Function(GetCapabilitiesResult) _then;

  @override
  $Res call({
    Object? supportsCloneAuthorization = freezed,
    Object? supportsSignAndSendTransactions = freezed,
    Object? maxTransactionsPerSigningRequest = freezed,
    Object? maxMessagesPerSigningRequest = freezed,
  }) {
    return _then(_value.copyWith(
      supportsCloneAuthorization: supportsCloneAuthorization == freezed
          ? _value.supportsCloneAuthorization
          : supportsCloneAuthorization // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsSignAndSendTransactions: supportsSignAndSendTransactions ==
              freezed
          ? _value.supportsSignAndSendTransactions
          : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
              as bool,
      maxTransactionsPerSigningRequest: maxTransactionsPerSigningRequest ==
              freezed
          ? _value.maxTransactionsPerSigningRequest
          : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
      maxMessagesPerSigningRequest: maxMessagesPerSigningRequest == freezed
          ? _value.maxMessagesPerSigningRequest
          : maxMessagesPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_GetCapabilitiesResultCopyWith<$Res>
    implements $GetCapabilitiesResultCopyWith<$Res> {
  factory _$$_GetCapabilitiesResultCopyWith(_$_GetCapabilitiesResult value,
          $Res Function(_$_GetCapabilitiesResult) then) =
      __$$_GetCapabilitiesResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool supportsCloneAuthorization,
      bool supportsSignAndSendTransactions,
      int maxTransactionsPerSigningRequest,
      int maxMessagesPerSigningRequest});
}

/// @nodoc
class __$$_GetCapabilitiesResultCopyWithImpl<$Res>
    extends _$GetCapabilitiesResultCopyWithImpl<$Res>
    implements _$$_GetCapabilitiesResultCopyWith<$Res> {
  __$$_GetCapabilitiesResultCopyWithImpl(_$_GetCapabilitiesResult _value,
      $Res Function(_$_GetCapabilitiesResult) _then)
      : super(_value, (v) => _then(v as _$_GetCapabilitiesResult));

  @override
  _$_GetCapabilitiesResult get _value =>
      super._value as _$_GetCapabilitiesResult;

  @override
  $Res call({
    Object? supportsCloneAuthorization = freezed,
    Object? supportsSignAndSendTransactions = freezed,
    Object? maxTransactionsPerSigningRequest = freezed,
    Object? maxMessagesPerSigningRequest = freezed,
  }) {
    return _then(_$_GetCapabilitiesResult(
      supportsCloneAuthorization: supportsCloneAuthorization == freezed
          ? _value.supportsCloneAuthorization
          : supportsCloneAuthorization // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsSignAndSendTransactions: supportsSignAndSendTransactions ==
              freezed
          ? _value.supportsSignAndSendTransactions
          : supportsSignAndSendTransactions // ignore: cast_nullable_to_non_nullable
              as bool,
      maxTransactionsPerSigningRequest: maxTransactionsPerSigningRequest ==
              freezed
          ? _value.maxTransactionsPerSigningRequest
          : maxTransactionsPerSigningRequest // ignore: cast_nullable_to_non_nullable
              as int,
      maxMessagesPerSigningRequest: maxMessagesPerSigningRequest == freezed
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
            const DeepCollectionEquality().equals(
                other.supportsCloneAuthorization, supportsCloneAuthorization) &&
            const DeepCollectionEquality().equals(
                other.supportsSignAndSendTransactions,
                supportsSignAndSendTransactions) &&
            const DeepCollectionEquality().equals(
                other.maxTransactionsPerSigningRequest,
                maxTransactionsPerSigningRequest) &&
            const DeepCollectionEquality().equals(
                other.maxMessagesPerSigningRequest,
                maxMessagesPerSigningRequest));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(supportsCloneAuthorization),
      const DeepCollectionEquality().hash(supportsSignAndSendTransactions),
      const DeepCollectionEquality().hash(maxTransactionsPerSigningRequest),
      const DeepCollectionEquality().hash(maxMessagesPerSigningRequest));

  @JsonKey(ignore: true)
  @override
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
      _$AuthorizationResultCopyWithImpl<$Res>;
  $Res call(
      {String authToken,
      Uint8List publicKey,
      String? accountLabel,
      Uri? walletUriBase});
}

/// @nodoc
class _$AuthorizationResultCopyWithImpl<$Res>
    implements $AuthorizationResultCopyWith<$Res> {
  _$AuthorizationResultCopyWithImpl(this._value, this._then);

  final AuthorizationResult _value;
  // ignore: unused_field
  final $Res Function(AuthorizationResult) _then;

  @override
  $Res call({
    Object? authToken = freezed,
    Object? publicKey = freezed,
    Object? accountLabel = freezed,
    Object? walletUriBase = freezed,
  }) {
    return _then(_value.copyWith(
      authToken: authToken == freezed
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: publicKey == freezed
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      accountLabel: accountLabel == freezed
          ? _value.accountLabel
          : accountLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      walletUriBase: walletUriBase == freezed
          ? _value.walletUriBase
          : walletUriBase // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc
abstract class _$$_AuthorizationResultCopyWith<$Res>
    implements $AuthorizationResultCopyWith<$Res> {
  factory _$$_AuthorizationResultCopyWith(_$_AuthorizationResult value,
          $Res Function(_$_AuthorizationResult) then) =
      __$$_AuthorizationResultCopyWithImpl<$Res>;
  @override
  $Res call(
      {String authToken,
      Uint8List publicKey,
      String? accountLabel,
      Uri? walletUriBase});
}

/// @nodoc
class __$$_AuthorizationResultCopyWithImpl<$Res>
    extends _$AuthorizationResultCopyWithImpl<$Res>
    implements _$$_AuthorizationResultCopyWith<$Res> {
  __$$_AuthorizationResultCopyWithImpl(_$_AuthorizationResult _value,
      $Res Function(_$_AuthorizationResult) _then)
      : super(_value, (v) => _then(v as _$_AuthorizationResult));

  @override
  _$_AuthorizationResult get _value => super._value as _$_AuthorizationResult;

  @override
  $Res call({
    Object? authToken = freezed,
    Object? publicKey = freezed,
    Object? accountLabel = freezed,
    Object? walletUriBase = freezed,
  }) {
    return _then(_$_AuthorizationResult(
      authToken: authToken == freezed
          ? _value.authToken
          : authToken // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: publicKey == freezed
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      accountLabel: accountLabel == freezed
          ? _value.accountLabel
          : accountLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      walletUriBase: walletUriBase == freezed
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
            const DeepCollectionEquality().equals(other.authToken, authToken) &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            const DeepCollectionEquality()
                .equals(other.accountLabel, accountLabel) &&
            const DeepCollectionEquality()
                .equals(other.walletUriBase, walletUriBase));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(authToken),
      const DeepCollectionEquality().hash(publicKey),
      const DeepCollectionEquality().hash(accountLabel),
      const DeepCollectionEquality().hash(walletUriBase));

  @JsonKey(ignore: true)
  @override
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
