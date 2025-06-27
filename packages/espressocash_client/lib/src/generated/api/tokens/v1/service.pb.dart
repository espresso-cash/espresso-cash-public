//
//  Generated code. Do not modify.
//  source: api/tokens/v1/service.proto
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

class GetTokensMetaRequest extends $pb.GeneratedMessage {
  factory GetTokensMetaRequest() => create();

  GetTokensMetaRequest._();

  factory GetTokensMetaRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTokensMetaRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTokensMetaRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.tokens.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensMetaRequest clone() => GetTokensMetaRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensMetaRequest copyWith(void Function(GetTokensMetaRequest) updates) =>
      super.copyWith((message) => updates(message as GetTokensMetaRequest)) as GetTokensMetaRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTokensMetaRequest create() => GetTokensMetaRequest._();
  @$core.override
  GetTokensMetaRequest createEmptyInstance() => create();
  static $pb.PbList<GetTokensMetaRequest> createRepeated() => $pb.PbList<GetTokensMetaRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTokensMetaRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTokensMetaRequest>(create);
  static GetTokensMetaRequest? _defaultInstance;
}

class GetTokensMetaResponse extends $pb.GeneratedMessage {
  factory GetTokensMetaResponse({
    $core.String? md5,
  }) {
    final result = create();
    if (md5 != null) result.md5 = md5;
    return result;
  }

  GetTokensMetaResponse._();

  factory GetTokensMetaResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTokensMetaResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTokensMetaResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.tokens.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'md5')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensMetaResponse clone() => GetTokensMetaResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensMetaResponse copyWith(void Function(GetTokensMetaResponse) updates) =>
      super.copyWith((message) => updates(message as GetTokensMetaResponse))
          as GetTokensMetaResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTokensMetaResponse create() => GetTokensMetaResponse._();
  @$core.override
  GetTokensMetaResponse createEmptyInstance() => create();
  static $pb.PbList<GetTokensMetaResponse> createRepeated() => $pb.PbList<GetTokensMetaResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTokensMetaResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTokensMetaResponse>(create);
  static GetTokensMetaResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get md5 => $_getSZ(0);
  @$pb.TagNumber(1)
  set md5($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMd5() => $_has(0);
  @$pb.TagNumber(1)
  void clearMd5() => $_clearField(1);
}

class GetTokensFileRequest extends $pb.GeneratedMessage {
  factory GetTokensFileRequest() => create();

  GetTokensFileRequest._();

  factory GetTokensFileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTokensFileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTokensFileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.tokens.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensFileRequest clone() => GetTokensFileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensFileRequest copyWith(void Function(GetTokensFileRequest) updates) =>
      super.copyWith((message) => updates(message as GetTokensFileRequest)) as GetTokensFileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTokensFileRequest create() => GetTokensFileRequest._();
  @$core.override
  GetTokensFileRequest createEmptyInstance() => create();
  static $pb.PbList<GetTokensFileRequest> createRepeated() => $pb.PbList<GetTokensFileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTokensFileRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTokensFileRequest>(create);
  static GetTokensFileRequest? _defaultInstance;
}

class GetTokensFileResponse extends $pb.GeneratedMessage {
  factory GetTokensFileResponse({
    $core.List<$core.int>? content,
  }) {
    final result = create();
    if (content != null) result.content = content;
    return result;
  }

  GetTokensFileResponse._();

  factory GetTokensFileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTokensFileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTokensFileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.tokens.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensFileResponse clone() => GetTokensFileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensFileResponse copyWith(void Function(GetTokensFileResponse) updates) =>
      super.copyWith((message) => updates(message as GetTokensFileResponse))
          as GetTokensFileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTokensFileResponse create() => GetTokensFileResponse._();
  @$core.override
  GetTokensFileResponse createEmptyInstance() => create();
  static $pb.PbList<GetTokensFileResponse> createRepeated() => $pb.PbList<GetTokensFileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTokensFileResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTokensFileResponse>(create);
  static GetTokensFileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get content => $_getN(0);
  @$pb.TagNumber(1)
  set content($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => $_clearField(1);
}

const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
