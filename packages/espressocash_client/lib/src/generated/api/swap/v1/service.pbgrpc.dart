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

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $6;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.swap.v1.SwapService')
class SwapServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$swap = $grpc.ClientMethod<$6.SwapRouteRequest, $6.SwapRouteResponse>(
      '/espressocash.api.swap.v1.SwapService/Swap',
      ($6.SwapRouteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $6.SwapRouteResponse.fromBuffer(value));

  SwapServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$6.SwapRouteResponse> swap($6.SwapRouteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$swap, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.swap.v1.SwapService')
abstract class SwapServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.swap.v1.SwapService';

  SwapServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.SwapRouteRequest, $6.SwapRouteResponse>(
        'Swap',
        swap_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.SwapRouteRequest.fromBuffer(value),
        ($6.SwapRouteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$6.SwapRouteResponse> swap_Pre(
      $grpc.ServiceCall $call, $async.Future<$6.SwapRouteRequest> $request) async {
    return swap($call, await $request);
  }

  $async.Future<$6.SwapRouteResponse> swap($grpc.ServiceCall call, $6.SwapRouteRequest request);
}
