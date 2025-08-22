// This is a generated file - do not edit.
//
// Generated from espressocash/api/transactionlink/v1/service.proto.

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

/// Request to get an onboarding link
class GetOnboardingLinkRequest extends $pb.GeneratedMessage {
  factory GetOnboardingLinkRequest({
    $core.String? platform,
    $core.String? referralCode,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (platform != null) result.platform = platform;
    if (referralCode != null) result.referralCode = referralCode;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  GetOnboardingLinkRequest._();

  factory GetOnboardingLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOnboardingLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOnboardingLinkRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.transactionlink.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'platform')
    ..aOS(2, _omitFieldNames ? '' : 'referralCode')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'GetOnboardingLinkRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName:
            const $pb.PackageName('espressocash.api.transactionlink.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOnboardingLinkRequest clone() =>
      GetOnboardingLinkRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOnboardingLinkRequest copyWith(
          void Function(GetOnboardingLinkRequest) updates) =>
      super.copyWith((message) => updates(message as GetOnboardingLinkRequest))
          as GetOnboardingLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOnboardingLinkRequest create() => GetOnboardingLinkRequest._();
  @$core.override
  GetOnboardingLinkRequest createEmptyInstance() => create();
  static $pb.PbList<GetOnboardingLinkRequest> createRepeated() =>
      $pb.PbList<GetOnboardingLinkRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOnboardingLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOnboardingLinkRequest>(create);
  static GetOnboardingLinkRequest? _defaultInstance;

  /// Platform requesting the link (telegram, whatsapp, web)
  @$pb.TagNumber(1)
  $core.String get platform => $_getSZ(0);
  @$pb.TagNumber(1)
  set platform($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPlatform() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlatform() => $_clearField(1);

  /// Optional referral code
  @$pb.TagNumber(2)
  $core.String get referralCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set referralCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReferralCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearReferralCode() => $_clearField(2);

  /// Optional metadata for tracking
  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(2);
}

/// Response with onboarding link
class GetOnboardingLinkResponse extends $pb.GeneratedMessage {
  factory GetOnboardingLinkResponse({
    $core.String? onboardingUrl,
    $core.String? sessionId,
    $fixnum.Int64? expiresAt,
  }) {
    final result = create();
    if (onboardingUrl != null) result.onboardingUrl = onboardingUrl;
    if (sessionId != null) result.sessionId = sessionId;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  GetOnboardingLinkResponse._();

  factory GetOnboardingLinkResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOnboardingLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOnboardingLinkResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.transactionlink.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'onboardingUrl')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOnboardingLinkResponse clone() =>
      GetOnboardingLinkResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOnboardingLinkResponse copyWith(
          void Function(GetOnboardingLinkResponse) updates) =>
      super.copyWith((message) => updates(message as GetOnboardingLinkResponse))
          as GetOnboardingLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOnboardingLinkResponse create() => GetOnboardingLinkResponse._();
  @$core.override
  GetOnboardingLinkResponse createEmptyInstance() => create();
  static $pb.PbList<GetOnboardingLinkResponse> createRepeated() =>
      $pb.PbList<GetOnboardingLinkResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOnboardingLinkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOnboardingLinkResponse>(create);
  static GetOnboardingLinkResponse? _defaultInstance;

  /// Frontend URL for onboarding flow
  @$pb.TagNumber(1)
  $core.String get onboardingUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set onboardingUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOnboardingUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnboardingUrl() => $_clearField(1);

  /// Session ID for tracking
  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => $_clearField(2);

  /// Expiration timestamp (Unix seconds)
  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresAt => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresAt($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);
}

enum CreateTransactionLinkRequest_Params { payment, swap, notSet }

/// Request to create a transaction link
class CreateTransactionLinkRequest extends $pb.GeneratedMessage {
  factory CreateTransactionLinkRequest({
    $core.String? transactionType,
    $core.String? userWallet,
    $core.String? platform,
    $core.bool? useSwig,
    PaymentParams? payment,
    SwapParams? swap,
  }) {
    final result = create();
    if (transactionType != null) result.transactionType = transactionType;
    if (userWallet != null) result.userWallet = userWallet;
    if (platform != null) result.platform = platform;
    if (useSwig != null) result.useSwig = useSwig;
    if (payment != null) result.payment = payment;
    if (swap != null) result.swap = swap;
    return result;
  }

  CreateTransactionLinkRequest._();

  factory CreateTransactionLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTransactionLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, CreateTransactionLinkRequest_Params>
      _CreateTransactionLinkRequest_ParamsByTag = {
    5: CreateTransactionLinkRequest_Params.payment,
    6: CreateTransactionLinkRequest_Params.swap,
    0: CreateTransactionLinkRequest_Params.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTransactionLinkRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.transactionlink.v1'),
      createEmptyInstance: create)
    ..oo(0, [5, 6])
    ..aOS(1, _omitFieldNames ? '' : 'transactionType')
    ..aOS(2, _omitFieldNames ? '' : 'userWallet')
    ..aOS(3, _omitFieldNames ? '' : 'platform')
    ..aOB(4, _omitFieldNames ? '' : 'useSwig')
    ..aOM<PaymentParams>(5, _omitFieldNames ? '' : 'payment',
        subBuilder: PaymentParams.create)
    ..aOM<SwapParams>(6, _omitFieldNames ? '' : 'swap',
        subBuilder: SwapParams.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTransactionLinkRequest clone() =>
      CreateTransactionLinkRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTransactionLinkRequest copyWith(
          void Function(CreateTransactionLinkRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateTransactionLinkRequest))
          as CreateTransactionLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTransactionLinkRequest create() =>
      CreateTransactionLinkRequest._();
  @$core.override
  CreateTransactionLinkRequest createEmptyInstance() => create();
  static $pb.PbList<CreateTransactionLinkRequest> createRepeated() =>
      $pb.PbList<CreateTransactionLinkRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateTransactionLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTransactionLinkRequest>(create);
  static CreateTransactionLinkRequest? _defaultInstance;

  CreateTransactionLinkRequest_Params whichParams() =>
      _CreateTransactionLinkRequest_ParamsByTag[$_whichOneof(0)]!;
  void clearParams() => $_clearField($_whichOneof(0));

  /// Type of transaction (payment, swap, etc.)
  @$pb.TagNumber(1)
  $core.String get transactionType => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionType() => $_clearField(1);

  /// User's wallet address (or SWIG wallet)
  @$pb.TagNumber(2)
  $core.String get userWallet => $_getSZ(1);
  @$pb.TagNumber(2)
  set userWallet($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserWallet() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserWallet() => $_clearField(2);

  /// Platform requesting the link
  @$pb.TagNumber(3)
  $core.String get platform => $_getSZ(2);
  @$pb.TagNumber(3)
  set platform($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPlatform() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlatform() => $_clearField(3);

  /// Whether to use SWIG wrapper
  @$pb.TagNumber(4)
  $core.bool get useSwig => $_getBF(3);
  @$pb.TagNumber(4)
  set useSwig($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUseSwig() => $_has(3);
  @$pb.TagNumber(4)
  void clearUseSwig() => $_clearField(4);

  @$pb.TagNumber(5)
  PaymentParams get payment => $_getN(4);
  @$pb.TagNumber(5)
  set payment(PaymentParams value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPayment() => $_has(4);
  @$pb.TagNumber(5)
  void clearPayment() => $_clearField(5);
  @$pb.TagNumber(5)
  PaymentParams ensurePayment() => $_ensure(4);

  @$pb.TagNumber(6)
  SwapParams get swap => $_getN(5);
  @$pb.TagNumber(6)
  set swap(SwapParams value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSwap() => $_has(5);
  @$pb.TagNumber(6)
  void clearSwap() => $_clearField(6);
  @$pb.TagNumber(6)
  SwapParams ensureSwap() => $_ensure(5);
}

/// Payment parameters
class PaymentParams extends $pb.GeneratedMessage {
  factory PaymentParams({
    $core.String? recipient,
    $core.String? amount,
    $core.String? token,
    $core.String? memo,
  }) {
    final result = create();
    if (recipient != null) result.recipient = recipient;
    if (amount != null) result.amount = amount;
    if (token != null) result.token = token;
    if (memo != null) result.memo = memo;
    return result;
  }

  PaymentParams._();

  factory PaymentParams.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PaymentParams.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PaymentParams',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.transactionlink.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recipient')
    ..aOS(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'token')
    ..aOS(4, _omitFieldNames ? '' : 'memo')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentParams clone() => PaymentParams()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PaymentParams copyWith(void Function(PaymentParams) updates) =>
      super.copyWith((message) => updates(message as PaymentParams))
          as PaymentParams;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentParams create() => PaymentParams._();
  @$core.override
  PaymentParams createEmptyInstance() => create();
  static $pb.PbList<PaymentParams> createRepeated() =>
      $pb.PbList<PaymentParams>();
  @$core.pragma('dart2js:noInline')
  static PaymentParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PaymentParams>(create);
  static PaymentParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipient => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipient($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipient() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipient() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get amount => $_getSZ(1);
  @$pb.TagNumber(2)
  set amount($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get memo => $_getSZ(3);
  @$pb.TagNumber(4)
  set memo($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMemo() => $_has(3);
  @$pb.TagNumber(4)
  void clearMemo() => $_clearField(4);
}

/// Swap parameters
class SwapParams extends $pb.GeneratedMessage {
  factory SwapParams({
    $core.String? inputToken,
    $core.String? outputToken,
    $core.String? amount,
    $core.bool? exactInput,
    $core.String? slippageBps,
  }) {
    final result = create();
    if (inputToken != null) result.inputToken = inputToken;
    if (outputToken != null) result.outputToken = outputToken;
    if (amount != null) result.amount = amount;
    if (exactInput != null) result.exactInput = exactInput;
    if (slippageBps != null) result.slippageBps = slippageBps;
    return result;
  }

  SwapParams._();

  factory SwapParams.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SwapParams.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SwapParams',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.transactionlink.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'inputToken')
    ..aOS(2, _omitFieldNames ? '' : 'outputToken')
    ..aOS(3, _omitFieldNames ? '' : 'amount')
    ..aOB(4, _omitFieldNames ? '' : 'exactInput')
    ..aOS(5, _omitFieldNames ? '' : 'slippageBps')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SwapParams clone() => SwapParams()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SwapParams copyWith(void Function(SwapParams) updates) =>
      super.copyWith((message) => updates(message as SwapParams)) as SwapParams;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SwapParams create() => SwapParams._();
  @$core.override
  SwapParams createEmptyInstance() => create();
  static $pb.PbList<SwapParams> createRepeated() => $pb.PbList<SwapParams>();
  @$core.pragma('dart2js:noInline')
  static SwapParams getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SwapParams>(create);
  static SwapParams? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get inputToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set inputToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInputToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInputToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get outputToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set outputToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOutputToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutputToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get amount => $_getSZ(2);
  @$pb.TagNumber(3)
  set amount($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get exactInput => $_getBF(3);
  @$pb.TagNumber(4)
  set exactInput($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExactInput() => $_has(3);
  @$pb.TagNumber(4)
  void clearExactInput() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get slippageBps => $_getSZ(4);
  @$pb.TagNumber(5)
  set slippageBps($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSlippageBps() => $_has(4);
  @$pb.TagNumber(5)
  void clearSlippageBps() => $_clearField(5);
}

/// Response with transaction link
class CreateTransactionLinkResponse extends $pb.GeneratedMessage {
  factory CreateTransactionLinkResponse({
    $core.String? signingUrl,
    $core.String? trackingToken,
    $fixnum.Int64? expiresAt,
    $core.String? estimatedFees,
  }) {
    final result = create();
    if (signingUrl != null) result.signingUrl = signingUrl;
    if (trackingToken != null) result.trackingToken = trackingToken;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (estimatedFees != null) result.estimatedFees = estimatedFees;
    return result;
  }

  CreateTransactionLinkResponse._();

  factory CreateTransactionLinkResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTransactionLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTransactionLinkResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.transactionlink.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signingUrl')
    ..aOS(2, _omitFieldNames ? '' : 'trackingToken')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresAt')
    ..aOS(4, _omitFieldNames ? '' : 'estimatedFees')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTransactionLinkResponse clone() =>
      CreateTransactionLinkResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTransactionLinkResponse copyWith(
          void Function(CreateTransactionLinkResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateTransactionLinkResponse))
          as CreateTransactionLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTransactionLinkResponse create() =>
      CreateTransactionLinkResponse._();
  @$core.override
  CreateTransactionLinkResponse createEmptyInstance() => create();
  static $pb.PbList<CreateTransactionLinkResponse> createRepeated() =>
      $pb.PbList<CreateTransactionLinkResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateTransactionLinkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTransactionLinkResponse>(create);
  static CreateTransactionLinkResponse? _defaultInstance;

  /// Shortened signing URL
  @$pb.TagNumber(1)
  $core.String get signingUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set signingUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSigningUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearSigningUrl() => $_clearField(1);

  /// JWT token for status tracking
  @$pb.TagNumber(2)
  $core.String get trackingToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set trackingToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTrackingToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearTrackingToken() => $_clearField(2);

  /// Link expiration timestamp
  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresAt => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresAt($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);

  /// Estimated fees
  @$pb.TagNumber(4)
  $core.String get estimatedFees => $_getSZ(3);
  @$pb.TagNumber(4)
  set estimatedFees($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEstimatedFees() => $_has(3);
  @$pb.TagNumber(4)
  void clearEstimatedFees() => $_clearField(4);
}

/// Request to get transaction status
class GetTransactionStatusRequest extends $pb.GeneratedMessage {
  factory GetTransactionStatusRequest({
    $core.String? trackingToken,
  }) {
    final result = create();
    if (trackingToken != null) result.trackingToken = trackingToken;
    return result;
  }

  GetTransactionStatusRequest._();

  factory GetTransactionStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransactionStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransactionStatusRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.transactionlink.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'trackingToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusRequest clone() =>
      GetTransactionStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusRequest copyWith(
          void Function(GetTransactionStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTransactionStatusRequest))
          as GetTransactionStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusRequest create() =>
      GetTransactionStatusRequest._();
  @$core.override
  GetTransactionStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionStatusRequest> createRepeated() =>
      $pb.PbList<GetTransactionStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransactionStatusRequest>(create);
  static GetTransactionStatusRequest? _defaultInstance;

  /// JWT token from CreateTransactionLink
  @$pb.TagNumber(1)
  $core.String get trackingToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set trackingToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTrackingToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrackingToken() => $_clearField(1);
}

/// Response with transaction status
class GetTransactionStatusResponse extends $pb.GeneratedMessage {
  factory GetTransactionStatusResponse({
    TransactionStatus? status,
    $core.String? signature,
    $core.String? error,
    $fixnum.Int64? confirmedAt,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (signature != null) result.signature = signature;
    if (error != null) result.error = error;
    if (confirmedAt != null) result.confirmedAt = confirmedAt;
    return result;
  }

  GetTransactionStatusResponse._();

  factory GetTransactionStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransactionStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransactionStatusResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.transactionlink.v1'),
      createEmptyInstance: create)
    ..e<TransactionStatus>(
        1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: TransactionStatus.TRANSACTION_STATUS_UNSPECIFIED,
        valueOf: TransactionStatus.valueOf,
        enumValues: TransactionStatus.values)
    ..aOS(2, _omitFieldNames ? '' : 'signature')
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..aInt64(4, _omitFieldNames ? '' : 'confirmedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusResponse clone() =>
      GetTransactionStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionStatusResponse copyWith(
          void Function(GetTransactionStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetTransactionStatusResponse))
          as GetTransactionStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusResponse create() =>
      GetTransactionStatusResponse._();
  @$core.override
  GetTransactionStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionStatusResponse> createRepeated() =>
      $pb.PbList<GetTransactionStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransactionStatusResponse>(create);
  static GetTransactionStatusResponse? _defaultInstance;

  /// Transaction status
  @$pb.TagNumber(1)
  TransactionStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(TransactionStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  /// Transaction signature (if submitted)
  @$pb.TagNumber(2)
  $core.String get signature => $_getSZ(1);
  @$pb.TagNumber(2)
  set signature($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);

  /// Error message (if failed)
  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);

  /// Confirmation timestamp (if confirmed)
  @$pb.TagNumber(4)
  $fixnum.Int64 get confirmedAt => $_getI64(3);
  @$pb.TagNumber(4)
  set confirmedAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasConfirmedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfirmedAt() => $_clearField(4);
}

/// TransactionLinkService manages transaction signing links and wallet onboarding
class TransactionLinkServiceApi {
  final $pb.RpcClient _client;

  TransactionLinkServiceApi(this._client);

  /// Creates a link for user onboarding (Privy auth + SWIG wallet creation)
  $async.Future<GetOnboardingLinkResponse> getOnboardingLink(
          $pb.ClientContext? ctx, GetOnboardingLinkRequest request) =>
      _client.invoke<GetOnboardingLinkResponse>(ctx, 'TransactionLinkService',
          'GetOnboardingLink', request, GetOnboardingLinkResponse());

  /// Creates a transaction signing link with JWT
  $async.Future<CreateTransactionLinkResponse> createTransactionLink(
          $pb.ClientContext? ctx, CreateTransactionLinkRequest request) =>
      _client.invoke<CreateTransactionLinkResponse>(
          ctx,
          'TransactionLinkService',
          'CreateTransactionLink',
          request,
          CreateTransactionLinkResponse());

  /// Gets the status of a transaction from blockchain
  $async.Future<GetTransactionStatusResponse> getTransactionStatus(
          $pb.ClientContext? ctx, GetTransactionStatusRequest request) =>
      _client.invoke<GetTransactionStatusResponse>(
          ctx,
          'TransactionLinkService',
          'GetTransactionStatus',
          request,
          GetTransactionStatusResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
