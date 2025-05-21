//
//  Generated code. Do not modify.
//  source: api/tokens/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class GetTokensMetaRequest extends $pb.GeneratedMessage {
  factory GetTokensMetaRequest() => create();
  GetTokensMetaRequest._() : super();
  factory GetTokensMetaRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTokensMetaRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTokensMetaRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.tokens.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensMetaRequest clone() => GetTokensMetaRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensMetaRequest copyWith(void Function(GetTokensMetaRequest) updates) => super.copyWith((message) => updates(message as GetTokensMetaRequest)) as GetTokensMetaRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTokensMetaRequest create() => GetTokensMetaRequest._();
  GetTokensMetaRequest createEmptyInstance() => create();
  static $pb.PbList<GetTokensMetaRequest> createRepeated() => $pb.PbList<GetTokensMetaRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTokensMetaRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTokensMetaRequest>(create);
  static GetTokensMetaRequest? _defaultInstance;
}

class GetTokensMetaResponse extends $pb.GeneratedMessage {
  factory GetTokensMetaResponse({
    $core.String? md5,
  }) {
    final $result = create();
    if (md5 != null) {
      $result.md5 = md5;
    }
    return $result;
  }
  GetTokensMetaResponse._() : super();
  factory GetTokensMetaResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTokensMetaResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTokensMetaResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.tokens.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'md5')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensMetaResponse clone() => GetTokensMetaResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensMetaResponse copyWith(void Function(GetTokensMetaResponse) updates) => super.copyWith((message) => updates(message as GetTokensMetaResponse)) as GetTokensMetaResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTokensMetaResponse create() => GetTokensMetaResponse._();
  GetTokensMetaResponse createEmptyInstance() => create();
  static $pb.PbList<GetTokensMetaResponse> createRepeated() => $pb.PbList<GetTokensMetaResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTokensMetaResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTokensMetaResponse>(create);
  static GetTokensMetaResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get md5 => $_getSZ(0);
  @$pb.TagNumber(1)
  set md5($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMd5() => $_has(0);
  @$pb.TagNumber(1)
  void clearMd5() => $_clearField(1);
}

class GetTokensFileRequest extends $pb.GeneratedMessage {
  factory GetTokensFileRequest() => create();
  GetTokensFileRequest._() : super();
  factory GetTokensFileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTokensFileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTokensFileRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.tokens.v1'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensFileRequest clone() => GetTokensFileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensFileRequest copyWith(void Function(GetTokensFileRequest) updates) => super.copyWith((message) => updates(message as GetTokensFileRequest)) as GetTokensFileRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTokensFileRequest create() => GetTokensFileRequest._();
  GetTokensFileRequest createEmptyInstance() => create();
  static $pb.PbList<GetTokensFileRequest> createRepeated() => $pb.PbList<GetTokensFileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTokensFileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTokensFileRequest>(create);
  static GetTokensFileRequest? _defaultInstance;
}

class GetTokensFileResponse extends $pb.GeneratedMessage {
  factory GetTokensFileResponse({
    $core.List<$core.int>? content,
  }) {
    final $result = create();
    if (content != null) {
      $result.content = content;
    }
    return $result;
  }
  GetTokensFileResponse._() : super();
  factory GetTokensFileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTokensFileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTokensFileResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.tokens.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'content', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensFileResponse clone() => GetTokensFileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTokensFileResponse copyWith(void Function(GetTokensFileResponse) updates) => super.copyWith((message) => updates(message as GetTokensFileResponse)) as GetTokensFileResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTokensFileResponse create() => GetTokensFileResponse._();
  GetTokensFileResponse createEmptyInstance() => create();
  static $pb.PbList<GetTokensFileResponse> createRepeated() => $pb.PbList<GetTokensFileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTokensFileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTokensFileResponse>(create);
  static GetTokensFileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get content => $_getN(0);
  @$pb.TagNumber(1)
  set content($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasContent() => $_has(0);
  @$pb.TagNumber(1)
  void clearContent() => $_clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
