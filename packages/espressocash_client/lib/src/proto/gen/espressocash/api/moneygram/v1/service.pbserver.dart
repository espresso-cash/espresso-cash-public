// This is a generated file - do not edit.
//
// Generated from espressocash/api/moneygram/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $0;
import 'service.pbjson.dart';

export 'service.pb.dart';

abstract class MoneygramServiceBase extends $pb.GeneratedService {
  $async.Future<$0.MoneygramChallengeSignResponse> signChallenge(
      $pb.ServerContext ctx, $0.MoneygramChallengeSignRequest request);
  $async.Future<$0.MoneygramSwapResponse> swapToSolana(
      $pb.ServerContext ctx, $0.SwapToSolanaRequest request);
  $async.Future<$0.MoneygramSwapResponse> swapToStellar(
      $pb.ServerContext ctx, $0.SwapToStellarRequest request);
  $async.Future<$0.MoneygramFeeResponse> calculateFee(
      $pb.ServerContext ctx, $0.MoneygramFeeRequest request);
  $async.Future<$0.FundXlmResponse> fundXlm(
      $pb.ServerContext ctx, $0.FundXlmRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'SignChallenge':
        return $0.MoneygramChallengeSignRequest();
      case 'SwapToSolana':
        return $0.SwapToSolanaRequest();
      case 'SwapToStellar':
        return $0.SwapToStellarRequest();
      case 'CalculateFee':
        return $0.MoneygramFeeRequest();
      case 'FundXlm':
        return $0.FundXlmRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'SignChallenge':
        return signChallenge(ctx, request as $0.MoneygramChallengeSignRequest);
      case 'SwapToSolana':
        return swapToSolana(ctx, request as $0.SwapToSolanaRequest);
      case 'SwapToStellar':
        return swapToStellar(ctx, request as $0.SwapToStellarRequest);
      case 'CalculateFee':
        return calculateFee(ctx, request as $0.MoneygramFeeRequest);
      case 'FundXlm':
        return fundXlm(ctx, request as $0.FundXlmRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => MoneygramServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => MoneygramServiceBase$messageJson;
}
