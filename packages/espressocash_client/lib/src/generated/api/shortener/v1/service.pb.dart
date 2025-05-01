//
//  Generated code. Do not modify.
//  source: api/shortener/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ShortenLinkRequest extends $pb.GeneratedMessage {
  factory ShortenLinkRequest({
    $core.String? fullLink,
  }) {
    final $result = create();
    if (fullLink != null) {
      $result.fullLink = fullLink;
    }
    return $result;
  }
  ShortenLinkRequest._() : super();
  factory ShortenLinkRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ShortenLinkRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ShortenLinkRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.shortener.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullLink')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ShortenLinkRequest clone() => ShortenLinkRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ShortenLinkRequest copyWith(void Function(ShortenLinkRequest) updates) => super.copyWith((message) => updates(message as ShortenLinkRequest)) as ShortenLinkRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShortenLinkRequest create() => ShortenLinkRequest._();
  ShortenLinkRequest createEmptyInstance() => create();
  static $pb.PbList<ShortenLinkRequest> createRepeated() => $pb.PbList<ShortenLinkRequest>();
  @$core.pragma('dart2js:noInline')
  static ShortenLinkRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShortenLinkRequest>(create);
  static ShortenLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullLink($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFullLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullLink() => clearField(1);
}

class ShortenLinkResponse extends $pb.GeneratedMessage {
  factory ShortenLinkResponse({
    $core.String? shortLink,
  }) {
    final $result = create();
    if (shortLink != null) {
      $result.shortLink = shortLink;
    }
    return $result;
  }
  ShortenLinkResponse._() : super();
  factory ShortenLinkResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ShortenLinkResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ShortenLinkResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.shortener.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shortLink')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ShortenLinkResponse clone() => ShortenLinkResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ShortenLinkResponse copyWith(void Function(ShortenLinkResponse) updates) => super.copyWith((message) => updates(message as ShortenLinkResponse)) as ShortenLinkResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShortenLinkResponse create() => ShortenLinkResponse._();
  ShortenLinkResponse createEmptyInstance() => create();
  static $pb.PbList<ShortenLinkResponse> createRepeated() => $pb.PbList<ShortenLinkResponse>();
  @$core.pragma('dart2js:noInline')
  static ShortenLinkResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShortenLinkResponse>(create);
  static ShortenLinkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get shortLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set shortLink($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShortLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearShortLink() => clearField(1);
}

class ExpandLinkRequest extends $pb.GeneratedMessage {
  factory ExpandLinkRequest({
    $core.String? shortLink,
  }) {
    final $result = create();
    if (shortLink != null) {
      $result.shortLink = shortLink;
    }
    return $result;
  }
  ExpandLinkRequest._() : super();
  factory ExpandLinkRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExpandLinkRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExpandLinkRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.shortener.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shortLink')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExpandLinkRequest clone() => ExpandLinkRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExpandLinkRequest copyWith(void Function(ExpandLinkRequest) updates) => super.copyWith((message) => updates(message as ExpandLinkRequest)) as ExpandLinkRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExpandLinkRequest create() => ExpandLinkRequest._();
  ExpandLinkRequest createEmptyInstance() => create();
  static $pb.PbList<ExpandLinkRequest> createRepeated() => $pb.PbList<ExpandLinkRequest>();
  @$core.pragma('dart2js:noInline')
  static ExpandLinkRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExpandLinkRequest>(create);
  static ExpandLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get shortLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set shortLink($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShortLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearShortLink() => clearField(1);
}

class ExpandLinkResponse extends $pb.GeneratedMessage {
  factory ExpandLinkResponse({
    $core.String? fullLink,
  }) {
    final $result = create();
    if (fullLink != null) {
      $result.fullLink = fullLink;
    }
    return $result;
  }
  ExpandLinkResponse._() : super();
  factory ExpandLinkResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExpandLinkResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExpandLinkResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.shortener.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullLink')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExpandLinkResponse clone() => ExpandLinkResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExpandLinkResponse copyWith(void Function(ExpandLinkResponse) updates) => super.copyWith((message) => updates(message as ExpandLinkResponse)) as ExpandLinkResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExpandLinkResponse create() => ExpandLinkResponse._();
  ExpandLinkResponse createEmptyInstance() => create();
  static $pb.PbList<ExpandLinkResponse> createRepeated() => $pb.PbList<ExpandLinkResponse>();
  @$core.pragma('dart2js:noInline')
  static ExpandLinkResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExpandLinkResponse>(create);
  static ExpandLinkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullLink($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFullLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullLink() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
