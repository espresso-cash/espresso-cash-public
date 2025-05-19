//
//  Generated code. Do not modify.
//  source: api/moneygram/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $7;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.moneygram.v1.MoneygramService')
class MoneygramServiceClient extends $grpc.Client {
  static final _$signChallenge =
      $grpc.ClientMethod<$7.MoneygramChallengeSignRequest, $7.MoneygramChallengeSignResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SignChallenge',
          ($7.MoneygramChallengeSignRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.MoneygramChallengeSignResponse.fromBuffer(value));
  static final _$swapToSolana =
      $grpc.ClientMethod<$7.SwapToSolanaRequest, $7.MoneygramSwapResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SwapToSolana',
          ($7.SwapToSolanaRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.MoneygramSwapResponse.fromBuffer(value));
  static final _$swapToStellar =
      $grpc.ClientMethod<$7.SwapToStellarRequest, $7.MoneygramSwapResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SwapToStellar',
          ($7.SwapToStellarRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $7.MoneygramSwapResponse.fromBuffer(value));
  static final _$calculateFee = $grpc.ClientMethod<$7.MoneygramFeeRequest, $7.MoneygramFeeResponse>(
      '/espressocash.api.moneygram.v1.MoneygramService/CalculateFee',
      ($7.MoneygramFeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.MoneygramFeeResponse.fromBuffer(value));
  static final _$fundXlm = $grpc.ClientMethod<$7.FundXlmRequest, $7.FundXlmResponse>(
      '/espressocash.api.moneygram.v1.MoneygramService/FundXlm',
      ($7.FundXlmRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.FundXlmResponse.fromBuffer(value));

  MoneygramServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$7.MoneygramChallengeSignResponse> signChallenge(
      $7.MoneygramChallengeSignRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signChallenge, request, options: options);
  }

  $grpc.ResponseFuture<$7.MoneygramSwapResponse> swapToSolana($7.SwapToSolanaRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$swapToSolana, request, options: options);
  }

  $grpc.ResponseFuture<$7.MoneygramSwapResponse> swapToStellar($7.SwapToStellarRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$swapToStellar, request, options: options);
  }

  $grpc.ResponseFuture<$7.MoneygramFeeResponse> calculateFee($7.MoneygramFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateFee, request, options: options);
  }

  $grpc.ResponseFuture<$7.FundXlmResponse> fundXlm($7.FundXlmRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fundXlm, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.moneygram.v1.MoneygramService')
abstract class MoneygramServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.moneygram.v1.MoneygramService';

  MoneygramServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$7.MoneygramChallengeSignRequest, $7.MoneygramChallengeSignResponse>(
            'SignChallenge',
            signChallenge_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $7.MoneygramChallengeSignRequest.fromBuffer(value),
            ($7.MoneygramChallengeSignResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.SwapToSolanaRequest, $7.MoneygramSwapResponse>(
        'SwapToSolana',
        swapToSolana_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.SwapToSolanaRequest.fromBuffer(value),
        ($7.MoneygramSwapResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.SwapToStellarRequest, $7.MoneygramSwapResponse>(
        'SwapToStellar',
        swapToStellar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.SwapToStellarRequest.fromBuffer(value),
        ($7.MoneygramSwapResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.MoneygramFeeRequest, $7.MoneygramFeeResponse>(
        'CalculateFee',
        calculateFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.MoneygramFeeRequest.fromBuffer(value),
        ($7.MoneygramFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.FundXlmRequest, $7.FundXlmResponse>(
        'FundXlm',
        fundXlm_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.FundXlmRequest.fromBuffer(value),
        ($7.FundXlmResponse value) => value.writeToBuffer()));
  }

  $async.Future<$7.MoneygramChallengeSignResponse> signChallenge_Pre(
      $grpc.ServiceCall call, $async.Future<$7.MoneygramChallengeSignRequest> request) async {
    return signChallenge(call, await request);
  }

  $async.Future<$7.MoneygramSwapResponse> swapToSolana_Pre(
      $grpc.ServiceCall call, $async.Future<$7.SwapToSolanaRequest> request) async {
    return swapToSolana(call, await request);
  }

  $async.Future<$7.MoneygramSwapResponse> swapToStellar_Pre(
      $grpc.ServiceCall call, $async.Future<$7.SwapToStellarRequest> request) async {
    return swapToStellar(call, await request);
  }

  $async.Future<$7.MoneygramFeeResponse> calculateFee_Pre(
      $grpc.ServiceCall call, $async.Future<$7.MoneygramFeeRequest> request) async {
    return calculateFee(call, await request);
  }

  $async.Future<$7.FundXlmResponse> fundXlm_Pre(
      $grpc.ServiceCall call, $async.Future<$7.FundXlmRequest> request) async {
    return fundXlm(call, await request);
  }

  $async.Future<$7.MoneygramChallengeSignResponse> signChallenge(
      $grpc.ServiceCall call, $7.MoneygramChallengeSignRequest request);
  $async.Future<$7.MoneygramSwapResponse> swapToSolana(
      $grpc.ServiceCall call, $7.SwapToSolanaRequest request);
  $async.Future<$7.MoneygramSwapResponse> swapToStellar(
      $grpc.ServiceCall call, $7.SwapToStellarRequest request);
  $async.Future<$7.MoneygramFeeResponse> calculateFee(
      $grpc.ServiceCall call, $7.MoneygramFeeRequest request);
  $async.Future<$7.FundXlmResponse> fundXlm($grpc.ServiceCall call, $7.FundXlmRequest request);
}
