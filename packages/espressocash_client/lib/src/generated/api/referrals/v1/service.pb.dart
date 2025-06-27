//
//  Generated code. Do not modify.
//  source: api/referrals/v1/service.proto
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

class AddReferralRequest extends $pb.GeneratedMessage {
  factory AddReferralRequest({
    $core.String? ambassadorAddress,
  }) {
    final result = create();
    if (ambassadorAddress != null) result.ambassadorAddress = ambassadorAddress;
    return result;
  }

  AddReferralRequest._();

  factory AddReferralRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddReferralRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddReferralRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ambassadorAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddReferralRequest clone() => AddReferralRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddReferralRequest copyWith(void Function(AddReferralRequest) updates) =>
      super.copyWith((message) => updates(message as AddReferralRequest)) as AddReferralRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddReferralRequest create() => AddReferralRequest._();
  @$core.override
  AddReferralRequest createEmptyInstance() => create();
  static $pb.PbList<AddReferralRequest> createRepeated() => $pb.PbList<AddReferralRequest>();
  @$core.pragma('dart2js:noInline')
  static AddReferralRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddReferralRequest>(create);
  static AddReferralRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ambassadorAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ambassadorAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmbassadorAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmbassadorAddress() => $_clearField(1);
}

class AddReferralResponse extends $pb.GeneratedMessage {
  factory AddReferralResponse() => create();

  AddReferralResponse._();

  factory AddReferralResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddReferralResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddReferralResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddReferralResponse clone() => AddReferralResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddReferralResponse copyWith(void Function(AddReferralResponse) updates) =>
      super.copyWith((message) => updates(message as AddReferralResponse)) as AddReferralResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddReferralResponse create() => AddReferralResponse._();
  @$core.override
  AddReferralResponse createEmptyInstance() => create();
  static $pb.PbList<AddReferralResponse> createRepeated() => $pb.PbList<AddReferralResponse>();
  @$core.pragma('dart2js:noInline')
  static AddReferralResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddReferralResponse>(create);
  static AddReferralResponse? _defaultInstance;
}

class GetStatsRequest extends $pb.GeneratedMessage {
  factory GetStatsRequest() => create();

  GetStatsRequest._();

  factory GetStatsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStatsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStatsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatsRequest clone() => GetStatsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatsRequest copyWith(void Function(GetStatsRequest) updates) =>
      super.copyWith((message) => updates(message as GetStatsRequest)) as GetStatsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStatsRequest create() => GetStatsRequest._();
  @$core.override
  GetStatsRequest createEmptyInstance() => create();
  static $pb.PbList<GetStatsRequest> createRepeated() => $pb.PbList<GetStatsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStatsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStatsRequest>(create);
  static GetStatsRequest? _defaultInstance;
}

class GetStatsResponse extends $pb.GeneratedMessage {
  factory GetStatsResponse({
    $core.int? referralCount,
  }) {
    final result = create();
    if (referralCount != null) result.referralCount = referralCount;
    return result;
  }

  GetStatsResponse._();

  factory GetStatsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStatsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStatsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'referralCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatsResponse clone() => GetStatsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatsResponse copyWith(void Function(GetStatsResponse) updates) =>
      super.copyWith((message) => updates(message as GetStatsResponse)) as GetStatsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStatsResponse create() => GetStatsResponse._();
  @$core.override
  GetStatsResponse createEmptyInstance() => create();
  static $pb.PbList<GetStatsResponse> createRepeated() => $pb.PbList<GetStatsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStatsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStatsResponse>(create);
  static GetStatsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get referralCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set referralCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReferralCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearReferralCount() => $_clearField(1);
}

class VerifyRequest extends $pb.GeneratedMessage {
  factory VerifyRequest() => create();

  VerifyRequest._();

  factory VerifyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyRequest clone() => VerifyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyRequest copyWith(void Function(VerifyRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyRequest)) as VerifyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyRequest create() => VerifyRequest._();
  @$core.override
  VerifyRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyRequest> createRepeated() => $pb.PbList<VerifyRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyRequest>(create);
  static VerifyRequest? _defaultInstance;
}

class VerifyResponse extends $pb.GeneratedMessage {
  factory VerifyResponse({
    $core.bool? isAmbassador,
    $core.bool? isReferral,
  }) {
    final result = create();
    if (isAmbassador != null) result.isAmbassador = isAmbassador;
    if (isReferral != null) result.isReferral = isReferral;
    return result;
  }

  VerifyResponse._();

  factory VerifyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isAmbassador')
    ..aOB(2, _omitFieldNames ? '' : 'isReferral')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyResponse clone() => VerifyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyResponse copyWith(void Function(VerifyResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyResponse)) as VerifyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyResponse create() => VerifyResponse._();
  @$core.override
  VerifyResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyResponse> createRepeated() => $pb.PbList<VerifyResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyResponse>(create);
  static VerifyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isAmbassador => $_getBF(0);
  @$pb.TagNumber(1)
  set isAmbassador($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsAmbassador() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsAmbassador() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isReferral => $_getBF(1);
  @$pb.TagNumber(2)
  set isReferral($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsReferral() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsReferral() => $_clearField(2);
}

const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
