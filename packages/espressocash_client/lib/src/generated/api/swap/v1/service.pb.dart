//
//  Generated code. Do not modify.
//  source: api/swap/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pbenum.dart';

export 'service.pbenum.dart';

class SwapRouteRequest extends $pb.GeneratedMessage {
  factory SwapRouteRequest({
    $core.String? inputToken,
    $core.String? outputToken,
    $core.String? amount,
    SwapMatch? match,
    SwapSlippage? slippage,
  }) {
    final $result = create();
    if (inputToken != null) {
      $result.inputToken = inputToken;
    }
    if (outputToken != null) {
      $result.outputToken = outputToken;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (match != null) {
      $result.match = match;
    }
    if (slippage != null) {
      $result.slippage = slippage;
    }
    return $result;
  }
  SwapRouteRequest._() : super();
  factory SwapRouteRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SwapRouteRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

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

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SwapRouteRequest clone() => SwapRouteRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SwapRouteRequest copyWith(void Function(SwapRouteRequest) updates) =>
      super.copyWith((message) => updates(message as SwapRouteRequest)) as SwapRouteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SwapRouteRequest create() => SwapRouteRequest._();
  SwapRouteRequest createEmptyInstance() => create();
  static $pb.PbList<SwapRouteRequest> createRepeated() => $pb.PbList<SwapRouteRequest>();
  @$core.pragma('dart2js:noInline')
  static SwapRouteRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SwapRouteRequest>(create);
  static SwapRouteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get inputToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set inputToken($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasInputToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInputToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get outputToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set outputToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOutputToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutputToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get amount => $_getSZ(2);
  @$pb.TagNumber(3)
  set amount($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  SwapMatch get match => $_getN(3);
  @$pb.TagNumber(4)
  set match(SwapMatch v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMatch() => $_has(3);
  @$pb.TagNumber(4)
  void clearMatch() => clearField(4);

  @$pb.TagNumber(5)
  SwapSlippage get slippage => $_getN(4);
  @$pb.TagNumber(5)
  set slippage(SwapSlippage v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSlippage() => $_has(4);
  @$pb.TagNumber(5)
  void clearSlippage() => clearField(5);
}

class SwapRouteResponse extends $pb.GeneratedMessage {
  factory SwapRouteResponse({
    $core.String? inAmount,
    $core.String? outAmount,
    $core.String? amount,
    $core.String? encodedTx,
    $core.int? feeInUsdc,
    $fixnum.Int64? slot,
  }) {
    final $result = create();
    if (inAmount != null) {
      $result.inAmount = inAmount;
    }
    if (outAmount != null) {
      $result.outAmount = outAmount;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (encodedTx != null) {
      $result.encodedTx = encodedTx;
    }
    if (feeInUsdc != null) {
      $result.feeInUsdc = feeInUsdc;
    }
    if (slot != null) {
      $result.slot = slot;
    }
    return $result;
  }
  SwapRouteResponse._() : super();
  factory SwapRouteResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SwapRouteResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SwapRouteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'espressocash.api.swap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'inAmount')
    ..aOS(2, _omitFieldNames ? '' : 'outAmount')
    ..aOS(3, _omitFieldNames ? '' : 'amount')
    ..aOS(4, _omitFieldNames ? '' : 'encodedTx')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'feeInUsdc', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'slot')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SwapRouteResponse clone() => SwapRouteResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SwapRouteResponse copyWith(void Function(SwapRouteResponse) updates) =>
      super.copyWith((message) => updates(message as SwapRouteResponse)) as SwapRouteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SwapRouteResponse create() => SwapRouteResponse._();
  SwapRouteResponse createEmptyInstance() => create();
  static $pb.PbList<SwapRouteResponse> createRepeated() => $pb.PbList<SwapRouteResponse>();
  @$core.pragma('dart2js:noInline')
  static SwapRouteResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SwapRouteResponse>(create);
  static SwapRouteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get inAmount => $_getSZ(0);
  @$pb.TagNumber(1)
  set inAmount($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasInAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearInAmount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get outAmount => $_getSZ(1);
  @$pb.TagNumber(2)
  set outAmount($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOutAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get amount => $_getSZ(2);
  @$pb.TagNumber(3)
  set amount($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get encodedTx => $_getSZ(3);
  @$pb.TagNumber(4)
  set encodedTx($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasEncodedTx() => $_has(3);
  @$pb.TagNumber(4)
  void clearEncodedTx() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get feeInUsdc => $_getIZ(4);
  @$pb.TagNumber(5)
  set feeInUsdc($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasFeeInUsdc() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeInUsdc() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get slot => $_getI64(5);
  @$pb.TagNumber(6)
  set slot($fixnum.Int64 v) {
    $_setInt64(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSlot() => $_has(5);
  @$pb.TagNumber(6)
  void clearSlot() => clearField(6);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
