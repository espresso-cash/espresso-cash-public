//
//  Generated code. Do not modify.
//  source: api/shortener/v1/service.proto
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

class ShortenLinkRequest extends $pb.GeneratedMessage {
  factory ShortenLinkRequest({
    $core.String? fullLink,
  }) {
    final result = create();
    if (fullLink != null) result.fullLink = fullLink;
    return result;
  }

  ShortenLinkRequest._();

  factory ShortenLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ShortenLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ShortenLinkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.shortener.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullLink')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ShortenLinkRequest clone() => ShortenLinkRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ShortenLinkRequest copyWith(void Function(ShortenLinkRequest) updates) =>
      super.copyWith((message) => updates(message as ShortenLinkRequest)) as ShortenLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShortenLinkRequest create() => ShortenLinkRequest._();
  @$core.override
  ShortenLinkRequest createEmptyInstance() => create();
  static $pb.PbList<ShortenLinkRequest> createRepeated() => $pb.PbList<ShortenLinkRequest>();
  @$core.pragma('dart2js:noInline')
  static ShortenLinkRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShortenLinkRequest>(create);
  static ShortenLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullLink($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFullLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullLink() => $_clearField(1);
}

class ShortenLinkResponse extends $pb.GeneratedMessage {
  factory ShortenLinkResponse({
    $core.String? shortLink,
  }) {
    final result = create();
    if (shortLink != null) result.shortLink = shortLink;
    return result;
  }

  ShortenLinkResponse._();

  factory ShortenLinkResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ShortenLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ShortenLinkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.shortener.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shortLink')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ShortenLinkResponse clone() => ShortenLinkResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ShortenLinkResponse copyWith(void Function(ShortenLinkResponse) updates) =>
      super.copyWith((message) => updates(message as ShortenLinkResponse)) as ShortenLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ShortenLinkResponse create() => ShortenLinkResponse._();
  @$core.override
  ShortenLinkResponse createEmptyInstance() => create();
  static $pb.PbList<ShortenLinkResponse> createRepeated() => $pb.PbList<ShortenLinkResponse>();
  @$core.pragma('dart2js:noInline')
  static ShortenLinkResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShortenLinkResponse>(create);
  static ShortenLinkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get shortLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set shortLink($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasShortLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearShortLink() => $_clearField(1);
}

class ExpandLinkRequest extends $pb.GeneratedMessage {
  factory ExpandLinkRequest({
    $core.String? shortLink,
  }) {
    final result = create();
    if (shortLink != null) result.shortLink = shortLink;
    return result;
  }

  ExpandLinkRequest._();

  factory ExpandLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExpandLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExpandLinkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.shortener.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shortLink')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpandLinkRequest clone() => ExpandLinkRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpandLinkRequest copyWith(void Function(ExpandLinkRequest) updates) =>
      super.copyWith((message) => updates(message as ExpandLinkRequest)) as ExpandLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExpandLinkRequest create() => ExpandLinkRequest._();
  @$core.override
  ExpandLinkRequest createEmptyInstance() => create();
  static $pb.PbList<ExpandLinkRequest> createRepeated() => $pb.PbList<ExpandLinkRequest>();
  @$core.pragma('dart2js:noInline')
  static ExpandLinkRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExpandLinkRequest>(create);
  static ExpandLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get shortLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set shortLink($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasShortLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearShortLink() => $_clearField(1);
}

class ExpandLinkResponse extends $pb.GeneratedMessage {
  factory ExpandLinkResponse({
    $core.String? fullLink,
  }) {
    final result = create();
    if (fullLink != null) result.fullLink = fullLink;
    return result;
  }

  ExpandLinkResponse._();

  factory ExpandLinkResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExpandLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExpandLinkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.shortener.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullLink')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpandLinkResponse clone() => ExpandLinkResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExpandLinkResponse copyWith(void Function(ExpandLinkResponse) updates) =>
      super.copyWith((message) => updates(message as ExpandLinkResponse)) as ExpandLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExpandLinkResponse create() => ExpandLinkResponse._();
  @$core.override
  ExpandLinkResponse createEmptyInstance() => create();
  static $pb.PbList<ExpandLinkResponse> createRepeated() => $pb.PbList<ExpandLinkResponse>();
  @$core.pragma('dart2js:noInline')
  static ExpandLinkResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExpandLinkResponse>(create);
  static ExpandLinkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fullLink => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullLink($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFullLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullLink() => $_clearField(1);
}

const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
