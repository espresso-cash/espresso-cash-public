//
//  Generated code. Do not modify.
//  source: api/dln/v1/service.proto
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

import 'service.pb.dart' as $0;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.dln.v1.DlnService')
class DlnServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$getOutgoingQuote =
      $grpc.ClientMethod<$0.GetOutgoingQuoteRequest, $0.GetOutgoingQuoteResponse>(
          '/espressocash.api.dln.v1.DlnService/GetOutgoingQuote',
          ($0.GetOutgoingQuoteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.GetOutgoingQuoteResponse.fromBuffer(value));
  static final _$getIncomingQuote =
      $grpc.ClientMethod<$0.GetIncomingQuoteRequest, $0.GetIncomingQuoteResponse>(
          '/espressocash.api.dln.v1.DlnService/GetIncomingQuote',
          ($0.GetIncomingQuoteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.GetIncomingQuoteResponse.fromBuffer(value));
  static final _$getOrderId = $grpc.ClientMethod<$0.GetOrderIdRequest, $0.GetOrderIdResponse>(
      '/espressocash.api.dln.v1.DlnService/GetOrderId',
      ($0.GetOrderIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetOrderIdResponse.fromBuffer(value));
  static final _$getOrderStatus =
      $grpc.ClientMethod<$0.GetOrderStatusRequest, $0.GetOrderStatusResponse>(
          '/espressocash.api.dln.v1.DlnService/GetOrderStatus',
          ($0.GetOrderStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.GetOrderStatusResponse.fromBuffer(value));
  static final _$getGasFees = $grpc.ClientMethod<$0.GetGasFeesRequest, $0.GetGasFeesResponse>(
      '/espressocash.api.dln.v1.DlnService/GetGasFees',
      ($0.GetGasFeesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetGasFeesResponse.fromBuffer(value));

  DlnServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetOutgoingQuoteResponse> getOutgoingQuote(
      $0.GetOutgoingQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOutgoingQuote, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetIncomingQuoteResponse> getIncomingQuote(
      $0.GetIncomingQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomingQuote, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOrderIdResponse> getOrderId($0.GetOrderIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderId, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetOrderStatusResponse> getOrderStatus($0.GetOrderStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetGasFeesResponse> getGasFees($0.GetGasFeesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGasFees, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.dln.v1.DlnService')
abstract class DlnServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.dln.v1.DlnService';

  DlnServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetOutgoingQuoteRequest, $0.GetOutgoingQuoteResponse>(
        'GetOutgoingQuote',
        getOutgoingQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOutgoingQuoteRequest.fromBuffer(value),
        ($0.GetOutgoingQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetIncomingQuoteRequest, $0.GetIncomingQuoteResponse>(
        'GetIncomingQuote',
        getIncomingQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetIncomingQuoteRequest.fromBuffer(value),
        ($0.GetIncomingQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOrderIdRequest, $0.GetOrderIdResponse>(
        'GetOrderId',
        getOrderId_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOrderIdRequest.fromBuffer(value),
        ($0.GetOrderIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetOrderStatusRequest, $0.GetOrderStatusResponse>(
        'GetOrderStatus',
        getOrderStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetOrderStatusRequest.fromBuffer(value),
        ($0.GetOrderStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetGasFeesRequest, $0.GetGasFeesResponse>(
        'GetGasFees',
        getGasFees_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetGasFeesRequest.fromBuffer(value),
        ($0.GetGasFeesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetOutgoingQuoteResponse> getOutgoingQuote_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.GetOutgoingQuoteRequest> $request) async {
    return getOutgoingQuote($call, await $request);
  }

  $async.Future<$0.GetIncomingQuoteResponse> getIncomingQuote_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.GetIncomingQuoteRequest> $request) async {
    return getIncomingQuote($call, await $request);
  }

  $async.Future<$0.GetOrderIdResponse> getOrderId_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.GetOrderIdRequest> $request) async {
    return getOrderId($call, await $request);
  }

  $async.Future<$0.GetOrderStatusResponse> getOrderStatus_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.GetOrderStatusRequest> $request) async {
    return getOrderStatus($call, await $request);
  }

  $async.Future<$0.GetGasFeesResponse> getGasFees_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.GetGasFeesRequest> $request) async {
    return getGasFees($call, await $request);
  }

  $async.Future<$0.GetOutgoingQuoteResponse> getOutgoingQuote(
      $grpc.ServiceCall call, $0.GetOutgoingQuoteRequest request);
  $async.Future<$0.GetIncomingQuoteResponse> getIncomingQuote(
      $grpc.ServiceCall call, $0.GetIncomingQuoteRequest request);
  $async.Future<$0.GetOrderIdResponse> getOrderId(
      $grpc.ServiceCall call, $0.GetOrderIdRequest request);
  $async.Future<$0.GetOrderStatusResponse> getOrderStatus(
      $grpc.ServiceCall call, $0.GetOrderStatusRequest request);
  $async.Future<$0.GetGasFeesResponse> getGasFees(
      $grpc.ServiceCall call, $0.GetGasFeesRequest request);
}
