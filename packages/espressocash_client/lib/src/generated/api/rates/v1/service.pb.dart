//
//  Generated code. Do not modify.
//  source: api/rates/v1/service.proto
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

class GetRatesRequest extends $pb.GeneratedMessage {
  factory GetRatesRequest() => create();

  GetRatesRequest._();

  factory GetRatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.rates.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRatesRequest clone() => GetRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRatesRequest copyWith(void Function(GetRatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetRatesRequest)) as GetRatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRatesRequest create() => GetRatesRequest._();
  @$core.override
  GetRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetRatesRequest> createRepeated() => $pb.PbList<GetRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRatesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRatesRequest>(create);
  static GetRatesRequest? _defaultInstance;
}

class GetRatesResponse extends $pb.GeneratedMessage {
  factory GetRatesResponse({
    $core.double? usdc,
  }) {
    final result = create();
    if (usdc != null) result.usdc = usdc;
    return result;
  }

  GetRatesResponse._();

  factory GetRatesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetRatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRatesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.rates.v1'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'usdc', $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRatesResponse clone() => GetRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRatesResponse copyWith(void Function(GetRatesResponse) updates) =>
      super.copyWith((message) => updates(message as GetRatesResponse)) as GetRatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRatesResponse create() => GetRatesResponse._();
  @$core.override
  GetRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetRatesResponse> createRepeated() => $pb.PbList<GetRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRatesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRatesResponse>(create);
  static GetRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get usdc => $_getN(0);
  @$pb.TagNumber(1)
  set usdc($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsdc() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsdc() => $_clearField(1);
}

class GetFiatRatesRequest extends $pb.GeneratedMessage {
  factory GetFiatRatesRequest({
    $core.String? base,
    $core.String? target,
  }) {
    final result = create();
    if (base != null) result.base = base;
    if (target != null) result.target = target;
    return result;
  }

  GetFiatRatesRequest._();

  factory GetFiatRatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFiatRatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFiatRatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.rates.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'base')
    ..aOS(2, _omitFieldNames ? '' : 'target')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFiatRatesRequest clone() => GetFiatRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFiatRatesRequest copyWith(void Function(GetFiatRatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetFiatRatesRequest)) as GetFiatRatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFiatRatesRequest create() => GetFiatRatesRequest._();
  @$core.override
  GetFiatRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetFiatRatesRequest> createRepeated() => $pb.PbList<GetFiatRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFiatRatesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFiatRatesRequest>(create);
  static GetFiatRatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get base => $_getSZ(0);
  @$pb.TagNumber(1)
  set base($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBase() => $_has(0);
  @$pb.TagNumber(1)
  void clearBase() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get target => $_getSZ(1);
  @$pb.TagNumber(2)
  set target($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTarget() => $_has(1);
  @$pb.TagNumber(2)
  void clearTarget() => $_clearField(2);
}

class GetFiatRatesResponse extends $pb.GeneratedMessage {
  factory GetFiatRatesResponse({
    $core.double? rate,
  }) {
    final result = create();
    if (rate != null) result.rate = rate;
    return result;
  }

  GetFiatRatesResponse._();

  factory GetFiatRatesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFiatRatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFiatRatesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.rates.v1'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFiatRatesResponse clone() => GetFiatRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFiatRatesResponse copyWith(void Function(GetFiatRatesResponse) updates) =>
      super.copyWith((message) => updates(message as GetFiatRatesResponse)) as GetFiatRatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFiatRatesResponse create() => GetFiatRatesResponse._();
  @$core.override
  GetFiatRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetFiatRatesResponse> createRepeated() => $pb.PbList<GetFiatRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFiatRatesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFiatRatesResponse>(create);
  static GetFiatRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get rate => $_getN(0);
  @$pb.TagNumber(1)
  set rate($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRate() => $_clearField(1);
}

const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
