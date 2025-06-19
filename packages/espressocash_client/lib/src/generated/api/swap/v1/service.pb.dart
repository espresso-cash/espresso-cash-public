//
//  Generated code. Do not modify.
//  source: api/swap/v1/service.proto
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

class SwapRouteRequest extends $pb.GeneratedMessage {
  factory SwapRouteRequest({
    $core.String? inputToken,
    $core.String? outputToken,
    $core.String? amount,
    SwapMatch? match,
    SwapSlippage? slippage,
  }) {
    final result = create();
    if (inputToken != null) result.inputToken = inputToken;
    if (outputToken != null) result.outputToken = outputToken;
    if (amount != null) result.amount = amount;
    if (match != null) result.match = match;
    if (slippage != null) result.slippage = slippage;
    return result;
  }

  SwapRouteRequest._();

  factory SwapRouteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SwapRouteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SwapRouteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.swap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'inputToken')
    ..aOS(2, _omitFieldNames ? '' : 'outputToken')
    ..aOS(3, _omitFieldNames ? '' : 'amount')
    ..e<SwapMatch>(4, _omitFieldNames ? '' : 'match', $pb.PbFieldType.OE,
        defaultOrMaker: SwapMatch.SWAP_MATCH_UNSPECIFIED,
        valueOf: SwapMatch.valueOf,
        enumValues: SwapMatch.values)
    ..e<SwapSlippage>(5, _omitFieldNames ? '' : 'slippage', $pb.PbFieldType.OE,
        defaultOrMaker: SwapSlippage.SWAP_SLIPPAGE_UNSPECIFIED,
        valueOf: SwapSlippage.valueOf,
        enumValues: SwapSlippage.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SwapRouteRequest clone() => SwapRouteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SwapRouteRequest copyWith(void Function(SwapRouteRequest) updates) =>
      super.copyWith((message) => updates(message as SwapRouteRequest)) as SwapRouteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SwapRouteRequest create() => SwapRouteRequest._();
  @$core.override
  SwapRouteRequest createEmptyInstance() => create();
  static $pb.PbList<SwapRouteRequest> createRepeated() => $pb.PbList<SwapRouteRequest>();
  @$core.pragma('dart2js:noInline')
  static SwapRouteRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SwapRouteRequest>(create);
  static SwapRouteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get inputToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set inputToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInputToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInputToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get outputToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set outputToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOutputToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutputToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get amount => $_getSZ(2);
  @$pb.TagNumber(3)
  set amount($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  SwapMatch get match => $_getN(3);
  @$pb.TagNumber(4)
  set match(SwapMatch value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMatch() => $_has(3);
  @$pb.TagNumber(4)
  void clearMatch() => $_clearField(4);

  @$pb.TagNumber(5)
  SwapSlippage get slippage => $_getN(4);
  @$pb.TagNumber(5)
  set slippage(SwapSlippage value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSlippage() => $_has(4);
  @$pb.TagNumber(5)
  void clearSlippage() => $_clearField(5);
}

class SwapRouteResponse extends $pb.GeneratedMessage {
  factory SwapRouteResponse({
    $core.String? inAmount,
    $core.String? outAmount,
    $core.String? amount,
    $core.String? encodedTx,
    $core.int? feeInUsdc,
    $fixnum.Int64? slot,
    $core.int? slippageBps,
    $core.int? platformFeeBps,
    $core.String? priceImpact,
    $core.String? providerLabel,
  }) {
    final result = create();
    if (inAmount != null) result.inAmount = inAmount;
    if (outAmount != null) result.outAmount = outAmount;
    if (amount != null) result.amount = amount;
    if (encodedTx != null) result.encodedTx = encodedTx;
    if (feeInUsdc != null) result.feeInUsdc = feeInUsdc;
    if (slot != null) result.slot = slot;
    if (slippageBps != null) result.slippageBps = slippageBps;
    if (platformFeeBps != null) result.platformFeeBps = platformFeeBps;
    if (priceImpact != null) result.priceImpact = priceImpact;
    if (providerLabel != null) result.providerLabel = providerLabel;
    return result;
  }

  SwapRouteResponse._();

  factory SwapRouteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SwapRouteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SwapRouteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.swap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'inAmount')
    ..aOS(2, _omitFieldNames ? '' : 'outAmount')
    ..aOS(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'encodedTx')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'feeInUsdc', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'slot')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'slippageBps', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'platformFeeBps', $pb.PbFieldType.O3)
    ..aOS(9, _omitFieldNames ? '' : 'priceImpact')
    ..aOS(10, _omitFieldNames ? '' : 'providerLabel')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SwapRouteResponse clone() => SwapRouteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SwapRouteResponse copyWith(void Function(SwapRouteResponse) updates) =>
      super.copyWith((message) => updates(message as SwapRouteResponse)) as SwapRouteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SwapRouteResponse create() => SwapRouteResponse._();
  @$core.override
  SwapRouteResponse createEmptyInstance() => create();
  static $pb.PbList<SwapRouteResponse> createRepeated() => $pb.PbList<SwapRouteResponse>();
  @$core.pragma('dart2js:noInline')
  static SwapRouteResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SwapRouteResponse>(create);
  static SwapRouteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get inAmount => $_getSZ(0);
  @$pb.TagNumber(1)
  set inAmount($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearInAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get outAmount => $_getSZ(1);
  @$pb.TagNumber(2)
  set outAmount($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOutAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get amount => $_getSZ(2);
  @$pb.TagNumber(3)
  set amount($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get encodedTx => $_getSZ(3);
  @$pb.TagNumber(4)
  set encodedTx($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEncodedTx() => $_has(3);
  @$pb.TagNumber(4)
  void clearEncodedTx() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get feeInUsdc => $_getIZ(4);
  @$pb.TagNumber(5)
  set feeInUsdc($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFeeInUsdc() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeInUsdc() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get slot => $_getI64(5);
  @$pb.TagNumber(6)
  set slot($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSlot() => $_has(5);
  @$pb.TagNumber(6)
  void clearSlot() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get slippageBps => $_getIZ(6);
  @$pb.TagNumber(7)
  set slippageBps($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSlippageBps() => $_has(6);
  @$pb.TagNumber(7)
  void clearSlippageBps() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get platformFeeBps => $_getIZ(7);
  @$pb.TagNumber(8)
  set platformFeeBps($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPlatformFeeBps() => $_has(7);
  @$pb.TagNumber(8)
  void clearPlatformFeeBps() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get priceImpact => $_getSZ(8);
  @$pb.TagNumber(9)
  set priceImpact($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPriceImpact() => $_has(8);
  @$pb.TagNumber(9)
  void clearPriceImpact() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get providerLabel => $_getSZ(9);
  @$pb.TagNumber(10)
  set providerLabel($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProviderLabel() => $_has(9);
  @$pb.TagNumber(10)
  void clearProviderLabel() => $_clearField(10);
}

const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
