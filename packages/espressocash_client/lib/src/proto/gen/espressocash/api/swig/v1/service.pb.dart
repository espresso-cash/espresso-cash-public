// This is a generated file - do not edit.
//
// Generated from espressocash/api/swig/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'service.pbenum.dart';

/// Request to create a SWIG wallet
class CreateWalletRequest extends $pb.GeneratedMessage {
  factory CreateWalletRequest({
    $core.String? ownerAddress,
    $core.List<$core.int>? passkeyPublicKey,
    $core.List<$core.int>? privyPublicKey,
    $core.String? platform,
  }) {
    final result = create();
    if (ownerAddress != null) result.ownerAddress = ownerAddress;
    if (passkeyPublicKey != null) result.passkeyPublicKey = passkeyPublicKey;
    if (privyPublicKey != null) result.privyPublicKey = privyPublicKey;
    if (platform != null) result.platform = platform;
    return result;
  }

  CreateWalletRequest._();

  factory CreateWalletRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateWalletRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateWalletRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAddress')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'passkeyPublicKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'privyPublicKey', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'platform')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateWalletRequest clone() => CreateWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateWalletRequest copyWith(void Function(CreateWalletRequest) updates) =>
      super.copyWith((message) => updates(message as CreateWalletRequest))
          as CreateWalletRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWalletRequest create() => CreateWalletRequest._();
  @$core.override
  CreateWalletRequest createEmptyInstance() => create();
  static $pb.PbList<CreateWalletRequest> createRepeated() =>
      $pb.PbList<CreateWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateWalletRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateWalletRequest>(create);
  static CreateWalletRequest? _defaultInstance;

  /// Owner's wallet address
  @$pb.TagNumber(1)
  $core.String get ownerAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAddress() => $_clearField(1);

  /// Passkey public key (primary authority) - optional, defaults to owner
  @$pb.TagNumber(2)
  $core.List<$core.int> get passkeyPublicKey => $_getN(1);
  @$pb.TagNumber(2)
  set passkeyPublicKey($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPasskeyPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPasskeyPublicKey() => $_clearField(2);

  /// Privy public key (backup authority) - optional, defaults to owner
  @$pb.TagNumber(3)
  $core.List<$core.int> get privyPublicKey => $_getN(2);
  @$pb.TagNumber(3)
  set privyPublicKey($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPrivyPublicKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrivyPublicKey() => $_clearField(3);

  /// Platform creating the wallet
  @$pb.TagNumber(4)
  $core.String get platform => $_getSZ(3);
  @$pb.TagNumber(4)
  set platform($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPlatform() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlatform() => $_clearField(4);
}

/// Response with SWIG wallet creation details
class CreateWalletResponse extends $pb.GeneratedMessage {
  factory CreateWalletResponse({
    $core.String? unsignedTransaction,
    $core.String? swigWalletAddress,
  }) {
    final result = create();
    if (unsignedTransaction != null)
      result.unsignedTransaction = unsignedTransaction;
    if (swigWalletAddress != null) result.swigWalletAddress = swigWalletAddress;
    return result;
  }

  CreateWalletResponse._();

  factory CreateWalletResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateWalletResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateWalletResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'unsignedTransaction')
    ..aOS(2, _omitFieldNames ? '' : 'swigWalletAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateWalletResponse clone() =>
      CreateWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateWalletResponse copyWith(void Function(CreateWalletResponse) updates) =>
      super.copyWith((message) => updates(message as CreateWalletResponse))
          as CreateWalletResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWalletResponse create() => CreateWalletResponse._();
  @$core.override
  CreateWalletResponse createEmptyInstance() => create();
  static $pb.PbList<CreateWalletResponse> createRepeated() =>
      $pb.PbList<CreateWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateWalletResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateWalletResponse>(create);
  static CreateWalletResponse? _defaultInstance;

  /// Unsigned transaction (base64 encoded)
  @$pb.TagNumber(1)
  $core.String get unsignedTransaction => $_getSZ(0);
  @$pb.TagNumber(1)
  set unsignedTransaction($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUnsignedTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearUnsignedTransaction() => $_clearField(1);

  /// SWIG wallet address (derived)
  @$pb.TagNumber(2)
  $core.String get swigWalletAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set swigWalletAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSwigWalletAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwigWalletAddress() => $_clearField(2);
}

/// Request to create a SWIG wallet with platform fee payment
class SubmitCreateWalletRequest extends $pb.GeneratedMessage {
  factory SubmitCreateWalletRequest({
    $core.String? ownerAddress,
    $core.String? mintAddress,
  }) {
    final result = create();
    if (ownerAddress != null) result.ownerAddress = ownerAddress;
    if (mintAddress != null) result.mintAddress = mintAddress;
    return result;
  }

  SubmitCreateWalletRequest._();

  factory SubmitCreateWalletRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitCreateWalletRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitCreateWalletRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ownerAddress')
    ..aOS(2, _omitFieldNames ? '' : 'mintAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitCreateWalletRequest clone() =>
      SubmitCreateWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitCreateWalletRequest copyWith(
          void Function(SubmitCreateWalletRequest) updates) =>
      super.copyWith((message) => updates(message as SubmitCreateWalletRequest))
          as SubmitCreateWalletRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitCreateWalletRequest create() => SubmitCreateWalletRequest._();
  @$core.override
  SubmitCreateWalletRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitCreateWalletRequest> createRepeated() =>
      $pb.PbList<SubmitCreateWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitCreateWalletRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitCreateWalletRequest>(create);
  static SubmitCreateWalletRequest? _defaultInstance;

  /// Owner's wallet address
  @$pb.TagNumber(1)
  $core.String get ownerAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ownerAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOwnerAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearOwnerAddress() => $_clearField(1);

  /// Optional mint address for associated token account creation
  @$pb.TagNumber(2)
  $core.String get mintAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set mintAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMintAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearMintAddress() => $_clearField(2);
}

/// Response with SWIG wallet creation details (platform pays fees)
class SubmitCreateWalletResponse extends $pb.GeneratedMessage {
  factory SubmitCreateWalletResponse({
    $core.String? swigWalletAddress,
    $core.String? transactionSignature,
    $core.String? feesPaidBy,
    $fixnum.Int64? actualFee,
  }) {
    final result = create();
    if (swigWalletAddress != null) result.swigWalletAddress = swigWalletAddress;
    if (transactionSignature != null)
      result.transactionSignature = transactionSignature;
    if (feesPaidBy != null) result.feesPaidBy = feesPaidBy;
    if (actualFee != null) result.actualFee = actualFee;
    return result;
  }

  SubmitCreateWalletResponse._();

  factory SubmitCreateWalletResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitCreateWalletResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitCreateWalletResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'swigWalletAddress')
    ..aOS(2, _omitFieldNames ? '' : 'transactionSignature')
    ..aOS(3, _omitFieldNames ? '' : 'feesPaidBy')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'actualFee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitCreateWalletResponse clone() =>
      SubmitCreateWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitCreateWalletResponse copyWith(
          void Function(SubmitCreateWalletResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitCreateWalletResponse))
          as SubmitCreateWalletResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitCreateWalletResponse create() => SubmitCreateWalletResponse._();
  @$core.override
  SubmitCreateWalletResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitCreateWalletResponse> createRepeated() =>
      $pb.PbList<SubmitCreateWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitCreateWalletResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitCreateWalletResponse>(create);
  static SubmitCreateWalletResponse? _defaultInstance;

  /// SWIG wallet address (derived)
  @$pb.TagNumber(1)
  $core.String get swigWalletAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set swigWalletAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSwigWalletAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearSwigWalletAddress() => $_clearField(1);

  /// Final transaction signature
  @$pb.TagNumber(2)
  $core.String get transactionSignature => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionSignature($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionSignature() => $_clearField(2);

  /// Account that paid fees (platform)
  @$pb.TagNumber(3)
  $core.String get feesPaidBy => $_getSZ(2);
  @$pb.TagNumber(3)
  set feesPaidBy($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeesPaidBy() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeesPaidBy() => $_clearField(3);

  /// Actual fee paid
  @$pb.TagNumber(4)
  $fixnum.Int64 get actualFee => $_getI64(3);
  @$pb.TagNumber(4)
  set actualFee($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActualFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearActualFee() => $_clearField(4);
}

/// SigningResult matches swig-ts SigningResult interface exactly
class SigningResult extends $pb.GeneratedMessage {
  factory SigningResult({
    $core.List<$core.int>? signature,
    $core.List<$core.int>? prefix,
    $core.List<$core.int>? message,
  }) {
    final result = create();
    if (signature != null) result.signature = signature;
    if (prefix != null) result.prefix = prefix;
    if (message != null) result.message = message;
    return result;
  }

  SigningResult._();

  factory SigningResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SigningResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SigningResult',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'prefix', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'message', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SigningResult clone() => SigningResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SigningResult copyWith(void Function(SigningResult) updates) =>
      super.copyWith((message) => updates(message as SigningResult))
          as SigningResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SigningResult create() => SigningResult._();
  @$core.override
  SigningResult createEmptyInstance() => create();
  static $pb.PbList<SigningResult> createRepeated() =>
      $pb.PbList<SigningResult>();
  @$core.pragma('dart2js:noInline')
  static SigningResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SigningResult>(create);
  static SigningResult? _defaultInstance;

  /// Always present - matches swig-ts SigningResult.signature
  @$pb.TagNumber(1)
  $core.List<$core.int> get signature => $_getN(0);
  @$pb.TagNumber(1)
  set signature($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);

  /// Optional - matches swig-ts SigningResult.prefix (Secp256r1 WebAuthn)
  @$pb.TagNumber(2)
  $core.List<$core.int> get prefix => $_getN(1);
  @$pb.TagNumber(2)
  set prefix($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPrefix() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrefix() => $_clearField(2);

  /// Optional - matches swig-ts SigningResult.message (Secp256r1 WebAuthn)
  @$pb.TagNumber(3)
  $core.List<$core.int> get message => $_getN(2);
  @$pb.TagNumber(3)
  set message($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// AuthorityInfo represents authority data for creation functions (matches swig-ts)
class AuthorityInfo extends $pb.GeneratedMessage {
  factory AuthorityInfo({
    $core.List<$core.int>? data,
    AuthorityType? type,
  }) {
    final result = create();
    if (data != null) result.data = data;
    if (type != null) result.type = type;
    return result;
  }

  AuthorityInfo._();

  factory AuthorityInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AuthorityInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthorityInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..e<AuthorityType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: AuthorityType.AUTHORITY_TYPE_UNSPECIFIED,
        valueOf: AuthorityType.valueOf,
        enumValues: AuthorityType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorityInfo clone() => AuthorityInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuthorityInfo copyWith(void Function(AuthorityInfo) updates) =>
      super.copyWith((message) => updates(message as AuthorityInfo))
          as AuthorityInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthorityInfo create() => AuthorityInfo._();
  @$core.override
  AuthorityInfo createEmptyInstance() => create();
  static $pb.PbList<AuthorityInfo> createRepeated() =>
      $pb.PbList<AuthorityInfo>();
  @$core.pragma('dart2js:noInline')
  static AuthorityInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthorityInfo>(create);
  static AuthorityInfo? _defaultInstance;

  /// base64 in JSON
  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => $_clearField(1);

  /// enum
  @$pb.TagNumber(2)
  AuthorityType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(AuthorityType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);
}

/// Permission action definition
class PermissionAction extends $pb.GeneratedMessage {
  factory PermissionAction({
    $core.int? permissionType,
    $core.List<$core.int>? permissionData,
  }) {
    final result = create();
    if (permissionType != null) result.permissionType = permissionType;
    if (permissionData != null) result.permissionData = permissionData;
    return result;
  }

  PermissionAction._();

  factory PermissionAction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PermissionAction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PermissionAction',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'permissionType', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'permissionData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PermissionAction clone() => PermissionAction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PermissionAction copyWith(void Function(PermissionAction) updates) =>
      super.copyWith((message) => updates(message as PermissionAction))
          as PermissionAction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PermissionAction create() => PermissionAction._();
  @$core.override
  PermissionAction createEmptyInstance() => create();
  static $pb.PbList<PermissionAction> createRepeated() =>
      $pb.PbList<PermissionAction>();
  @$core.pragma('dart2js:noInline')
  static PermissionAction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PermissionAction>(create);
  static PermissionAction? _defaultInstance;

  /// Permission type (1=SolLimit, 7=All, 8=ManageAuthority, etc.)
  @$pb.TagNumber(1)
  $core.int get permissionType => $_getIZ(0);
  @$pb.TagNumber(1)
  set permissionType($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPermissionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearPermissionType() => $_clearField(1);

  /// Permission-specific data (e.g., lamport amount for SolLimit)
  @$pb.TagNumber(2)
  $core.List<$core.int> get permissionData => $_getN(1);
  @$pb.TagNumber(2)
  set permissionData($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPermissionData() => $_has(1);
  @$pb.TagNumber(2)
  void clearPermissionData() => $_clearField(2);
}

/// Request to prepare an AddAuthority operation
class PrepareAddAuthorityRequest extends $pb.GeneratedMessage {
  factory PrepareAddAuthorityRequest({
    $core.String? swigWalletAddress,
    $core.int? signingRoleId,
    AuthorityInfo? newAuthority,
    $core.Iterable<PermissionAction>? permissionActions,
  }) {
    final result = create();
    if (swigWalletAddress != null) result.swigWalletAddress = swigWalletAddress;
    if (signingRoleId != null) result.signingRoleId = signingRoleId;
    if (newAuthority != null) result.newAuthority = newAuthority;
    if (permissionActions != null)
      result.permissionActions.addAll(permissionActions);
    return result;
  }

  PrepareAddAuthorityRequest._();

  factory PrepareAddAuthorityRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PrepareAddAuthorityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PrepareAddAuthorityRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'swigWalletAddress')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'signingRoleId', $pb.PbFieldType.OU3)
    ..aOM<AuthorityInfo>(3, _omitFieldNames ? '' : 'newAuthority',
        subBuilder: AuthorityInfo.create)
    ..pc<PermissionAction>(
        4, _omitFieldNames ? '' : 'permissionActions', $pb.PbFieldType.PM,
        subBuilder: PermissionAction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrepareAddAuthorityRequest clone() =>
      PrepareAddAuthorityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrepareAddAuthorityRequest copyWith(
          void Function(PrepareAddAuthorityRequest) updates) =>
      super.copyWith(
              (message) => updates(message as PrepareAddAuthorityRequest))
          as PrepareAddAuthorityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PrepareAddAuthorityRequest create() => PrepareAddAuthorityRequest._();
  @$core.override
  PrepareAddAuthorityRequest createEmptyInstance() => create();
  static $pb.PbList<PrepareAddAuthorityRequest> createRepeated() =>
      $pb.PbList<PrepareAddAuthorityRequest>();
  @$core.pragma('dart2js:noInline')
  static PrepareAddAuthorityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PrepareAddAuthorityRequest>(create);
  static PrepareAddAuthorityRequest? _defaultInstance;

  /// SWIG wallet address
  @$pb.TagNumber(1)
  $core.String get swigWalletAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set swigWalletAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSwigWalletAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearSwigWalletAddress() => $_clearField(1);

  /// The role ID of the authority that will sign this transaction
  @$pb.TagNumber(2)
  $core.int get signingRoleId => $_getIZ(1);
  @$pb.TagNumber(2)
  set signingRoleId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSigningRoleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSigningRoleId() => $_clearField(2);

  /// The new authority being added
  @$pb.TagNumber(3)
  AuthorityInfo get newAuthority => $_getN(2);
  @$pb.TagNumber(3)
  set newAuthority(AuthorityInfo value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNewAuthority() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewAuthority() => $_clearField(3);
  @$pb.TagNumber(3)
  AuthorityInfo ensureNewAuthority() => $_ensure(2);

  /// Permission actions for the new authority
  @$pb.TagNumber(4)
  $pb.PbList<PermissionAction> get permissionActions => $_getList(3);
}

/// Response with prepared AddAuthority operation details
class PrepareAddAuthorityResponse extends $pb.GeneratedMessage {
  factory PrepareAddAuthorityResponse({
    $core.List<$core.int>? unsignedTransaction,
    $core.int? expectedRoleId,
    $core.String? authorityType,
    $fixnum.Int64? estimatedFee,
    $fixnum.Int64? slot,
    $core.int? expectedCounter,
    $core.List<$core.int>? messageHash,
  }) {
    final result = create();
    if (unsignedTransaction != null)
      result.unsignedTransaction = unsignedTransaction;
    if (expectedRoleId != null) result.expectedRoleId = expectedRoleId;
    if (authorityType != null) result.authorityType = authorityType;
    if (estimatedFee != null) result.estimatedFee = estimatedFee;
    if (slot != null) result.slot = slot;
    if (expectedCounter != null) result.expectedCounter = expectedCounter;
    if (messageHash != null) result.messageHash = messageHash;
    return result;
  }

  PrepareAddAuthorityResponse._();

  factory PrepareAddAuthorityResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PrepareAddAuthorityResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PrepareAddAuthorityResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'unsignedTransaction', $pb.PbFieldType.OY)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'expectedRoleId', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'authorityType')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'estimatedFee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'expectedCounter', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'messageHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrepareAddAuthorityResponse clone() =>
      PrepareAddAuthorityResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrepareAddAuthorityResponse copyWith(
          void Function(PrepareAddAuthorityResponse) updates) =>
      super.copyWith(
              (message) => updates(message as PrepareAddAuthorityResponse))
          as PrepareAddAuthorityResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PrepareAddAuthorityResponse create() =>
      PrepareAddAuthorityResponse._();
  @$core.override
  PrepareAddAuthorityResponse createEmptyInstance() => create();
  static $pb.PbList<PrepareAddAuthorityResponse> createRepeated() =>
      $pb.PbList<PrepareAddAuthorityResponse>();
  @$core.pragma('dart2js:noInline')
  static PrepareAddAuthorityResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PrepareAddAuthorityResponse>(create);
  static PrepareAddAuthorityResponse? _defaultInstance;

  /// Unsigned transaction (base64 encoded)
  @$pb.TagNumber(1)
  $core.List<$core.int> get unsignedTransaction => $_getN(0);
  @$pb.TagNumber(1)
  set unsignedTransaction($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUnsignedTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearUnsignedTransaction() => $_clearField(1);

  /// Expected role ID that will be assigned
  @$pb.TagNumber(2)
  $core.int get expectedRoleId => $_getIZ(1);
  @$pb.TagNumber(2)
  set expectedRoleId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExpectedRoleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpectedRoleId() => $_clearField(2);

  /// Authority type for client-side signing
  @$pb.TagNumber(3)
  $core.String get authorityType => $_getSZ(2);
  @$pb.TagNumber(3)
  set authorityType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthorityType() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorityType() => $_clearField(3);

  /// Estimated transaction fee
  @$pb.TagNumber(4)
  $fixnum.Int64 get estimatedFee => $_getI64(3);
  @$pb.TagNumber(4)
  set estimatedFee($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEstimatedFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearEstimatedFee() => $_clearField(4);

  /// Slot used for signing (required for Secp256k1/Secp256r1)
  @$pb.TagNumber(5)
  $fixnum.Int64 get slot => $_getI64(4);
  @$pb.TagNumber(5)
  set slot($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSlot() => $_has(4);
  @$pb.TagNumber(5)
  void clearSlot() => $_clearField(5);

  /// Expected counter for SUBMIT consistency (Secp256k1/Secp256r1 only)
  @$pb.TagNumber(6)
  $core.int get expectedCounter => $_getIZ(5);
  @$pb.TagNumber(6)
  set expectedCounter($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasExpectedCounter() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpectedCounter() => $_clearField(6);

  /// Message hash for R1/WebAuthn signing (Secp256r1 only)
  @$pb.TagNumber(7)
  $core.List<$core.int> get messageHash => $_getN(6);
  @$pb.TagNumber(7)
  set messageHash($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMessageHash() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessageHash() => $_clearField(7);
}

/// Request to submit an AddAuthority operation with SigningResult
class SubmitAddAuthorityRequest extends $pb.GeneratedMessage {
  factory SubmitAddAuthorityRequest({
    SigningResult? signingResult,
    $core.String? swigWalletAddress,
    $core.int? signingRoleId,
    AuthorityInfo? newAuthority,
    $core.Iterable<PermissionAction>? permissionActions,
    $fixnum.Int64? slot,
    $core.int? expectedCounter,
    $core.List<$core.int>? authenticatorData,
    $core.String? clientDataJson,
  }) {
    final result = create();
    if (signingResult != null) result.signingResult = signingResult;
    if (swigWalletAddress != null) result.swigWalletAddress = swigWalletAddress;
    if (signingRoleId != null) result.signingRoleId = signingRoleId;
    if (newAuthority != null) result.newAuthority = newAuthority;
    if (permissionActions != null)
      result.permissionActions.addAll(permissionActions);
    if (slot != null) result.slot = slot;
    if (expectedCounter != null) result.expectedCounter = expectedCounter;
    if (authenticatorData != null) result.authenticatorData = authenticatorData;
    if (clientDataJson != null) result.clientDataJson = clientDataJson;
    return result;
  }

  SubmitAddAuthorityRequest._();

  factory SubmitAddAuthorityRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitAddAuthorityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitAddAuthorityRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOM<SigningResult>(1, _omitFieldNames ? '' : 'signingResult',
        subBuilder: SigningResult.create)
    ..aOS(2, _omitFieldNames ? '' : 'swigWalletAddress')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'signingRoleId', $pb.PbFieldType.OU3)
    ..aOM<AuthorityInfo>(4, _omitFieldNames ? '' : 'newAuthority',
        subBuilder: AuthorityInfo.create)
    ..pc<PermissionAction>(
        5, _omitFieldNames ? '' : 'permissionActions', $pb.PbFieldType.PM,
        subBuilder: PermissionAction.create)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'expectedCounter', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        8, _omitFieldNames ? '' : 'authenticatorData', $pb.PbFieldType.OY)
    ..aOS(9, _omitFieldNames ? '' : 'clientDataJson')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitAddAuthorityRequest clone() =>
      SubmitAddAuthorityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitAddAuthorityRequest copyWith(
          void Function(SubmitAddAuthorityRequest) updates) =>
      super.copyWith((message) => updates(message as SubmitAddAuthorityRequest))
          as SubmitAddAuthorityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitAddAuthorityRequest create() => SubmitAddAuthorityRequest._();
  @$core.override
  SubmitAddAuthorityRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitAddAuthorityRequest> createRepeated() =>
      $pb.PbList<SubmitAddAuthorityRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitAddAuthorityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitAddAuthorityRequest>(create);
  static SubmitAddAuthorityRequest? _defaultInstance;

  /// Authority signature result from swig-ts
  @$pb.TagNumber(1)
  SigningResult get signingResult => $_getN(0);
  @$pb.TagNumber(1)
  set signingResult(SigningResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSigningResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearSigningResult() => $_clearField(1);
  @$pb.TagNumber(1)
  SigningResult ensureSigningResult() => $_ensure(0);

  /// Original request parameters for reconstruction
  @$pb.TagNumber(2)
  $core.String get swigWalletAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set swigWalletAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSwigWalletAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwigWalletAddress() => $_clearField(2);

  /// The role ID of the authority that signed this transaction
  @$pb.TagNumber(3)
  $core.int get signingRoleId => $_getIZ(2);
  @$pb.TagNumber(3)
  set signingRoleId($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSigningRoleId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSigningRoleId() => $_clearField(3);

  @$pb.TagNumber(4)
  AuthorityInfo get newAuthority => $_getN(3);
  @$pb.TagNumber(4)
  set newAuthority(AuthorityInfo value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasNewAuthority() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewAuthority() => $_clearField(4);
  @$pb.TagNumber(4)
  AuthorityInfo ensureNewAuthority() => $_ensure(3);

  @$pb.TagNumber(5)
  $pb.PbList<PermissionAction> get permissionActions => $_getList(4);

  /// Slot used for signing (required for Secp256k1/Secp256r1)
  @$pb.TagNumber(6)
  $fixnum.Int64 get slot => $_getI64(5);
  @$pb.TagNumber(6)
  set slot($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSlot() => $_has(5);
  @$pb.TagNumber(6)
  void clearSlot() => $_clearField(6);

  /// Expected counter from PREPARE response (required for signature consistency)
  @$pb.TagNumber(7)
  $core.int get expectedCounter => $_getIZ(6);
  @$pb.TagNumber(7)
  set expectedCounter($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasExpectedCounter() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpectedCounter() => $_clearField(7);

  /// Optional WebAuthn fields for passkey signing (Secp256r1 only)
  @$pb.TagNumber(8)
  $core.List<$core.int> get authenticatorData => $_getN(7);
  @$pb.TagNumber(8)
  set authenticatorData($core.List<$core.int> value) => $_setBytes(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAuthenticatorData() => $_has(7);
  @$pb.TagNumber(8)
  void clearAuthenticatorData() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get clientDataJson => $_getSZ(8);
  @$pb.TagNumber(9)
  set clientDataJson($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasClientDataJson() => $_has(8);
  @$pb.TagNumber(9)
  void clearClientDataJson() => $_clearField(9);
}

/// Response with submitted AddAuthority operation details
class SubmitAddAuthorityResponse extends $pb.GeneratedMessage {
  factory SubmitAddAuthorityResponse({
    $core.String? transactionSignature,
    $core.int? roleId,
    $core.String? feesPaidBy,
    $fixnum.Int64? actualFee,
  }) {
    final result = create();
    if (transactionSignature != null)
      result.transactionSignature = transactionSignature;
    if (roleId != null) result.roleId = roleId;
    if (feesPaidBy != null) result.feesPaidBy = feesPaidBy;
    if (actualFee != null) result.actualFee = actualFee;
    return result;
  }

  SubmitAddAuthorityResponse._();

  factory SubmitAddAuthorityResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitAddAuthorityResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitAddAuthorityResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionSignature')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'roleId', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'feesPaidBy')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'actualFee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitAddAuthorityResponse clone() =>
      SubmitAddAuthorityResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitAddAuthorityResponse copyWith(
          void Function(SubmitAddAuthorityResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitAddAuthorityResponse))
          as SubmitAddAuthorityResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitAddAuthorityResponse create() => SubmitAddAuthorityResponse._();
  @$core.override
  SubmitAddAuthorityResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitAddAuthorityResponse> createRepeated() =>
      $pb.PbList<SubmitAddAuthorityResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitAddAuthorityResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitAddAuthorityResponse>(create);
  static SubmitAddAuthorityResponse? _defaultInstance;

  /// Final transaction signature
  @$pb.TagNumber(1)
  $core.String get transactionSignature => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionSignature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionSignature() => $_clearField(1);

  /// Confirmed authority role ID
  @$pb.TagNumber(2)
  $core.int get roleId => $_getIZ(1);
  @$pb.TagNumber(2)
  set roleId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRoleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoleId() => $_clearField(2);

  /// Account that paid fees (platform)
  @$pb.TagNumber(3)
  $core.String get feesPaidBy => $_getSZ(2);
  @$pb.TagNumber(3)
  set feesPaidBy($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFeesPaidBy() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeesPaidBy() => $_clearField(3);

  /// Actual fee paid
  @$pb.TagNumber(4)
  $fixnum.Int64 get actualFee => $_getI64(3);
  @$pb.TagNumber(4)
  set actualFee($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasActualFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearActualFee() => $_clearField(4);
}

/// Request to get authorities for a SWIG wallet
class GetWalletAuthoritiesRequest extends $pb.GeneratedMessage {
  factory GetWalletAuthoritiesRequest({
    $core.String? swigWalletAddress,
  }) {
    final result = create();
    if (swigWalletAddress != null) result.swigWalletAddress = swigWalletAddress;
    return result;
  }

  GetWalletAuthoritiesRequest._();

  factory GetWalletAuthoritiesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWalletAuthoritiesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWalletAuthoritiesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'swigWalletAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletAuthoritiesRequest clone() =>
      GetWalletAuthoritiesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletAuthoritiesRequest copyWith(
          void Function(GetWalletAuthoritiesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetWalletAuthoritiesRequest))
          as GetWalletAuthoritiesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletAuthoritiesRequest create() =>
      GetWalletAuthoritiesRequest._();
  @$core.override
  GetWalletAuthoritiesRequest createEmptyInstance() => create();
  static $pb.PbList<GetWalletAuthoritiesRequest> createRepeated() =>
      $pb.PbList<GetWalletAuthoritiesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWalletAuthoritiesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWalletAuthoritiesRequest>(create);
  static GetWalletAuthoritiesRequest? _defaultInstance;

  /// SWIG wallet address
  @$pb.TagNumber(1)
  $core.String get swigWalletAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set swigWalletAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSwigWalletAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearSwigWalletAddress() => $_clearField(1);
}

/// Response with authorities list
class GetWalletAuthoritiesResponse extends $pb.GeneratedMessage {
  factory GetWalletAuthoritiesResponse({
    $core.Iterable<SWIGAuthority>? authorities,
    SWIGWalletInfo? walletInfo,
  }) {
    final result = create();
    if (authorities != null) result.authorities.addAll(authorities);
    if (walletInfo != null) result.walletInfo = walletInfo;
    return result;
  }

  GetWalletAuthoritiesResponse._();

  factory GetWalletAuthoritiesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWalletAuthoritiesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWalletAuthoritiesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..pc<SWIGAuthority>(
        1, _omitFieldNames ? '' : 'authorities', $pb.PbFieldType.PM,
        subBuilder: SWIGAuthority.create)
    ..aOM<SWIGWalletInfo>(2, _omitFieldNames ? '' : 'walletInfo',
        subBuilder: SWIGWalletInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletAuthoritiesResponse clone() =>
      GetWalletAuthoritiesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletAuthoritiesResponse copyWith(
          void Function(GetWalletAuthoritiesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetWalletAuthoritiesResponse))
          as GetWalletAuthoritiesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletAuthoritiesResponse create() =>
      GetWalletAuthoritiesResponse._();
  @$core.override
  GetWalletAuthoritiesResponse createEmptyInstance() => create();
  static $pb.PbList<GetWalletAuthoritiesResponse> createRepeated() =>
      $pb.PbList<GetWalletAuthoritiesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWalletAuthoritiesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWalletAuthoritiesResponse>(create);
  static GetWalletAuthoritiesResponse? _defaultInstance;

  /// List of authorities/roles in the SWIG wallet
  @$pb.TagNumber(1)
  $pb.PbList<SWIGAuthority> get authorities => $_getList(0);

  /// SWIG wallet metadata
  @$pb.TagNumber(2)
  SWIGWalletInfo get walletInfo => $_getN(1);
  @$pb.TagNumber(2)
  set walletInfo(SWIGWalletInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasWalletInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  SWIGWalletInfo ensureWalletInfo() => $_ensure(1);
}

/// Authority/Role information
class SWIGAuthority extends $pb.GeneratedMessage {
  factory SWIGAuthority({
    $core.int? roleId,
    AuthorityType? authorityType,
    $core.List<$core.int>? authorityPublicKey,
    $core.Iterable<PermissionAction>? permissions,
  }) {
    final result = create();
    if (roleId != null) result.roleId = roleId;
    if (authorityType != null) result.authorityType = authorityType;
    if (authorityPublicKey != null)
      result.authorityPublicKey = authorityPublicKey;
    if (permissions != null) result.permissions.addAll(permissions);
    return result;
  }

  SWIGAuthority._();

  factory SWIGAuthority.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SWIGAuthority.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SWIGAuthority',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'roleId', $pb.PbFieldType.OU3)
    ..e<AuthorityType>(
        2, _omitFieldNames ? '' : 'authorityType', $pb.PbFieldType.OE,
        defaultOrMaker: AuthorityType.AUTHORITY_TYPE_UNSPECIFIED,
        valueOf: AuthorityType.valueOf,
        enumValues: AuthorityType.values)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'authorityPublicKey', $pb.PbFieldType.OY)
    ..pc<PermissionAction>(
        4, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.PM,
        subBuilder: PermissionAction.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SWIGAuthority clone() => SWIGAuthority()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SWIGAuthority copyWith(void Function(SWIGAuthority) updates) =>
      super.copyWith((message) => updates(message as SWIGAuthority))
          as SWIGAuthority;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SWIGAuthority create() => SWIGAuthority._();
  @$core.override
  SWIGAuthority createEmptyInstance() => create();
  static $pb.PbList<SWIGAuthority> createRepeated() =>
      $pb.PbList<SWIGAuthority>();
  @$core.pragma('dart2js:noInline')
  static SWIGAuthority getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SWIGAuthority>(create);
  static SWIGAuthority? _defaultInstance;

  /// Role ID
  @$pb.TagNumber(1)
  $core.int get roleId => $_getIZ(0);
  @$pb.TagNumber(1)
  set roleId($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRoleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoleId() => $_clearField(1);

  /// Authority type
  @$pb.TagNumber(2)
  AuthorityType get authorityType => $_getN(1);
  @$pb.TagNumber(2)
  set authorityType(AuthorityType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthorityType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthorityType() => $_clearField(2);

  /// Authority public key (format varies by type)
  @$pb.TagNumber(3)
  $core.List<$core.int> get authorityPublicKey => $_getN(2);
  @$pb.TagNumber(3)
  set authorityPublicKey($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAuthorityPublicKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorityPublicKey() => $_clearField(3);

  /// Permission actions granted to this authority
  @$pb.TagNumber(4)
  $pb.PbList<PermissionAction> get permissions => $_getList(3);
}

/// SWIG wallet information
class SWIGWalletInfo extends $pb.GeneratedMessage {
  factory SWIGWalletInfo({
    $core.List<$core.int>? walletId,
    $core.int? totalRoles,
    $core.int? roleCounter,
    $fixnum.Int64? reservedLamports,
  }) {
    final result = create();
    if (walletId != null) result.walletId = walletId;
    if (totalRoles != null) result.totalRoles = totalRoles;
    if (roleCounter != null) result.roleCounter = roleCounter;
    if (reservedLamports != null) result.reservedLamports = reservedLamports;
    return result;
  }

  SWIGWalletInfo._();

  factory SWIGWalletInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SWIGWalletInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SWIGWalletInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'walletId', $pb.PbFieldType.OY)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalRoles', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'roleCounter', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'reservedLamports', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SWIGWalletInfo clone() => SWIGWalletInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SWIGWalletInfo copyWith(void Function(SWIGWalletInfo) updates) =>
      super.copyWith((message) => updates(message as SWIGWalletInfo))
          as SWIGWalletInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SWIGWalletInfo create() => SWIGWalletInfo._();
  @$core.override
  SWIGWalletInfo createEmptyInstance() => create();
  static $pb.PbList<SWIGWalletInfo> createRepeated() =>
      $pb.PbList<SWIGWalletInfo>();
  @$core.pragma('dart2js:noInline')
  static SWIGWalletInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SWIGWalletInfo>(create);
  static SWIGWalletInfo? _defaultInstance;

  /// SWIG wallet ID (32 bytes)
  @$pb.TagNumber(1)
  $core.List<$core.int> get walletId => $_getN(0);
  @$pb.TagNumber(1)
  set walletId($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => $_clearField(1);

  /// Total number of roles/authorities
  @$pb.TagNumber(2)
  $core.int get totalRoles => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalRoles($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalRoles() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalRoles() => $_clearField(2);

  /// Current role counter (for generating new role IDs)
  @$pb.TagNumber(3)
  $core.int get roleCounter => $_getIZ(2);
  @$pb.TagNumber(3)
  set roleCounter($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRoleCounter() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoleCounter() => $_clearField(3);

  /// Reserved lamports for rent
  @$pb.TagNumber(4)
  $fixnum.Int64 get reservedLamports => $_getI64(3);
  @$pb.TagNumber(4)
  set reservedLamports($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReservedLamports() => $_has(3);
  @$pb.TagNumber(4)
  void clearReservedLamports() => $_clearField(4);
}

/// Request to prepare a SWIG SignV1 transaction
class PrepareSignV1Request extends $pb.GeneratedMessage {
  factory PrepareSignV1Request({
    $core.String? swigWalletAddress,
    $core.int? signingRoleId,
    $core.Iterable<$core.List<$core.int>>? wrappedInstructions,
  }) {
    final result = create();
    if (swigWalletAddress != null) result.swigWalletAddress = swigWalletAddress;
    if (signingRoleId != null) result.signingRoleId = signingRoleId;
    if (wrappedInstructions != null)
      result.wrappedInstructions.addAll(wrappedInstructions);
    return result;
  }

  PrepareSignV1Request._();

  factory PrepareSignV1Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PrepareSignV1Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PrepareSignV1Request',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'swigWalletAddress')
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'signingRoleId', $pb.PbFieldType.OU3)
    ..p<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'wrappedInstructions', $pb.PbFieldType.PY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrepareSignV1Request clone() =>
      PrepareSignV1Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrepareSignV1Request copyWith(void Function(PrepareSignV1Request) updates) =>
      super.copyWith((message) => updates(message as PrepareSignV1Request))
          as PrepareSignV1Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PrepareSignV1Request create() => PrepareSignV1Request._();
  @$core.override
  PrepareSignV1Request createEmptyInstance() => create();
  static $pb.PbList<PrepareSignV1Request> createRepeated() =>
      $pb.PbList<PrepareSignV1Request>();
  @$core.pragma('dart2js:noInline')
  static PrepareSignV1Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PrepareSignV1Request>(create);
  static PrepareSignV1Request? _defaultInstance;

  /// SWIG wallet address
  @$pb.TagNumber(1)
  $core.String get swigWalletAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set swigWalletAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSwigWalletAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearSwigWalletAddress() => $_clearField(1);

  /// Role ID of the authority that will sign
  @$pb.TagNumber(2)
  $core.int get signingRoleId => $_getIZ(1);
  @$pb.TagNumber(2)
  set signingRoleId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSigningRoleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSigningRoleId() => $_clearField(2);

  /// Instructions to be wrapped (serialized GenericInstructions)
  @$pb.TagNumber(3)
  $pb.PbList<$core.List<$core.int>> get wrappedInstructions => $_getList(2);
}

/// Response with prepared SignV1 transaction
class PrepareSignV1Response extends $pb.GeneratedMessage {
  factory PrepareSignV1Response({
    $core.List<$core.int>? unsignedTransaction,
    $core.String? authorityType,
    $fixnum.Int64? estimatedFee,
    $fixnum.Int64? slot,
    $core.int? expectedCounter,
    $core.List<$core.int>? messageHash,
  }) {
    final result = create();
    if (unsignedTransaction != null)
      result.unsignedTransaction = unsignedTransaction;
    if (authorityType != null) result.authorityType = authorityType;
    if (estimatedFee != null) result.estimatedFee = estimatedFee;
    if (slot != null) result.slot = slot;
    if (expectedCounter != null) result.expectedCounter = expectedCounter;
    if (messageHash != null) result.messageHash = messageHash;
    return result;
  }

  PrepareSignV1Response._();

  factory PrepareSignV1Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PrepareSignV1Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PrepareSignV1Response',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'unsignedTransaction', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'authorityType')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'estimatedFee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'expectedCounter', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        6, _omitFieldNames ? '' : 'messageHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrepareSignV1Response clone() =>
      PrepareSignV1Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrepareSignV1Response copyWith(
          void Function(PrepareSignV1Response) updates) =>
      super.copyWith((message) => updates(message as PrepareSignV1Response))
          as PrepareSignV1Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PrepareSignV1Response create() => PrepareSignV1Response._();
  @$core.override
  PrepareSignV1Response createEmptyInstance() => create();
  static $pb.PbList<PrepareSignV1Response> createRepeated() =>
      $pb.PbList<PrepareSignV1Response>();
  @$core.pragma('dart2js:noInline')
  static PrepareSignV1Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PrepareSignV1Response>(create);
  static PrepareSignV1Response? _defaultInstance;

  /// Unsigned transaction (base64 encoded)
  @$pb.TagNumber(1)
  $core.List<$core.int> get unsignedTransaction => $_getN(0);
  @$pb.TagNumber(1)
  set unsignedTransaction($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUnsignedTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearUnsignedTransaction() => $_clearField(1);

  /// Authority type for client-side signing
  @$pb.TagNumber(2)
  $core.String get authorityType => $_getSZ(1);
  @$pb.TagNumber(2)
  set authorityType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthorityType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthorityType() => $_clearField(2);

  /// Estimated transaction fee
  @$pb.TagNumber(3)
  $fixnum.Int64 get estimatedFee => $_getI64(2);
  @$pb.TagNumber(3)
  set estimatedFee($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEstimatedFee() => $_has(2);
  @$pb.TagNumber(3)
  void clearEstimatedFee() => $_clearField(3);

  /// Slot used for signing (required for Secp256k1/Secp256r1)
  @$pb.TagNumber(4)
  $fixnum.Int64 get slot => $_getI64(3);
  @$pb.TagNumber(4)
  set slot($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSlot() => $_has(3);
  @$pb.TagNumber(4)
  void clearSlot() => $_clearField(4);

  /// Expected counter for SUBMIT consistency (Secp256k1/Secp256r1 only)
  @$pb.TagNumber(5)
  $core.int get expectedCounter => $_getIZ(4);
  @$pb.TagNumber(5)
  set expectedCounter($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpectedCounter() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpectedCounter() => $_clearField(5);

  /// Message hash for R1/WebAuthn signing (Secp256r1 only)
  @$pb.TagNumber(6)
  $core.List<$core.int> get messageHash => $_getN(5);
  @$pb.TagNumber(6)
  set messageHash($core.List<$core.int> value) => $_setBytes(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessageHash() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessageHash() => $_clearField(6);
}

/// Request to submit a SignV1 transaction with authority signature
class SubmitSignV1Request extends $pb.GeneratedMessage {
  factory SubmitSignV1Request({
    SigningResult? signingResult,
    $core.String? swigWalletAddress,
    $core.int? signingRoleId,
    $core.Iterable<$core.List<$core.int>>? wrappedInstructions,
    $fixnum.Int64? slot,
    $core.int? expectedCounter,
    $core.List<$core.int>? unsignedTransaction,
    $core.List<$core.int>? authenticatorData,
    $core.String? clientDataJson,
  }) {
    final result = create();
    if (signingResult != null) result.signingResult = signingResult;
    if (swigWalletAddress != null) result.swigWalletAddress = swigWalletAddress;
    if (signingRoleId != null) result.signingRoleId = signingRoleId;
    if (wrappedInstructions != null)
      result.wrappedInstructions.addAll(wrappedInstructions);
    if (slot != null) result.slot = slot;
    if (expectedCounter != null) result.expectedCounter = expectedCounter;
    if (unsignedTransaction != null)
      result.unsignedTransaction = unsignedTransaction;
    if (authenticatorData != null) result.authenticatorData = authenticatorData;
    if (clientDataJson != null) result.clientDataJson = clientDataJson;
    return result;
  }

  SubmitSignV1Request._();

  factory SubmitSignV1Request.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitSignV1Request.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitSignV1Request',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOM<SigningResult>(1, _omitFieldNames ? '' : 'signingResult',
        subBuilder: SigningResult.create)
    ..aOS(2, _omitFieldNames ? '' : 'swigWalletAddress')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'signingRoleId', $pb.PbFieldType.OU3)
    ..p<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'wrappedInstructions', $pb.PbFieldType.PY)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'expectedCounter', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'unsignedTransaction', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        8, _omitFieldNames ? '' : 'authenticatorData', $pb.PbFieldType.OY)
    ..aOS(9, _omitFieldNames ? '' : 'clientDataJson')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitSignV1Request clone() => SubmitSignV1Request()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitSignV1Request copyWith(void Function(SubmitSignV1Request) updates) =>
      super.copyWith((message) => updates(message as SubmitSignV1Request))
          as SubmitSignV1Request;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitSignV1Request create() => SubmitSignV1Request._();
  @$core.override
  SubmitSignV1Request createEmptyInstance() => create();
  static $pb.PbList<SubmitSignV1Request> createRepeated() =>
      $pb.PbList<SubmitSignV1Request>();
  @$core.pragma('dart2js:noInline')
  static SubmitSignV1Request getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitSignV1Request>(create);
  static SubmitSignV1Request? _defaultInstance;

  /// Authority signature result from swig-ts
  @$pb.TagNumber(1)
  SigningResult get signingResult => $_getN(0);
  @$pb.TagNumber(1)
  set signingResult(SigningResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSigningResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearSigningResult() => $_clearField(1);
  @$pb.TagNumber(1)
  SigningResult ensureSigningResult() => $_ensure(0);

  /// SWIG wallet address
  @$pb.TagNumber(2)
  $core.String get swigWalletAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set swigWalletAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSwigWalletAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearSwigWalletAddress() => $_clearField(2);

  /// Role ID of the authority that signed
  @$pb.TagNumber(3)
  $core.int get signingRoleId => $_getIZ(2);
  @$pb.TagNumber(3)
  set signingRoleId($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSigningRoleId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSigningRoleId() => $_clearField(3);

  /// Instructions that were wrapped (for reconstruction)
  @$pb.TagNumber(4)
  $pb.PbList<$core.List<$core.int>> get wrappedInstructions => $_getList(3);

  /// Slot used for signing (required for Secp256k1/Secp256r1)
  @$pb.TagNumber(5)
  $fixnum.Int64 get slot => $_getI64(4);
  @$pb.TagNumber(5)
  set slot($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSlot() => $_has(4);
  @$pb.TagNumber(5)
  void clearSlot() => $_clearField(5);

  /// Expected counter from PREPARE response (required for signature consistency)
  @$pb.TagNumber(6)
  $core.int get expectedCounter => $_getIZ(5);
  @$pb.TagNumber(6)
  set expectedCounter($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasExpectedCounter() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpectedCounter() => $_clearField(6);

  /// Original unsigned transaction from PREPARE (for exact reconstruction)
  @$pb.TagNumber(7)
  $core.List<$core.int> get unsignedTransaction => $_getN(6);
  @$pb.TagNumber(7)
  set unsignedTransaction($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUnsignedTransaction() => $_has(6);
  @$pb.TagNumber(7)
  void clearUnsignedTransaction() => $_clearField(7);

  /// Optional WebAuthn fields for passkey signing (Secp256r1 only)
  @$pb.TagNumber(8)
  $core.List<$core.int> get authenticatorData => $_getN(7);
  @$pb.TagNumber(8)
  set authenticatorData($core.List<$core.int> value) => $_setBytes(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAuthenticatorData() => $_has(7);
  @$pb.TagNumber(8)
  void clearAuthenticatorData() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get clientDataJson => $_getSZ(8);
  @$pb.TagNumber(9)
  set clientDataJson($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasClientDataJson() => $_has(8);
  @$pb.TagNumber(9)
  void clearClientDataJson() => $_clearField(9);
}

/// Response with submitted SignV1 transaction details
class SubmitSignV1Response extends $pb.GeneratedMessage {
  factory SubmitSignV1Response({
    $core.String? transactionSignature,
    $core.String? feesPaidBy,
    $fixnum.Int64? actualFee,
  }) {
    final result = create();
    if (transactionSignature != null)
      result.transactionSignature = transactionSignature;
    if (feesPaidBy != null) result.feesPaidBy = feesPaidBy;
    if (actualFee != null) result.actualFee = actualFee;
    return result;
  }

  SubmitSignV1Response._();

  factory SubmitSignV1Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitSignV1Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitSignV1Response',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionSignature')
    ..aOS(2, _omitFieldNames ? '' : 'feesPaidBy')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'actualFee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitSignV1Response clone() =>
      SubmitSignV1Response()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitSignV1Response copyWith(void Function(SubmitSignV1Response) updates) =>
      super.copyWith((message) => updates(message as SubmitSignV1Response))
          as SubmitSignV1Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitSignV1Response create() => SubmitSignV1Response._();
  @$core.override
  SubmitSignV1Response createEmptyInstance() => create();
  static $pb.PbList<SubmitSignV1Response> createRepeated() =>
      $pb.PbList<SubmitSignV1Response>();
  @$core.pragma('dart2js:noInline')
  static SubmitSignV1Response getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitSignV1Response>(create);
  static SubmitSignV1Response? _defaultInstance;

  /// Final transaction signature
  @$pb.TagNumber(1)
  $core.String get transactionSignature => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionSignature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionSignature() => $_clearField(1);

  /// Account that paid fees (platform)
  @$pb.TagNumber(2)
  $core.String get feesPaidBy => $_getSZ(1);
  @$pb.TagNumber(2)
  set feesPaidBy($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFeesPaidBy() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeesPaidBy() => $_clearField(2);

  /// Actual fee paid
  @$pb.TagNumber(3)
  $fixnum.Int64 get actualFee => $_getI64(2);
  @$pb.TagNumber(3)
  set actualFee($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasActualFee() => $_has(2);
  @$pb.TagNumber(3)
  void clearActualFee() => $_clearField(3);
}

/// Request to create an Associated Token Account (ATA)
class SubmitCreateATARequest extends $pb.GeneratedMessage {
  factory SubmitCreateATARequest({
    $core.String? mintAddress,
    $core.String? walletAddress,
  }) {
    final result = create();
    if (mintAddress != null) result.mintAddress = mintAddress;
    if (walletAddress != null) result.walletAddress = walletAddress;
    return result;
  }

  SubmitCreateATARequest._();

  factory SubmitCreateATARequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitCreateATARequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitCreateATARequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'mintAddress')
    ..aOS(2, _omitFieldNames ? '' : 'walletAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitCreateATARequest clone() =>
      SubmitCreateATARequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitCreateATARequest copyWith(
          void Function(SubmitCreateATARequest) updates) =>
      super.copyWith((message) => updates(message as SubmitCreateATARequest))
          as SubmitCreateATARequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitCreateATARequest create() => SubmitCreateATARequest._();
  @$core.override
  SubmitCreateATARequest createEmptyInstance() => create();
  static $pb.PbList<SubmitCreateATARequest> createRepeated() =>
      $pb.PbList<SubmitCreateATARequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitCreateATARequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitCreateATARequest>(create);
  static SubmitCreateATARequest? _defaultInstance;

  /// Token mint address
  @$pb.TagNumber(1)
  $core.String get mintAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set mintAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMintAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearMintAddress() => $_clearField(1);

  /// Wallet address that will own the ATA
  @$pb.TagNumber(2)
  $core.String get walletAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set walletAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWalletAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearWalletAddress() => $_clearField(2);
}

/// Response with ATA creation details
class SubmitCreateATAResponse extends $pb.GeneratedMessage {
  factory SubmitCreateATAResponse({
    $core.String? transactionSignature,
    $core.String? feesPaidBy,
    $fixnum.Int64? actualFee,
  }) {
    final result = create();
    if (transactionSignature != null)
      result.transactionSignature = transactionSignature;
    if (feesPaidBy != null) result.feesPaidBy = feesPaidBy;
    if (actualFee != null) result.actualFee = actualFee;
    return result;
  }

  SubmitCreateATAResponse._();

  factory SubmitCreateATAResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitCreateATAResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitCreateATAResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.swig.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionSignature')
    ..aOS(2, _omitFieldNames ? '' : 'feesPaidBy')
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'actualFee', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitCreateATAResponse clone() =>
      SubmitCreateATAResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitCreateATAResponse copyWith(
          void Function(SubmitCreateATAResponse) updates) =>
      super.copyWith((message) => updates(message as SubmitCreateATAResponse))
          as SubmitCreateATAResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitCreateATAResponse create() => SubmitCreateATAResponse._();
  @$core.override
  SubmitCreateATAResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitCreateATAResponse> createRepeated() =>
      $pb.PbList<SubmitCreateATAResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitCreateATAResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitCreateATAResponse>(create);
  static SubmitCreateATAResponse? _defaultInstance;

  /// Final transaction signature
  @$pb.TagNumber(1)
  $core.String get transactionSignature => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionSignature($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionSignature() => $_clearField(1);

  /// Account that paid fees (platform)
  @$pb.TagNumber(2)
  $core.String get feesPaidBy => $_getSZ(1);
  @$pb.TagNumber(2)
  set feesPaidBy($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFeesPaidBy() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeesPaidBy() => $_clearField(2);

  /// Actual fee paid
  @$pb.TagNumber(3)
  $fixnum.Int64 get actualFee => $_getI64(2);
  @$pb.TagNumber(3)
  set actualFee($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasActualFee() => $_has(2);
  @$pb.TagNumber(3)
  void clearActualFee() => $_clearField(3);
}

/// SWIGService manages SWIG smart wallet operations
class SWIGServiceApi {
  final $pb.RpcClient _client;

  SWIGServiceApi(this._client);

  /// Creates a SWIG wallet for a user
  $async.Future<CreateWalletResponse> createWallet(
          $pb.ClientContext? ctx, CreateWalletRequest request) =>
      _client.invoke<CreateWalletResponse>(
          ctx, 'SWIGService', 'CreateWallet', request, CreateWalletResponse());

  /// Creates a SWIG wallet with platform fee payment
  $async.Future<SubmitCreateWalletResponse> submitCreateWallet(
          $pb.ClientContext? ctx, SubmitCreateWalletRequest request) =>
      _client.invoke<SubmitCreateWalletResponse>(ctx, 'SWIGService',
          'SubmitCreateWallet', request, SubmitCreateWalletResponse());

  /// Prepares an AddAuthority operation (returns unsigned transaction)
  $async.Future<PrepareAddAuthorityResponse> prepareAddAuthority(
          $pb.ClientContext? ctx, PrepareAddAuthorityRequest request) =>
      _client.invoke<PrepareAddAuthorityResponse>(ctx, 'SWIGService',
          'PrepareAddAuthority', request, PrepareAddAuthorityResponse());

  /// Submits an AddAuthority operation with SigningResult
  $async.Future<SubmitAddAuthorityResponse> submitAddAuthority(
          $pb.ClientContext? ctx, SubmitAddAuthorityRequest request) =>
      _client.invoke<SubmitAddAuthorityResponse>(ctx, 'SWIGService',
          'SubmitAddAuthority', request, SubmitAddAuthorityResponse());

  /// Creates an Associated Token Account (ATA) with platform fee payment
  $async.Future<SubmitCreateATAResponse> submitCreateATA(
          $pb.ClientContext? ctx, SubmitCreateATARequest request) =>
      _client.invoke<SubmitCreateATAResponse>(ctx, 'SWIGService',
          'SubmitCreateATA', request, SubmitCreateATAResponse());

  /// Gets list of authorities and roles for a SWIG wallet
  $async.Future<GetWalletAuthoritiesResponse> getWalletAuthorities(
          $pb.ClientContext? ctx, GetWalletAuthoritiesRequest request) =>
      _client.invoke<GetWalletAuthoritiesResponse>(ctx, 'SWIGService',
          'GetWalletAuthorities', request, GetWalletAuthoritiesResponse());

  /// Prepares a SWIG SignV1 transaction (wrapping any instruction)
  $async.Future<PrepareSignV1Response> prepareSignV1(
          $pb.ClientContext? ctx, PrepareSignV1Request request) =>
      _client.invoke<PrepareSignV1Response>(ctx, 'SWIGService', 'PrepareSignV1',
          request, PrepareSignV1Response());

  /// Submits a SignV1 transaction with authority signature
  $async.Future<SubmitSignV1Response> submitSignV1(
          $pb.ClientContext? ctx, SubmitSignV1Request request) =>
      _client.invoke<SubmitSignV1Response>(
          ctx, 'SWIGService', 'SubmitSignV1', request, SubmitSignV1Response());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
