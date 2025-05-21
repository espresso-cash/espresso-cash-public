//
//  Generated code. Do not modify.
//  source: api/referrals/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class AddReferralRequest extends $pb.GeneratedMessage {
  factory AddReferralRequest({
    $core.String? ambassadorAddress,
  }) {
    final $result = create();
    if (ambassadorAddress != null) {
      $result.ambassadorAddress = ambassadorAddress;
    }
    return $result;
  }
  AddReferralRequest._() : super();
  factory AddReferralRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddReferralRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddReferralRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ambassadorAddress')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddReferralRequest clone() => AddReferralRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddReferralRequest copyWith(void Function(AddReferralRequest) updates) => super.copyWith((message) => updates(message as AddReferralRequest)) as AddReferralRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddReferralRequest create() => AddReferralRequest._();
  AddReferralRequest createEmptyInstance() => create();
  static $pb.PbList<AddReferralRequest> createRepeated() => $pb.PbList<AddReferralRequest>();
  @$core.pragma('dart2js:noInline')
  static AddReferralRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddReferralRequest>(create);
  static AddReferralRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ambassadorAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set ambassadorAddress($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmbassadorAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmbassadorAddress() => $_clearField(1);
}

class AddReferralResponse extends $pb.GeneratedMessage {
  factory AddReferralResponse() => create();
  AddReferralResponse._() : super();
  factory AddReferralResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddReferralResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddReferralResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddReferralResponse clone() => AddReferralResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddReferralResponse copyWith(void Function(AddReferralResponse) updates) => super.copyWith((message) => updates(message as AddReferralResponse)) as AddReferralResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddReferralResponse create() => AddReferralResponse._();
  AddReferralResponse createEmptyInstance() => create();
  static $pb.PbList<AddReferralResponse> createRepeated() => $pb.PbList<AddReferralResponse>();
  @$core.pragma('dart2js:noInline')
  static AddReferralResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddReferralResponse>(create);
  static AddReferralResponse? _defaultInstance;
}

class GetStatsRequest extends $pb.GeneratedMessage {
  factory GetStatsRequest() => create();
  GetStatsRequest._() : super();
  factory GetStatsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStatsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStatsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatsRequest clone() => GetStatsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatsRequest copyWith(void Function(GetStatsRequest) updates) => super.copyWith((message) => updates(message as GetStatsRequest)) as GetStatsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStatsRequest create() => GetStatsRequest._();
  GetStatsRequest createEmptyInstance() => create();
  static $pb.PbList<GetStatsRequest> createRepeated() => $pb.PbList<GetStatsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStatsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStatsRequest>(create);
  static GetStatsRequest? _defaultInstance;
}

class GetStatsResponse extends $pb.GeneratedMessage {
  factory GetStatsResponse({
    $core.int? referralCount,
  }) {
    final $result = create();
    if (referralCount != null) {
      $result.referralCount = referralCount;
    }
    return $result;
  }
  GetStatsResponse._() : super();
  factory GetStatsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStatsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStatsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'referralCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatsResponse clone() => GetStatsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStatsResponse copyWith(void Function(GetStatsResponse) updates) => super.copyWith((message) => updates(message as GetStatsResponse)) as GetStatsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStatsResponse create() => GetStatsResponse._();
  GetStatsResponse createEmptyInstance() => create();
  static $pb.PbList<GetStatsResponse> createRepeated() => $pb.PbList<GetStatsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStatsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStatsResponse>(create);
  static GetStatsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get referralCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set referralCount($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReferralCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearReferralCount() => $_clearField(1);
}

class VerifyRequest extends $pb.GeneratedMessage {
  factory VerifyRequest() => create();
  VerifyRequest._() : super();
  factory VerifyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyRequest clone() => VerifyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyRequest copyWith(void Function(VerifyRequest) updates) => super.copyWith((message) => updates(message as VerifyRequest)) as VerifyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyRequest create() => VerifyRequest._();
  VerifyRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyRequest> createRepeated() => $pb.PbList<VerifyRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyRequest>(create);
  static VerifyRequest? _defaultInstance;
}

class VerifyResponse extends $pb.GeneratedMessage {
  factory VerifyResponse({
    $core.bool? isAmbassador,
    $core.bool? isReferral,
  }) {
    final $result = create();
    if (isAmbassador != null) {
      $result.isAmbassador = isAmbassador;
    }
    if (isReferral != null) {
      $result.isReferral = isReferral;
    }
    return $result;
  }
  VerifyResponse._() : super();
  factory VerifyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.referrals.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isAmbassador')
    ..aOB(2, _omitFieldNames ? '' : 'isReferral')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyResponse clone() => VerifyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyResponse copyWith(void Function(VerifyResponse) updates) => super.copyWith((message) => updates(message as VerifyResponse)) as VerifyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyResponse create() => VerifyResponse._();
  VerifyResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyResponse> createRepeated() => $pb.PbList<VerifyResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyResponse>(create);
  static VerifyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isAmbassador => $_getBF(0);
  @$pb.TagNumber(1)
  set isAmbassador($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsAmbassador() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsAmbassador() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isReferral => $_getBF(1);
  @$pb.TagNumber(2)
  set isReferral($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsReferral() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsReferral() => $_clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
