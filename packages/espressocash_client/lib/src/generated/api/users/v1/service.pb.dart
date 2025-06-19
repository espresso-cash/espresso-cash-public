//
//  Generated code. Do not modify.
//  source: api/users/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class LoginRequest extends $pb.GeneratedMessage {
  factory LoginRequest({
    $core.String? walletAddress,
    $core.String? proofSignature,
    $core.String? proofMessage,
  }) {
    final result = create();
    if (walletAddress != null) result.walletAddress = walletAddress;
    if (proofSignature != null) result.proofSignature = proofSignature;
    if (proofMessage != null) result.proofMessage = proofMessage;
    return result;
  }

  LoginRequest._();

  factory LoginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.users.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletAddress')
    ..aOS(2, _omitFieldNames ? '' : 'proofSignature')
    ..aOS(3, _omitFieldNames ? '' : 'proofMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest clone() => LoginRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest copyWith(void Function(LoginRequest) updates) =>
      super.copyWith((message) => updates(message as LoginRequest)) as LoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginRequest create() => LoginRequest._();
  @$core.override
  LoginRequest createEmptyInstance() => create();
  static $pb.PbList<LoginRequest> createRepeated() => $pb.PbList<LoginRequest>();
  @$core.pragma('dart2js:noInline')
  static LoginRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginRequest>(create);
  static LoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWalletAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletAddress() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get proofSignature => $_getSZ(1);
  @$pb.TagNumber(2)
  set proofSignature($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProofSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearProofSignature() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get proofMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set proofMessage($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProofMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearProofMessage() => $_clearField(3);
}

class LoginResponse extends $pb.GeneratedMessage {
  factory LoginResponse({
    $core.String? token,
  }) {
    final result = create();
    if (token != null) result.token = token;
    return result;
  }

  LoginResponse._();

  factory LoginResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LoginResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.users.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginResponse clone() => LoginResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginResponse copyWith(void Function(LoginResponse) updates) =>
      super.copyWith((message) => updates(message as LoginResponse)) as LoginResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginResponse create() => LoginResponse._();
  @$core.override
  LoginResponse createEmptyInstance() => create();
  static $pb.PbList<LoginResponse> createRepeated() => $pb.PbList<LoginResponse>();
  @$core.pragma('dart2js:noInline')
  static LoginResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginResponse>(create);
  static LoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class GetWalletProofMessageRequest extends $pb.GeneratedMessage {
  factory GetWalletProofMessageRequest({
    $core.String? walletAddress,
  }) {
    final result = create();
    if (walletAddress != null) result.walletAddress = walletAddress;
    return result;
  }

  GetWalletProofMessageRequest._();

  factory GetWalletProofMessageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWalletProofMessageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWalletProofMessageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.users.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletProofMessageRequest clone() => GetWalletProofMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletProofMessageRequest copyWith(void Function(GetWalletProofMessageRequest) updates) =>
      super.copyWith((message) => updates(message as GetWalletProofMessageRequest))
          as GetWalletProofMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletProofMessageRequest create() => GetWalletProofMessageRequest._();
  @$core.override
  GetWalletProofMessageRequest createEmptyInstance() => create();
  static $pb.PbList<GetWalletProofMessageRequest> createRepeated() =>
      $pb.PbList<GetWalletProofMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWalletProofMessageRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWalletProofMessageRequest>(create);
  static GetWalletProofMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWalletAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletAddress() => $_clearField(1);
}

class GetWalletProofMessageResponse extends $pb.GeneratedMessage {
  factory GetWalletProofMessageResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  GetWalletProofMessageResponse._();

  factory GetWalletProofMessageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWalletProofMessageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWalletProofMessageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.users.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletProofMessageResponse clone() => GetWalletProofMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWalletProofMessageResponse copyWith(void Function(GetWalletProofMessageResponse) updates) =>
      super.copyWith((message) => updates(message as GetWalletProofMessageResponse))
          as GetWalletProofMessageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletProofMessageResponse create() => GetWalletProofMessageResponse._();
  @$core.override
  GetWalletProofMessageResponse createEmptyInstance() => create();
  static $pb.PbList<GetWalletProofMessageResponse> createRepeated() =>
      $pb.PbList<GetWalletProofMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWalletProofMessageResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWalletProofMessageResponse>(create);
  static GetWalletProofMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class UpdateCountryRequest extends $pb.GeneratedMessage {
  factory UpdateCountryRequest({
    $core.String? countryCode,
  }) {
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  UpdateCountryRequest._();

  factory UpdateCountryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCountryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateCountryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.users.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCountryRequest clone() => UpdateCountryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCountryRequest copyWith(void Function(UpdateCountryRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateCountryRequest)) as UpdateCountryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCountryRequest create() => UpdateCountryRequest._();
  @$core.override
  UpdateCountryRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCountryRequest> createRepeated() => $pb.PbList<UpdateCountryRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCountryRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCountryRequest>(create);
  static UpdateCountryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);
}

class UpdateCountryResponse extends $pb.GeneratedMessage {
  factory UpdateCountryResponse() => create();

  UpdateCountryResponse._();

  factory UpdateCountryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateCountryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateCountryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.users.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCountryResponse clone() => UpdateCountryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateCountryResponse copyWith(void Function(UpdateCountryResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateCountryResponse))
          as UpdateCountryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateCountryResponse create() => UpdateCountryResponse._();
  @$core.override
  UpdateCountryResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateCountryResponse> createRepeated() => $pb.PbList<UpdateCountryResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateCountryResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCountryResponse>(create);
  static UpdateCountryResponse? _defaultInstance;
}

const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
