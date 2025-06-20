//
//  Generated code. Do not modify.
//  source: api/rates/v1/service.proto
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

import 'service.pb.dart' as $3;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.rates.v1.RateService')
class RateServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$getRates = $grpc.ClientMethod<$3.GetRatesRequest, $3.GetRatesResponse>(
      '/espressocash.api.rates.v1.RateService/GetRates',
      ($3.GetRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetRatesResponse.fromBuffer(value));
  static final _$getFiatRates = $grpc.ClientMethod<$3.GetFiatRatesRequest, $3.GetFiatRatesResponse>(
      '/espressocash.api.rates.v1.RateService/GetFiatRates',
      ($3.GetFiatRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.GetFiatRatesResponse.fromBuffer(value));

  RateServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$3.GetRatesResponse> getRates($3.GetRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRates, request, options: options);
  }

  $grpc.ResponseFuture<$3.GetFiatRatesResponse> getFiatRates($3.GetFiatRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFiatRates, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.rates.v1.RateService')
abstract class RateServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.rates.v1.RateService';

  RateServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.GetRatesRequest, $3.GetRatesResponse>(
        'GetRates',
        getRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetRatesRequest.fromBuffer(value),
        ($3.GetRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.GetFiatRatesRequest, $3.GetFiatRatesResponse>(
        'GetFiatRates',
        getFiatRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.GetFiatRatesRequest.fromBuffer(value),
        ($3.GetFiatRatesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$3.GetRatesResponse> getRates_Pre(
      $grpc.ServiceCall $call, $async.Future<$3.GetRatesRequest> $request) async {
    return getRates($call, await $request);
  }

  $async.Future<$3.GetFiatRatesResponse> getFiatRates_Pre(
      $grpc.ServiceCall $call, $async.Future<$3.GetFiatRatesRequest> $request) async {
    return getFiatRates($call, await $request);
  }

  $async.Future<$3.GetRatesResponse> getRates($grpc.ServiceCall call, $3.GetRatesRequest request);
  $async.Future<$3.GetFiatRatesResponse> getFiatRates(
      $grpc.ServiceCall call, $3.GetFiatRatesRequest request);
}
