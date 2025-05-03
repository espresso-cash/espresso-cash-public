//
//  Generated code. Do not modify.
//  source: api/rates/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GetRatesRequest extends $pb.GeneratedMessage {
  factory GetRatesRequest() => create();
  GetRatesRequest._() : super();
  factory GetRatesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetRatesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.rates.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetRatesRequest clone() => GetRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetRatesRequest copyWith(void Function(GetRatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetRatesRequest)) as GetRatesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRatesRequest create() => GetRatesRequest._();
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
    final $result = create();
    if (usdc != null) {
      $result.usdc = usdc;
    }
    return $result;
  }
  GetRatesResponse._() : super();
  factory GetRatesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetRatesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRatesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.rates.v1'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'usdc', $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetRatesResponse clone() => GetRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetRatesResponse copyWith(void Function(GetRatesResponse) updates) =>
      super.copyWith((message) => updates(message as GetRatesResponse)) as GetRatesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRatesResponse create() => GetRatesResponse._();
  GetRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetRatesResponse> createRepeated() => $pb.PbList<GetRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRatesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRatesResponse>(create);
  static GetRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get usdc => $_getN(0);
  @$pb.TagNumber(1)
  set usdc($core.double v) {
    $_setFloat(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUsdc() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsdc() => clearField(1);
}

class GetFiatRatesRequest extends $pb.GeneratedMessage {
  factory GetFiatRatesRequest({
    $core.String? base,
    $core.String? target,
  }) {
    final $result = create();
    if (base != null) {
      $result.base = base;
    }
    if (target != null) {
      $result.target = target;
    }
    return $result;
  }
  GetFiatRatesRequest._() : super();
  factory GetFiatRatesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetFiatRatesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFiatRatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.rates.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'base')
    ..aOS(2, _omitFieldNames ? '' : 'target')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFiatRatesRequest clone() => GetFiatRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFiatRatesRequest copyWith(void Function(GetFiatRatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetFiatRatesRequest)) as GetFiatRatesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFiatRatesRequest create() => GetFiatRatesRequest._();
  GetFiatRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetFiatRatesRequest> createRepeated() => $pb.PbList<GetFiatRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFiatRatesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFiatRatesRequest>(create);
  static GetFiatRatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get base => $_getSZ(0);
  @$pb.TagNumber(1)
  set base($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBase() => $_has(0);
  @$pb.TagNumber(1)
  void clearBase() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get target => $_getSZ(1);
  @$pb.TagNumber(2)
  set target($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTarget() => $_has(1);
  @$pb.TagNumber(2)
  void clearTarget() => clearField(2);
}

class GetFiatRatesResponse extends $pb.GeneratedMessage {
  factory GetFiatRatesResponse({
    $core.double? rate,
  }) {
    final $result = create();
    if (rate != null) {
      $result.rate = rate;
    }
    return $result;
  }
  GetFiatRatesResponse._() : super();
  factory GetFiatRatesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetFiatRatesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFiatRatesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.rates.v1'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetFiatRatesResponse clone() => GetFiatRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetFiatRatesResponse copyWith(void Function(GetFiatRatesResponse) updates) =>
      super.copyWith((message) => updates(message as GetFiatRatesResponse)) as GetFiatRatesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFiatRatesResponse create() => GetFiatRatesResponse._();
  GetFiatRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetFiatRatesResponse> createRepeated() => $pb.PbList<GetFiatRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFiatRatesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFiatRatesResponse>(create);
  static GetFiatRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get rate => $_getN(0);
  @$pb.TagNumber(1)
  set rate($core.double v) {
    $_setFloat(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRate() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
