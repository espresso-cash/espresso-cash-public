// This is a generated file - do not edit.
//
// Generated from espressocash/api/stellar/v1/service.proto.

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

class SubmitTransactionRequest extends $pb.GeneratedMessage {
  factory SubmitTransactionRequest({
    $core.String? xdrTransaction,
  }) {
    final result = create();
    if (xdrTransaction != null) result.xdrTransaction = xdrTransaction;
    return result;
  }

  SubmitTransactionRequest._();

  factory SubmitTransactionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitTransactionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitTransactionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.stellar.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'xdrTransaction')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitTransactionRequest clone() =>
      SubmitTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitTransactionRequest copyWith(
          void Function(SubmitTransactionRequest) updates) =>
      super.copyWith((message) => updates(message as SubmitTransactionRequest))
          as SubmitTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitTransactionRequest create() => SubmitTransactionRequest._();
  @$core.override
  SubmitTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitTransactionRequest> createRepeated() =>
      $pb.PbList<SubmitTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitTransactionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitTransactionRequest>(create);
  static SubmitTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get xdrTransaction => $_getSZ(0);
  @$pb.TagNumber(1)
  set xdrTransaction($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasXdrTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearXdrTransaction() => $_clearField(1);
}

class SubmitTransactionResponse extends $pb.GeneratedMessage {
  factory SubmitTransactionResponse({
    $core.String? hash,
    $core.bool? successful,
    $fixnum.Int64? ledger,
    $core.String? resultXdr,
    $core.String? error,
  }) {
    final result = create();
    if (hash != null) result.hash = hash;
    if (successful != null) result.successful = successful;
    if (ledger != null) result.ledger = ledger;
    if (resultXdr != null) result.resultXdr = resultXdr;
    if (error != null) result.error = error;
    return result;
  }

  SubmitTransactionResponse._();

  factory SubmitTransactionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitTransactionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitTransactionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.stellar.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hash')
    ..aOB(2, _omitFieldNames ? '' : 'successful')
    ..aInt64(3, _omitFieldNames ? '' : 'ledger')
    ..aOS(4, _omitFieldNames ? '' : 'resultXdr')
    ..aOS(5, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitTransactionResponse clone() =>
      SubmitTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitTransactionResponse copyWith(
          void Function(SubmitTransactionResponse) updates) =>
      super.copyWith((message) => updates(message as SubmitTransactionResponse))
          as SubmitTransactionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitTransactionResponse create() => SubmitTransactionResponse._();
  @$core.override
  SubmitTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitTransactionResponse> createRepeated() =>
      $pb.PbList<SubmitTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitTransactionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitTransactionResponse>(create);
  static SubmitTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hash => $_getSZ(0);
  @$pb.TagNumber(1)
  set hash($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get successful => $_getBF(1);
  @$pb.TagNumber(2)
  set successful($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccessful() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessful() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get ledger => $_getI64(2);
  @$pb.TagNumber(3)
  set ledger($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLedger() => $_has(2);
  @$pb.TagNumber(3)
  void clearLedger() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get resultXdr => $_getSZ(3);
  @$pb.TagNumber(4)
  set resultXdr($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasResultXdr() => $_has(3);
  @$pb.TagNumber(4)
  void clearResultXdr() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get error => $_getSZ(4);
  @$pb.TagNumber(5)
  set error($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasError() => $_has(4);
  @$pb.TagNumber(5)
  void clearError() => $_clearField(5);
}

class GetTransactionRequest extends $pb.GeneratedMessage {
  factory GetTransactionRequest({
    $core.String? hash,
  }) {
    final result = create();
    if (hash != null) result.hash = hash;
    return result;
  }

  GetTransactionRequest._();

  factory GetTransactionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransactionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransactionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.stellar.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hash')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionRequest clone() =>
      GetTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionRequest copyWith(
          void Function(GetTransactionRequest) updates) =>
      super.copyWith((message) => updates(message as GetTransactionRequest))
          as GetTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionRequest create() => GetTransactionRequest._();
  @$core.override
  GetTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionRequest> createRepeated() =>
      $pb.PbList<GetTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransactionRequest>(create);
  static GetTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hash => $_getSZ(0);
  @$pb.TagNumber(1)
  set hash($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);
}

class GetTransactionResponse extends $pb.GeneratedMessage {
  factory GetTransactionResponse({
    $core.String? hash,
    $core.String? status,
    $fixnum.Int64? ledger,
    $core.String? error,
  }) {
    final result = create();
    if (hash != null) result.hash = hash;
    if (status != null) result.status = status;
    if (ledger != null) result.ledger = ledger;
    if (error != null) result.error = error;
    return result;
  }

  GetTransactionResponse._();

  factory GetTransactionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransactionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransactionResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'espressocash.api.stellar.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hash')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aInt64(3, _omitFieldNames ? '' : 'ledger')
    ..aOS(4, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionResponse clone() =>
      GetTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransactionResponse copyWith(
          void Function(GetTransactionResponse) updates) =>
      super.copyWith((message) => updates(message as GetTransactionResponse))
          as GetTransactionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionResponse create() => GetTransactionResponse._();
  @$core.override
  GetTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionResponse> createRepeated() =>
      $pb.PbList<GetTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransactionResponse>(create);
  static GetTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hash => $_getSZ(0);
  @$pb.TagNumber(1)
  set hash($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get ledger => $_getI64(2);
  @$pb.TagNumber(3)
  set ledger($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLedger() => $_has(2);
  @$pb.TagNumber(3)
  void clearLedger() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get error => $_getSZ(3);
  @$pb.TagNumber(4)
  set error($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasError() => $_has(3);
  @$pb.TagNumber(4)
  void clearError() => $_clearField(4);
}

class StellarServiceApi {
  final $pb.RpcClient _client;

  StellarServiceApi(this._client);

  $async.Future<SubmitTransactionResponse> submitTransaction(
          $pb.ClientContext? ctx, SubmitTransactionRequest request) =>
      _client.invoke<SubmitTransactionResponse>(ctx, 'StellarService',
          'SubmitTransaction', request, SubmitTransactionResponse());
  $async.Future<GetTransactionResponse> getTransaction(
          $pb.ClientContext? ctx, GetTransactionRequest request) =>
      _client.invoke<GetTransactionResponse>(ctx, 'StellarService',
          'GetTransaction', request, GetTransactionResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
