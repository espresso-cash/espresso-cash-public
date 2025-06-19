//
//  Generated code. Do not modify.
//  source: api/dln/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'service.pbenum.dart';

class GetOutgoingQuoteRequest extends $pb.GeneratedMessage {
  factory GetOutgoingQuoteRequest({
    $fixnum.Int64? amount,
    $core.String? receiverAddress,
    $core.String? receiverBlockchain,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (receiverAddress != null) result.receiverAddress = receiverAddress;
    if (receiverBlockchain != null) result.receiverBlockchain = receiverBlockchain;
    return result;
  }

  GetOutgoingQuoteRequest._();

  factory GetOutgoingQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOutgoingQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOutgoingQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amount')
    ..aOS(2, _omitFieldNames ? '' : 'receiverAddress')
    ..aOS(3, _omitFieldNames ? '' : 'receiverBlockchain')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOutgoingQuoteRequest clone() => GetOutgoingQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOutgoingQuoteRequest copyWith(void Function(GetOutgoingQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetOutgoingQuoteRequest))
          as GetOutgoingQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOutgoingQuoteRequest create() => GetOutgoingQuoteRequest._();
  @$core.override
  GetOutgoingQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetOutgoingQuoteRequest> createRepeated() =>
      $pb.PbList<GetOutgoingQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOutgoingQuoteRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOutgoingQuoteRequest>(create);
  static GetOutgoingQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiverAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiverAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReceiverAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiverAddress() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiverBlockchain => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiverBlockchain($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReceiverBlockchain() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiverBlockchain() => $_clearField(3);
}

class GetOutgoingQuoteResponse extends $pb.GeneratedMessage {
  factory GetOutgoingQuoteResponse({
    $fixnum.Int64? inputAmount,
    $fixnum.Int64? receiverAmount,
    $core.String? encodedTx,
    $fixnum.Int64? feeInUsdc,
    $fixnum.Int64? slot,
  }) {
    final result = create();
    if (inputAmount != null) result.inputAmount = inputAmount;
    if (receiverAmount != null) result.receiverAmount = receiverAmount;
    if (encodedTx != null) result.encodedTx = encodedTx;
    if (feeInUsdc != null) result.feeInUsdc = feeInUsdc;
    if (slot != null) result.slot = slot;
    return result;
  }

  GetOutgoingQuoteResponse._();

  factory GetOutgoingQuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOutgoingQuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOutgoingQuoteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'inputAmount')
    ..aInt64(2, _omitFieldNames ? '' : 'receiverAmount')
    ..aOS(3, _omitFieldNames ? '' : 'encodedTx')
    ..aInt64(4, _omitFieldNames ? '' : 'feeInUsdc')
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'slot', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOutgoingQuoteResponse clone() => GetOutgoingQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOutgoingQuoteResponse copyWith(void Function(GetOutgoingQuoteResponse) updates) =>
      super.copyWith((message) => updates(message as GetOutgoingQuoteResponse))
          as GetOutgoingQuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOutgoingQuoteResponse create() => GetOutgoingQuoteResponse._();
  @$core.override
  GetOutgoingQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetOutgoingQuoteResponse> createRepeated() =>
      $pb.PbList<GetOutgoingQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOutgoingQuoteResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOutgoingQuoteResponse>(create);
  static GetOutgoingQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get inputAmount => $_getI64(0);
  @$pb.TagNumber(1)
  set inputAmount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInputAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearInputAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get receiverAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set receiverAmount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReceiverAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiverAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get encodedTx => $_getSZ(2);
  @$pb.TagNumber(3)
  set encodedTx($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEncodedTx() => $_has(2);
  @$pb.TagNumber(3)
  void clearEncodedTx() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get feeInUsdc => $_getI64(3);
  @$pb.TagNumber(4)
  set feeInUsdc($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFeeInUsdc() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeInUsdc() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get slot => $_getI64(4);
  @$pb.TagNumber(5)
  set slot($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSlot() => $_has(4);
  @$pb.TagNumber(5)
  void clearSlot() => $_clearField(5);
}

class GetOrderStatusRequest extends $pb.GeneratedMessage {
  factory GetOrderStatusRequest({
    $core.String? orderId,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    return result;
  }

  GetOrderStatusRequest._();

  factory GetOrderStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderStatusRequest clone() => GetOrderStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderStatusRequest copyWith(void Function(GetOrderStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetOrderStatusRequest))
          as GetOrderStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderStatusRequest create() => GetOrderStatusRequest._();
  @$core.override
  GetOrderStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderStatusRequest> createRepeated() => $pb.PbList<GetOrderStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderStatusRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderStatusRequest>(create);
  static GetOrderStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);
}

class GetOrderStatusResponse extends $pb.GeneratedMessage {
  factory GetOrderStatusResponse({
    DlnOrderStatus? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  GetOrderStatusResponse._();

  factory GetOrderStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..e<DlnOrderStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: DlnOrderStatus.DLN_ORDER_STATUS_NONE,
        valueOf: DlnOrderStatus.valueOf,
        enumValues: DlnOrderStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderStatusResponse clone() => GetOrderStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderStatusResponse copyWith(void Function(GetOrderStatusResponse) updates) =>
      super.copyWith((message) => updates(message as GetOrderStatusResponse))
          as GetOrderStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderStatusResponse create() => GetOrderStatusResponse._();
  @$core.override
  GetOrderStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderStatusResponse> createRepeated() =>
      $pb.PbList<GetOrderStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderStatusResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderStatusResponse>(create);
  static GetOrderStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  DlnOrderStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(DlnOrderStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class GetOrderIdRequest extends $pb.GeneratedMessage {
  factory GetOrderIdRequest({
    $core.String? txId,
  }) {
    final result = create();
    if (txId != null) result.txId = txId;
    return result;
  }

  GetOrderIdRequest._();

  factory GetOrderIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderIdRequest clone() => GetOrderIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderIdRequest copyWith(void Function(GetOrderIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetOrderIdRequest)) as GetOrderIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderIdRequest create() => GetOrderIdRequest._();
  @$core.override
  GetOrderIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderIdRequest> createRepeated() => $pb.PbList<GetOrderIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderIdRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderIdRequest>(create);
  static GetOrderIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get txId => $_getSZ(0);
  @$pb.TagNumber(1)
  set txId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTxId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxId() => $_clearField(1);
}

class GetOrderIdResponse extends $pb.GeneratedMessage {
  factory GetOrderIdResponse({
    $core.String? orderId,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    return result;
  }

  GetOrderIdResponse._();

  factory GetOrderIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderIdResponse clone() => GetOrderIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderIdResponse copyWith(void Function(GetOrderIdResponse) updates) =>
      super.copyWith((message) => updates(message as GetOrderIdResponse)) as GetOrderIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderIdResponse create() => GetOrderIdResponse._();
  @$core.override
  GetOrderIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderIdResponse> createRepeated() => $pb.PbList<GetOrderIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderIdResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderIdResponse>(create);
  static GetOrderIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);
}

class GetIncomingQuoteRequest extends $pb.GeneratedMessage {
  factory GetIncomingQuoteRequest({
    $fixnum.Int64? amount,
    $core.String? senderAddress,
    $core.String? senderBlockchain,
    $core.String? receiverAddress,
    $core.String? solanaReferenceAddress,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (senderAddress != null) result.senderAddress = senderAddress;
    if (senderBlockchain != null) result.senderBlockchain = senderBlockchain;
    if (receiverAddress != null) result.receiverAddress = receiverAddress;
    if (solanaReferenceAddress != null) result.solanaReferenceAddress = solanaReferenceAddress;
    return result;
  }

  GetIncomingQuoteRequest._();

  factory GetIncomingQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomingQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomingQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amount')
    ..aOS(2, _omitFieldNames ? '' : 'senderAddress')
    ..aOS(3, _omitFieldNames ? '' : 'senderBlockchain')
    ..aOS(4, _omitFieldNames ? '' : 'receiverAddress')
    ..aOS(5, _omitFieldNames ? '' : 'solanaReferenceAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomingQuoteRequest clone() => GetIncomingQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomingQuoteRequest copyWith(void Function(GetIncomingQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetIncomingQuoteRequest))
          as GetIncomingQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomingQuoteRequest create() => GetIncomingQuoteRequest._();
  @$core.override
  GetIncomingQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetIncomingQuoteRequest> createRepeated() =>
      $pb.PbList<GetIncomingQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIncomingQuoteRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIncomingQuoteRequest>(create);
  static GetIncomingQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderAddress => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderAddress($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSenderAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderAddress() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderBlockchain => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderBlockchain($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderBlockchain() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderBlockchain() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiverAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiverAddress($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReceiverAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverAddress() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get solanaReferenceAddress => $_getSZ(4);
  @$pb.TagNumber(5)
  set solanaReferenceAddress($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSolanaReferenceAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearSolanaReferenceAddress() => $_clearField(5);
}

class GetIncomingQuoteResponse extends $pb.GeneratedMessage {
  factory GetIncomingQuoteResponse({
    QuoteTx? tx,
    QuoteUsdcInfo? usdcInfo,
    $fixnum.Int64? inputAmount,
    $fixnum.Int64? receiverAmount,
    $fixnum.Int64? feeInUsdc,
  }) {
    final result = create();
    if (tx != null) result.tx = tx;
    if (usdcInfo != null) result.usdcInfo = usdcInfo;
    if (inputAmount != null) result.inputAmount = inputAmount;
    if (receiverAmount != null) result.receiverAmount = receiverAmount;
    if (feeInUsdc != null) result.feeInUsdc = feeInUsdc;
    return result;
  }

  GetIncomingQuoteResponse._();

  factory GetIncomingQuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomingQuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomingQuoteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOM<QuoteTx>(1, _omitFieldNames ? '' : 'tx', subBuilder: QuoteTx.create)
    ..aOM<QuoteUsdcInfo>(2, _omitFieldNames ? '' : 'usdcInfo', subBuilder: QuoteUsdcInfo.create)
    ..aInt64(3, _omitFieldNames ? '' : 'inputAmount')
    ..aInt64(4, _omitFieldNames ? '' : 'receiverAmount')
    ..aInt64(5, _omitFieldNames ? '' : 'feeInUsdc')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomingQuoteResponse clone() => GetIncomingQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomingQuoteResponse copyWith(void Function(GetIncomingQuoteResponse) updates) =>
      super.copyWith((message) => updates(message as GetIncomingQuoteResponse))
          as GetIncomingQuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomingQuoteResponse create() => GetIncomingQuoteResponse._();
  @$core.override
  GetIncomingQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetIncomingQuoteResponse> createRepeated() =>
      $pb.PbList<GetIncomingQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIncomingQuoteResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIncomingQuoteResponse>(create);
  static GetIncomingQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  QuoteTx get tx => $_getN(0);
  @$pb.TagNumber(1)
  set tx(QuoteTx value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTx() => $_has(0);
  @$pb.TagNumber(1)
  void clearTx() => $_clearField(1);
  @$pb.TagNumber(1)
  QuoteTx ensureTx() => $_ensure(0);

  @$pb.TagNumber(2)
  QuoteUsdcInfo get usdcInfo => $_getN(1);
  @$pb.TagNumber(2)
  set usdcInfo(QuoteUsdcInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUsdcInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsdcInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  QuoteUsdcInfo ensureUsdcInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get inputAmount => $_getI64(2);
  @$pb.TagNumber(3)
  set inputAmount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInputAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearInputAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get receiverAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set receiverAmount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReceiverAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get feeInUsdc => $_getI64(4);
  @$pb.TagNumber(5)
  set feeInUsdc($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFeeInUsdc() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeInUsdc() => $_clearField(5);
}

class QuoteTx extends $pb.GeneratedMessage {
  factory QuoteTx({
    $core.String? to,
    $core.String? data,
    $fixnum.Int64? value,
  }) {
    final result = create();
    if (to != null) result.to = to;
    if (data != null) result.data = data;
    if (value != null) result.value = value;
    return result;
  }

  QuoteTx._();

  factory QuoteTx.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory QuoteTx.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QuoteTx',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'to')
    ..aOS(2, _omitFieldNames ? '' : 'data')
    ..aInt64(3, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteTx clone() => QuoteTx()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteTx copyWith(void Function(QuoteTx) updates) =>
      super.copyWith((message) => updates(message as QuoteTx)) as QuoteTx;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuoteTx create() => QuoteTx._();
  @$core.override
  QuoteTx createEmptyInstance() => create();
  static $pb.PbList<QuoteTx> createRepeated() => $pb.PbList<QuoteTx>();
  @$core.pragma('dart2js:noInline')
  static QuoteTx getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuoteTx>(create);
  static QuoteTx? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get to => $_getSZ(0);
  @$pb.TagNumber(1)
  set to($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTo() => $_has(0);
  @$pb.TagNumber(1)
  void clearTo() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get data => $_getSZ(1);
  @$pb.TagNumber(2)
  set data($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get value => $_getI64(2);
  @$pb.TagNumber(3)
  set value($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => $_clearField(3);
}

class QuoteUsdcInfo extends $pb.GeneratedMessage {
  factory QuoteUsdcInfo({
    $core.String? usdcAddress,
    $fixnum.Int64? approvalAmount,
  }) {
    final result = create();
    if (usdcAddress != null) result.usdcAddress = usdcAddress;
    if (approvalAmount != null) result.approvalAmount = approvalAmount;
    return result;
  }

  QuoteUsdcInfo._();

  factory QuoteUsdcInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory QuoteUsdcInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QuoteUsdcInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'usdcAddress')
    ..aInt64(2, _omitFieldNames ? '' : 'approvalAmount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteUsdcInfo clone() => QuoteUsdcInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteUsdcInfo copyWith(void Function(QuoteUsdcInfo) updates) =>
      super.copyWith((message) => updates(message as QuoteUsdcInfo)) as QuoteUsdcInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuoteUsdcInfo create() => QuoteUsdcInfo._();
  @$core.override
  QuoteUsdcInfo createEmptyInstance() => create();
  static $pb.PbList<QuoteUsdcInfo> createRepeated() => $pb.PbList<QuoteUsdcInfo>();
  @$core.pragma('dart2js:noInline')
  static QuoteUsdcInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuoteUsdcInfo>(create);
  static QuoteUsdcInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get usdcAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set usdcAddress($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsdcAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsdcAddress() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get approvalAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set approvalAmount($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasApprovalAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearApprovalAmount() => $_clearField(2);
}

class GetGasFeesRequest extends $pb.GeneratedMessage {
  factory GetGasFeesRequest({
    $core.String? network,
  }) {
    final result = create();
    if (network != null) result.network = network;
    return result;
  }

  GetGasFeesRequest._();

  factory GetGasFeesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGasFeesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGasFeesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'network')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGasFeesRequest clone() => GetGasFeesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGasFeesRequest copyWith(void Function(GetGasFeesRequest) updates) =>
      super.copyWith((message) => updates(message as GetGasFeesRequest)) as GetGasFeesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGasFeesRequest create() => GetGasFeesRequest._();
  @$core.override
  GetGasFeesRequest createEmptyInstance() => create();
  static $pb.PbList<GetGasFeesRequest> createRepeated() => $pb.PbList<GetGasFeesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGasFeesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGasFeesRequest>(create);
  static GetGasFeesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get network => $_getSZ(0);
  @$pb.TagNumber(1)
  set network($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNetwork() => $_has(0);
  @$pb.TagNumber(1)
  void clearNetwork() => $_clearField(1);
}

class GetGasFeesResponse extends $pb.GeneratedMessage {
  factory GetGasFeesResponse({
    GasFeeEstimate? low,
    GasFeeEstimate? medium,
    GasFeeEstimate? high,
    $core.String? estimatedBaseFee,
    $core.double? networkCongestion,
  }) {
    final result = create();
    if (low != null) result.low = low;
    if (medium != null) result.medium = medium;
    if (high != null) result.high = high;
    if (estimatedBaseFee != null) result.estimatedBaseFee = estimatedBaseFee;
    if (networkCongestion != null) result.networkCongestion = networkCongestion;
    return result;
  }

  GetGasFeesResponse._();

  factory GetGasFeesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetGasFeesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGasFeesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOM<GasFeeEstimate>(1, _omitFieldNames ? '' : 'low', subBuilder: GasFeeEstimate.create)
    ..aOM<GasFeeEstimate>(2, _omitFieldNames ? '' : 'medium', subBuilder: GasFeeEstimate.create)
    ..aOM<GasFeeEstimate>(3, _omitFieldNames ? '' : 'high', subBuilder: GasFeeEstimate.create)
    ..aOS(4, _omitFieldNames ? '' : 'estimatedBaseFee')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'networkCongestion', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGasFeesResponse clone() => GetGasFeesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGasFeesResponse copyWith(void Function(GetGasFeesResponse) updates) =>
      super.copyWith((message) => updates(message as GetGasFeesResponse)) as GetGasFeesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGasFeesResponse create() => GetGasFeesResponse._();
  @$core.override
  GetGasFeesResponse createEmptyInstance() => create();
  static $pb.PbList<GetGasFeesResponse> createRepeated() => $pb.PbList<GetGasFeesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGasFeesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGasFeesResponse>(create);
  static GetGasFeesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GasFeeEstimate get low => $_getN(0);
  @$pb.TagNumber(1)
  set low(GasFeeEstimate value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLow() => $_has(0);
  @$pb.TagNumber(1)
  void clearLow() => $_clearField(1);
  @$pb.TagNumber(1)
  GasFeeEstimate ensureLow() => $_ensure(0);

  @$pb.TagNumber(2)
  GasFeeEstimate get medium => $_getN(1);
  @$pb.TagNumber(2)
  set medium(GasFeeEstimate value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMedium() => $_has(1);
  @$pb.TagNumber(2)
  void clearMedium() => $_clearField(2);
  @$pb.TagNumber(2)
  GasFeeEstimate ensureMedium() => $_ensure(1);

  @$pb.TagNumber(3)
  GasFeeEstimate get high => $_getN(2);
  @$pb.TagNumber(3)
  set high(GasFeeEstimate value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasHigh() => $_has(2);
  @$pb.TagNumber(3)
  void clearHigh() => $_clearField(3);
  @$pb.TagNumber(3)
  GasFeeEstimate ensureHigh() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get estimatedBaseFee => $_getSZ(3);
  @$pb.TagNumber(4)
  set estimatedBaseFee($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEstimatedBaseFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearEstimatedBaseFee() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get networkCongestion => $_getN(4);
  @$pb.TagNumber(5)
  set networkCongestion($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNetworkCongestion() => $_has(4);
  @$pb.TagNumber(5)
  void clearNetworkCongestion() => $_clearField(5);
}

class GasFeeEstimate extends $pb.GeneratedMessage {
  factory GasFeeEstimate({
    $core.String? suggestedMaxPriorityFeePerGas,
    $core.String? suggestedMaxFeePerGas,
    $core.int? minWaitTimeEstimate,
    $core.int? maxWaitTimeEstimate,
  }) {
    final result = create();
    if (suggestedMaxPriorityFeePerGas != null)
      result.suggestedMaxPriorityFeePerGas = suggestedMaxPriorityFeePerGas;
    if (suggestedMaxFeePerGas != null) result.suggestedMaxFeePerGas = suggestedMaxFeePerGas;
    if (minWaitTimeEstimate != null) result.minWaitTimeEstimate = minWaitTimeEstimate;
    if (maxWaitTimeEstimate != null) result.maxWaitTimeEstimate = maxWaitTimeEstimate;
    return result;
  }

  GasFeeEstimate._();

  factory GasFeeEstimate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GasFeeEstimate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GasFeeEstimate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.dln.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'suggestedMaxPriorityFeePerGas')
    ..aOS(2, _omitFieldNames ? '' : 'suggestedMaxFeePerGas')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'minWaitTimeEstimate', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'maxWaitTimeEstimate', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GasFeeEstimate clone() => GasFeeEstimate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GasFeeEstimate copyWith(void Function(GasFeeEstimate) updates) =>
      super.copyWith((message) => updates(message as GasFeeEstimate)) as GasFeeEstimate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GasFeeEstimate create() => GasFeeEstimate._();
  @$core.override
  GasFeeEstimate createEmptyInstance() => create();
  static $pb.PbList<GasFeeEstimate> createRepeated() => $pb.PbList<GasFeeEstimate>();
  @$core.pragma('dart2js:noInline')
  static GasFeeEstimate getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GasFeeEstimate>(create);
  static GasFeeEstimate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get suggestedMaxPriorityFeePerGas => $_getSZ(0);
  @$pb.TagNumber(1)
  set suggestedMaxPriorityFeePerGas($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuggestedMaxPriorityFeePerGas() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuggestedMaxPriorityFeePerGas() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get suggestedMaxFeePerGas => $_getSZ(1);
  @$pb.TagNumber(2)
  set suggestedMaxFeePerGas($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuggestedMaxFeePerGas() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuggestedMaxFeePerGas() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get minWaitTimeEstimate => $_getIZ(2);
  @$pb.TagNumber(3)
  set minWaitTimeEstimate($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinWaitTimeEstimate() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinWaitTimeEstimate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get maxWaitTimeEstimate => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxWaitTimeEstimate($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxWaitTimeEstimate() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxWaitTimeEstimate() => $_clearField(4);
}

const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
