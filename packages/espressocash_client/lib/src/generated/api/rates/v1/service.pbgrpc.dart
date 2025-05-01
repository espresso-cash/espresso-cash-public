//
//  Generated code. Do not modify.
//  source: api/rates/v1/service.proto
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

import 'service.pb.dart' as $0;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.rates.v1.RateService')
class RateServiceClient extends $grpc.Client {
  static final _$getRates =
      $grpc.ClientMethod<$0.GetRatesRequest, $0.GetRatesResponse>(
          '/espressocash.api.rates.v1.RateService/GetRates',
          ($0.GetRatesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetRatesResponse.fromBuffer(value));
  static final _$getFiatRates =
      $grpc.ClientMethod<$0.GetFiatRatesRequest, $0.GetFiatRatesResponse>(
          '/espressocash.api.rates.v1.RateService/GetFiatRates',
          ($0.GetFiatRatesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetFiatRatesResponse.fromBuffer(value));

  RateServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetRatesResponse> getRates($0.GetRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRates, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFiatRatesResponse> getFiatRates(
      $0.GetFiatRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFiatRates, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.rates.v1.RateService')
abstract class RateServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.rates.v1.RateService';

  RateServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetRatesRequest, $0.GetRatesResponse>(
        'GetRates',
        getRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRatesRequest.fromBuffer(value),
        ($0.GetRatesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetFiatRatesRequest, $0.GetFiatRatesResponse>(
            'GetFiatRates',
            getFiatRates_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetFiatRatesRequest.fromBuffer(value),
            ($0.GetFiatRatesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetRatesResponse> getRates_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetRatesRequest> request) async {
    return getRates(call, await request);
  }

  $async.Future<$0.GetFiatRatesResponse> getFiatRates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetFiatRatesRequest> request) async {
    return getFiatRates(call, await request);
  }

  $async.Future<$0.GetRatesResponse> getRates(
      $grpc.ServiceCall call, $0.GetRatesRequest request);
  $async.Future<$0.GetFiatRatesResponse> getFiatRates(
      $grpc.ServiceCall call, $0.GetFiatRatesRequest request);
}
