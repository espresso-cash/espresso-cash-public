//
//  Generated code. Do not modify.
//  source: api/moneygram/v1/service.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $1;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.moneygram.v1.MoneygramService')
class MoneygramServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$signChallenge =
      $grpc.ClientMethod<$1.MoneygramChallengeSignRequest, $1.MoneygramChallengeSignResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SignChallenge',
          ($1.MoneygramChallengeSignRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.MoneygramChallengeSignResponse.fromBuffer(value));
  static final _$swapToSolana =
      $grpc.ClientMethod<$1.SwapToSolanaRequest, $1.MoneygramSwapResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SwapToSolana',
          ($1.SwapToSolanaRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.MoneygramSwapResponse.fromBuffer(value));
  static final _$swapToStellar =
      $grpc.ClientMethod<$1.SwapToStellarRequest, $1.MoneygramSwapResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SwapToStellar',
          ($1.SwapToStellarRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.MoneygramSwapResponse.fromBuffer(value));
  static final _$calculateFee = $grpc.ClientMethod<$1.MoneygramFeeRequest, $1.MoneygramFeeResponse>(
      '/espressocash.api.moneygram.v1.MoneygramService/CalculateFee',
      ($1.MoneygramFeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.MoneygramFeeResponse.fromBuffer(value));
  static final _$fundXlm = $grpc.ClientMethod<$1.FundXlmRequest, $1.FundXlmResponse>(
      '/espressocash.api.moneygram.v1.MoneygramService/FundXlm',
      ($1.FundXlmRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.FundXlmResponse.fromBuffer(value));

  MoneygramServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$1.MoneygramChallengeSignResponse> signChallenge(
      $1.MoneygramChallengeSignRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signChallenge, request, options: options);
  }

  $grpc.ResponseFuture<$1.MoneygramSwapResponse> swapToSolana($1.SwapToSolanaRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$swapToSolana, request, options: options);
  }

  $grpc.ResponseFuture<$1.MoneygramSwapResponse> swapToStellar($1.SwapToStellarRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$swapToStellar, request, options: options);
  }

  $grpc.ResponseFuture<$1.MoneygramFeeResponse> calculateFee($1.MoneygramFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateFee, request, options: options);
  }

  $grpc.ResponseFuture<$1.FundXlmResponse> fundXlm($1.FundXlmRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fundXlm, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.moneygram.v1.MoneygramService')
abstract class MoneygramServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.moneygram.v1.MoneygramService';

  MoneygramServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$1.MoneygramChallengeSignRequest, $1.MoneygramChallengeSignResponse>(
            'SignChallenge',
            signChallenge_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $1.MoneygramChallengeSignRequest.fromBuffer(value),
            ($1.MoneygramChallengeSignResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.MoneygramChallengeSignRequest, $1.MoneygramChallengeSignResponse>(
            'SignChallenge',
            signChallenge_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $1.MoneygramChallengeSignRequest.fromBuffer(value),
            ($1.MoneygramChallengeSignResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SwapToSolanaRequest, $1.MoneygramSwapResponse>(
        'SwapToSolana',
        swapToSolana_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SwapToSolanaRequest.fromBuffer(value),
        ($1.MoneygramSwapResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SwapToStellarRequest, $1.MoneygramSwapResponse>(
        'SwapToStellar',
        swapToStellar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SwapToStellarRequest.fromBuffer(value),
        ($1.MoneygramSwapResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MoneygramFeeRequest, $1.MoneygramFeeResponse>(
        'CalculateFee',
        calculateFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.MoneygramFeeRequest.fromBuffer(value),
        ($1.MoneygramFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FundXlmRequest, $1.FundXlmResponse>(
        'FundXlm',
        fundXlm_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.FundXlmRequest.fromBuffer(value),
        ($1.FundXlmResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.MoneygramChallengeSignResponse> signChallenge_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.MoneygramChallengeSignRequest> $request) async {
    return signChallenge($call, await $request);
  }

  $async.Future<$1.MoneygramSwapResponse> swapToSolana_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.SwapToSolanaRequest> $request) async {
    return swapToSolana($call, await $request);
  }

  $async.Future<$1.MoneygramSwapResponse> swapToStellar_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.SwapToStellarRequest> $request) async {
    return swapToStellar($call, await $request);
  }

  $async.Future<$1.MoneygramFeeResponse> calculateFee_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.MoneygramFeeRequest> $request) async {
    return calculateFee($call, await $request);
  }

  $async.Future<$1.FundXlmResponse> fundXlm_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.FundXlmRequest> $request) async {
    return fundXlm($call, await $request);
  }

  $async.Future<$1.MoneygramChallengeSignResponse> signChallenge(
      $grpc.ServiceCall call, $1.MoneygramChallengeSignRequest request);
  $async.Future<$1.MoneygramSwapResponse> swapToSolana(
      $grpc.ServiceCall call, $1.SwapToSolanaRequest request);
  $async.Future<$1.MoneygramSwapResponse> swapToStellar(
      $grpc.ServiceCall call, $1.SwapToStellarRequest request);
  $async.Future<$1.MoneygramFeeResponse> calculateFee(
      $grpc.ServiceCall call, $1.MoneygramFeeRequest request);
  $async.Future<$1.FundXlmResponse> fundXlm($grpc.ServiceCall call, $1.FundXlmRequest request);
}
