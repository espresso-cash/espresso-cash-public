//
//  Generated code. Do not modify.
//  source: api/swap/v1/service.proto
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

import 'service.pb.dart' as $5;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.swap.v1.SwapService')
class SwapServiceClient extends $grpc.Client {
  static final _$swap = $grpc.ClientMethod<$5.SwapRouteRequest, $5.SwapRouteResponse>(
      '/espressocash.api.swap.v1.SwapService/Swap',
      ($5.SwapRouteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.SwapRouteResponse.fromBuffer(value));

  SwapServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$5.SwapRouteResponse> swap($5.SwapRouteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$swap, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.swap.v1.SwapService')
abstract class SwapServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.swap.v1.SwapService';

  SwapServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.SwapRouteRequest, $5.SwapRouteResponse>(
        'Swap',
        swap_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.SwapRouteRequest.fromBuffer(value),
        ($5.SwapRouteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.SwapRouteResponse> swap_Pre(
      $grpc.ServiceCall call, $async.Future<$5.SwapRouteRequest> request) async {
    return swap(call, await request);
  }

  $async.Future<$5.SwapRouteResponse> swap($grpc.ServiceCall call, $5.SwapRouteRequest request);
}
