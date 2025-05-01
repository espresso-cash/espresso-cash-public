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

import 'service.pb.dart' as $6;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.moneygram.v1.MoneygramService')
class MoneygramServiceClient extends $grpc.Client {
  static final _$signChallenge =
      $grpc.ClientMethod<$6.MoneygramChallengeSignRequest, $6.MoneygramChallengeSignResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SignChallenge',
          ($6.MoneygramChallengeSignRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $6.MoneygramChallengeSignResponse.fromBuffer(value));
  static final _$swapToSolana =
      $grpc.ClientMethod<$6.SwapToSolanaRequest, $6.MoneygramSwapResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SwapToSolana',
          ($6.SwapToSolanaRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $6.MoneygramSwapResponse.fromBuffer(value));
  static final _$swapToStellar =
      $grpc.ClientMethod<$6.SwapToStellarRequest, $6.MoneygramSwapResponse>(
          '/espressocash.api.moneygram.v1.MoneygramService/SwapToStellar',
          ($6.SwapToStellarRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $6.MoneygramSwapResponse.fromBuffer(value));
  static final _$calculateFee = $grpc.ClientMethod<$6.MoneygramFeeRequest, $6.MoneygramFeeResponse>(
      '/espressocash.api.moneygram.v1.MoneygramService/CalculateFee',
      ($6.MoneygramFeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.MoneygramFeeResponse.fromBuffer(value));
  static final _$fundXlm = $grpc.ClientMethod<$6.FundXlmRequest, $6.FundXlmResponse>(
      '/espressocash.api.moneygram.v1.MoneygramService/FundXlm',
      ($6.FundXlmRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.FundXlmResponse.fromBuffer(value));

  MoneygramServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$6.MoneygramChallengeSignResponse> signChallenge(
      $6.MoneygramChallengeSignRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signChallenge, request, options: options);
  }

  $grpc.ResponseFuture<$6.MoneygramSwapResponse> swapToSolana($6.SwapToSolanaRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$swapToSolana, request, options: options);
  }

  $grpc.ResponseFuture<$6.MoneygramSwapResponse> swapToStellar($6.SwapToStellarRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$swapToStellar, request, options: options);
  }

  $grpc.ResponseFuture<$6.MoneygramFeeResponse> calculateFee($6.MoneygramFeeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateFee, request, options: options);
  }

  $grpc.ResponseFuture<$6.FundXlmResponse> fundXlm($6.FundXlmRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fundXlm, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.moneygram.v1.MoneygramService')
abstract class MoneygramServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.moneygram.v1.MoneygramService';

  MoneygramServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$6.MoneygramChallengeSignRequest, $6.MoneygramChallengeSignResponse>(
            'SignChallenge',
            signChallenge_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $6.MoneygramChallengeSignRequest.fromBuffer(value),
            ($6.MoneygramChallengeSignResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.SwapToSolanaRequest, $6.MoneygramSwapResponse>(
        'SwapToSolana',
        swapToSolana_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.SwapToSolanaRequest.fromBuffer(value),
        ($6.MoneygramSwapResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.SwapToStellarRequest, $6.MoneygramSwapResponse>(
        'SwapToStellar',
        swapToStellar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.SwapToStellarRequest.fromBuffer(value),
        ($6.MoneygramSwapResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.MoneygramFeeRequest, $6.MoneygramFeeResponse>(
        'CalculateFee',
        calculateFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.MoneygramFeeRequest.fromBuffer(value),
        ($6.MoneygramFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.FundXlmRequest, $6.FundXlmResponse>(
        'FundXlm',
        fundXlm_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.FundXlmRequest.fromBuffer(value),
        ($6.FundXlmResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.MoneygramChallengeSignResponse> signChallenge_Pre(
      $grpc.ServiceCall call, $async.Future<$6.MoneygramChallengeSignRequest> request) async {
    return signChallenge(call, await request);
  }

  $async.Future<$6.MoneygramSwapResponse> swapToSolana_Pre(
      $grpc.ServiceCall call, $async.Future<$6.SwapToSolanaRequest> request) async {
    return swapToSolana(call, await request);
  }

  $async.Future<$6.MoneygramSwapResponse> swapToStellar_Pre(
      $grpc.ServiceCall call, $async.Future<$6.SwapToStellarRequest> request) async {
    return swapToStellar(call, await request);
  }

  $async.Future<$6.MoneygramFeeResponse> calculateFee_Pre(
      $grpc.ServiceCall call, $async.Future<$6.MoneygramFeeRequest> request) async {
    return calculateFee(call, await request);
  }

  $async.Future<$6.FundXlmResponse> fundXlm_Pre(
      $grpc.ServiceCall call, $async.Future<$6.FundXlmRequest> request) async {
    return fundXlm(call, await request);
  }

  $async.Future<$6.MoneygramChallengeSignResponse> signChallenge(
      $grpc.ServiceCall call, $6.MoneygramChallengeSignRequest request);
  $async.Future<$6.MoneygramSwapResponse> swapToSolana(
      $grpc.ServiceCall call, $6.SwapToSolanaRequest request);
  $async.Future<$6.MoneygramSwapResponse> swapToStellar(
      $grpc.ServiceCall call, $6.SwapToStellarRequest request);
  $async.Future<$6.MoneygramFeeResponse> calculateFee(
      $grpc.ServiceCall call, $6.MoneygramFeeRequest request);
  $async.Future<$6.FundXlmResponse> fundXlm($grpc.ServiceCall call, $6.FundXlmRequest request);
}
