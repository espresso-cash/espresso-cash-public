// This is a generated file - do not edit.
//
// Generated from espressocash/manage/v1/service.proto.

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class UpdateRatesRequest extends $pb.GeneratedMessage {
  factory UpdateRatesRequest() => create();

  UpdateRatesRequest._();

  factory UpdateRatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateRatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRatesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.manage.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRatesRequest clone() => UpdateRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRatesRequest copyWith(void Function(UpdateRatesRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateRatesRequest))
          as UpdateRatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRatesRequest create() => UpdateRatesRequest._();
  @$core.override
  UpdateRatesRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateRatesRequest> createRepeated() =>
      $pb.PbList<UpdateRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateRatesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateRatesRequest>(create);
  static UpdateRatesRequest? _defaultInstance;
}

class UpdateRatesResponse extends $pb.GeneratedMessage {
  factory UpdateRatesResponse() => create();

  UpdateRatesResponse._();

  factory UpdateRatesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateRatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRatesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.manage.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRatesResponse clone() => UpdateRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateRatesResponse copyWith(void Function(UpdateRatesResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateRatesResponse))
          as UpdateRatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRatesResponse create() => UpdateRatesResponse._();
  @$core.override
  UpdateRatesResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateRatesResponse> createRepeated() =>
      $pb.PbList<UpdateRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateRatesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateRatesResponse>(create);
  static UpdateRatesResponse? _defaultInstance;
}

class CheckTransactionsRequest extends $pb.GeneratedMessage {
  factory CheckTransactionsRequest() => create();

  CheckTransactionsRequest._();

  factory CheckTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckTransactionsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.manage.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckTransactionsRequest clone() =>
      CheckTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckTransactionsRequest copyWith(
          void Function(CheckTransactionsRequest) updates) =>
      super.copyWith((message) => updates(message as CheckTransactionsRequest))
          as CheckTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckTransactionsRequest create() => CheckTransactionsRequest._();
  @$core.override
  CheckTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<CheckTransactionsRequest> createRepeated() =>
      $pb.PbList<CheckTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckTransactionsRequest>(create);
  static CheckTransactionsRequest? _defaultInstance;
}

class CheckTransactionsResponse extends $pb.GeneratedMessage {
  factory CheckTransactionsResponse() => create();

  CheckTransactionsResponse._();

  factory CheckTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckTransactionsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.manage.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckTransactionsResponse clone() =>
      CheckTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckTransactionsResponse copyWith(
          void Function(CheckTransactionsResponse) updates) =>
      super.copyWith((message) => updates(message as CheckTransactionsResponse))
          as CheckTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckTransactionsResponse create() => CheckTransactionsResponse._();
  @$core.override
  CheckTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<CheckTransactionsResponse> createRepeated() =>
      $pb.PbList<CheckTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckTransactionsResponse>(create);
  static CheckTransactionsResponse? _defaultInstance;
}

class GetPlatformAccountInfoRequest extends $pb.GeneratedMessage {
  factory GetPlatformAccountInfoRequest() => create();

  GetPlatformAccountInfoRequest._();

  factory GetPlatformAccountInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPlatformAccountInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPlatformAccountInfoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.manage.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPlatformAccountInfoRequest clone() =>
      GetPlatformAccountInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPlatformAccountInfoRequest copyWith(
          void Function(GetPlatformAccountInfoRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPlatformAccountInfoRequest))
          as GetPlatformAccountInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformAccountInfoRequest create() =>
      GetPlatformAccountInfoRequest._();
  @$core.override
  GetPlatformAccountInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlatformAccountInfoRequest> createRepeated() =>
      $pb.PbList<GetPlatformAccountInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformAccountInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPlatformAccountInfoRequest>(create);
  static GetPlatformAccountInfoRequest? _defaultInstance;
}

class GetPlatformAccountInfoResponse extends $pb.GeneratedMessage {
  factory GetPlatformAccountInfoResponse({
    $core.String? publicKey,
    $fixnum.Int64? balance,
  }) {
    final result = create();
    if (publicKey != null) result.publicKey = publicKey;
    if (balance != null) result.balance = balance;
    return result;
  }

  GetPlatformAccountInfoResponse._();

  factory GetPlatformAccountInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPlatformAccountInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPlatformAccountInfoResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.manage.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'publicKey')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPlatformAccountInfoResponse clone() =>
      GetPlatformAccountInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPlatformAccountInfoResponse copyWith(
          void Function(GetPlatformAccountInfoResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPlatformAccountInfoResponse))
          as GetPlatformAccountInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformAccountInfoResponse create() =>
      GetPlatformAccountInfoResponse._();
  @$core.override
  GetPlatformAccountInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetPlatformAccountInfoResponse> createRepeated() =>
      $pb.PbList<GetPlatformAccountInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformAccountInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPlatformAccountInfoResponse>(create);
  static GetPlatformAccountInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get publicKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set publicKey($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get balance => $_getI64(1);
  @$pb.TagNumber(2)
  set balance($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalance() => $_clearField(2);
}

class ManageServiceApi {
  final $pb.RpcClient _client;

  ManageServiceApi(this._client);

  $async.Future<UpdateRatesResponse> updateRates(
          $pb.ClientContext? ctx, UpdateRatesRequest request) =>
      _client.invoke<UpdateRatesResponse>(
          ctx, 'ManageService', 'UpdateRates', request, UpdateRatesResponse());
  $async.Future<CheckTransactionsResponse> checkTransactions(
          $pb.ClientContext? ctx, CheckTransactionsRequest request) =>
      _client.invoke<CheckTransactionsResponse>(ctx, 'ManageService',
          'CheckTransactions', request, CheckTransactionsResponse());
  $async.Future<GetPlatformAccountInfoResponse> getPlatformAccountInfo(
          $pb.ClientContext? ctx, GetPlatformAccountInfoRequest request) =>
      _client.invoke<GetPlatformAccountInfoResponse>(ctx, 'ManageService',
          'GetPlatformAccountInfo', request, GetPlatformAccountInfoResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
