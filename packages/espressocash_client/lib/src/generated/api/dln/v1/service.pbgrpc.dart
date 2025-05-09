//
//  Generated code. Do not modify.
//  source: api/dln/v1/service.proto
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

import 'service.pb.dart' as $2;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.dln.v1.DlnService')
class DlnServiceClient extends $grpc.Client {
  static final _$getOutgoingQuote =
      $grpc.ClientMethod<$2.GetOutgoingQuoteRequest, $2.GetOutgoingQuoteResponse>(
          '/espressocash.api.dln.v1.DlnService/GetOutgoingQuote',
          ($2.GetOutgoingQuoteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.GetOutgoingQuoteResponse.fromBuffer(value));
  static final _$getIncomingQuote =
      $grpc.ClientMethod<$2.GetIncomingQuoteRequest, $2.GetIncomingQuoteResponse>(
          '/espressocash.api.dln.v1.DlnService/GetIncomingQuote',
          ($2.GetIncomingQuoteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.GetIncomingQuoteResponse.fromBuffer(value));
  static final _$getOrderId = $grpc.ClientMethod<$2.GetOrderIdRequest, $2.GetOrderIdResponse>(
      '/espressocash.api.dln.v1.DlnService/GetOrderId',
      ($2.GetOrderIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetOrderIdResponse.fromBuffer(value));
  static final _$getOrderStatus =
      $grpc.ClientMethod<$2.GetOrderStatusRequest, $2.GetOrderStatusResponse>(
          '/espressocash.api.dln.v1.DlnService/GetOrderStatus',
          ($2.GetOrderStatusRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.GetOrderStatusResponse.fromBuffer(value));
  static final _$getGasFees = $grpc.ClientMethod<$2.GetGasFeesRequest, $2.GetGasFeesResponse>(
      '/espressocash.api.dln.v1.DlnService/GetGasFees',
      ($2.GetGasFeesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetGasFeesResponse.fromBuffer(value));

  DlnServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.GetOutgoingQuoteResponse> getOutgoingQuote(
      $2.GetOutgoingQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOutgoingQuote, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetIncomingQuoteResponse> getIncomingQuote(
      $2.GetIncomingQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomingQuote, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetOrderIdResponse> getOrderId($2.GetOrderIdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderId, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetOrderStatusResponse> getOrderStatus($2.GetOrderStatusRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrderStatus, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetGasFeesResponse> getGasFees($2.GetGasFeesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getGasFees, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.dln.v1.DlnService')
abstract class DlnServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.dln.v1.DlnService';

  DlnServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.GetOutgoingQuoteRequest, $2.GetOutgoingQuoteResponse>(
        'GetOutgoingQuote',
        getOutgoingQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetOutgoingQuoteRequest.fromBuffer(value),
        ($2.GetOutgoingQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetIncomingQuoteRequest, $2.GetIncomingQuoteResponse>(
        'GetIncomingQuote',
        getIncomingQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetIncomingQuoteRequest.fromBuffer(value),
        ($2.GetIncomingQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetOrderIdRequest, $2.GetOrderIdResponse>(
        'GetOrderId',
        getOrderId_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetOrderIdRequest.fromBuffer(value),
        ($2.GetOrderIdResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetOrderStatusRequest, $2.GetOrderStatusResponse>(
        'GetOrderStatus',
        getOrderStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetOrderStatusRequest.fromBuffer(value),
        ($2.GetOrderStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetGasFeesRequest, $2.GetGasFeesResponse>(
        'GetGasFees',
        getGasFees_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetGasFeesRequest.fromBuffer(value),
        ($2.GetGasFeesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.GetOutgoingQuoteResponse> getOutgoingQuote_Pre(
      $grpc.ServiceCall call, $async.Future<$2.GetOutgoingQuoteRequest> request) async {
    return getOutgoingQuote(call, await request);
  }

  $async.Future<$2.GetIncomingQuoteResponse> getIncomingQuote_Pre(
      $grpc.ServiceCall call, $async.Future<$2.GetIncomingQuoteRequest> request) async {
    return getIncomingQuote(call, await request);
  }

  $async.Future<$2.GetOrderIdResponse> getOrderId_Pre(
      $grpc.ServiceCall call, $async.Future<$2.GetOrderIdRequest> request) async {
    return getOrderId(call, await request);
  }

  $async.Future<$2.GetOrderStatusResponse> getOrderStatus_Pre(
      $grpc.ServiceCall call, $async.Future<$2.GetOrderStatusRequest> request) async {
    return getOrderStatus(call, await request);
  }

  $async.Future<$2.GetGasFeesResponse> getGasFees_Pre(
      $grpc.ServiceCall call, $async.Future<$2.GetGasFeesRequest> request) async {
    return getGasFees(call, await request);
  }

  $async.Future<$2.GetOutgoingQuoteResponse> getOutgoingQuote(
      $grpc.ServiceCall call, $2.GetOutgoingQuoteRequest request);
  $async.Future<$2.GetIncomingQuoteResponse> getIncomingQuote(
      $grpc.ServiceCall call, $2.GetIncomingQuoteRequest request);
  $async.Future<$2.GetOrderIdResponse> getOrderId(
      $grpc.ServiceCall call, $2.GetOrderIdRequest request);
  $async.Future<$2.GetOrderStatusResponse> getOrderStatus(
      $grpc.ServiceCall call, $2.GetOrderStatusRequest request);
  $async.Future<$2.GetGasFeesResponse> getGasFees(
      $grpc.ServiceCall call, $2.GetGasFeesRequest request);
}
