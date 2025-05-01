//
//  Generated code. Do not modify.
//  source: api/payments/v1/service.proto
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

import 'service.pb.dart' as $1;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.payments.v1.PaymentService')
class PaymentServiceClient extends $grpc.Client {
  static final _$createDirectPayment = $grpc.ClientMethod<
          $1.CreateDirectPaymentRequest, $1.CreateDirectPaymentResponse>(
      '/espressocash.api.payments.v1.PaymentService/CreateDirectPayment',
      ($1.CreateDirectPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateDirectPaymentResponse.fromBuffer(value));
  static final _$getDirectPaymentQuote = $grpc.ClientMethod<
          $1.GetDirectPaymentQuoteRequest, $1.GetDirectPaymentQuoteResponse>(
      '/espressocash.api.payments.v1.PaymentService/GetDirectPaymentQuote',
      ($1.GetDirectPaymentQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetDirectPaymentQuoteResponse.fromBuffer(value));
  static final _$createEscrowPayment = $grpc.ClientMethod<
          $1.CreateEscrowPaymentRequest, $1.CreateEscrowPaymentResponse>(
      '/espressocash.api.payments.v1.PaymentService/CreateEscrowPayment',
      ($1.CreateEscrowPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateEscrowPaymentResponse.fromBuffer(value));
  static final _$receiveEscrowPayment = $grpc.ClientMethod<
          $1.ReceiveEscrowPaymentRequest, $1.ReceiveEscrowPaymentResponse>(
      '/espressocash.api.payments.v1.PaymentService/ReceiveEscrowPayment',
      ($1.ReceiveEscrowPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ReceiveEscrowPaymentResponse.fromBuffer(value));
  static final _$cancelEscrowPayment = $grpc.ClientMethod<
          $1.CancelEscrowPaymentRequest, $1.CancelEscrowPaymentResponse>(
      '/espressocash.api.payments.v1.PaymentService/CancelEscrowPayment',
      ($1.CancelEscrowPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CancelEscrowPaymentResponse.fromBuffer(value));
  static final _$getOutgoingEscrowPaymentQuote = $grpc.ClientMethod<
          $1.GetOutgoingEscrowPaymentQuoteRequest,
          $1.GetOutgoingEscrowPaymentQuoteResponse>(
      '/espressocash.api.payments.v1.PaymentService/GetOutgoingEscrowPaymentQuote',
      ($1.GetOutgoingEscrowPaymentQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetOutgoingEscrowPaymentQuoteResponse.fromBuffer(value));
  static final _$getIncomingEscrowPaymentQuote = $grpc.ClientMethod<
          $1.GetIncomingEscrowPaymentQuoteRequest,
          $1.GetIncomingEscrowPaymentQuoteResponse>(
      '/espressocash.api.payments.v1.PaymentService/GetIncomingEscrowPaymentQuote',
      ($1.GetIncomingEscrowPaymentQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetIncomingEscrowPaymentQuoteResponse.fromBuffer(value));

  PaymentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.CreateDirectPaymentResponse> createDirectPayment(
      $1.CreateDirectPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDirectPayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetDirectPaymentQuoteResponse> getDirectPaymentQuote(
      $1.GetDirectPaymentQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDirectPaymentQuote, request, options: options);
  }

  $grpc.ResponseFuture<$1.CreateEscrowPaymentResponse> createEscrowPayment(
      $1.CreateEscrowPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createEscrowPayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.ReceiveEscrowPaymentResponse> receiveEscrowPayment(
      $1.ReceiveEscrowPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$receiveEscrowPayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.CancelEscrowPaymentResponse> cancelEscrowPayment(
      $1.CancelEscrowPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelEscrowPayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetOutgoingEscrowPaymentQuoteResponse>
      getOutgoingEscrowPaymentQuote(
          $1.GetOutgoingEscrowPaymentQuoteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOutgoingEscrowPaymentQuote, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetIncomingEscrowPaymentQuoteResponse>
      getIncomingEscrowPaymentQuote(
          $1.GetIncomingEscrowPaymentQuoteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomingEscrowPaymentQuote, request,
        options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.payments.v1.PaymentService')
abstract class PaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.payments.v1.PaymentService';

  PaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.CreateDirectPaymentRequest,
            $1.CreateDirectPaymentResponse>(
        'CreateDirectPayment',
        createDirectPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateDirectPaymentRequest.fromBuffer(value),
        ($1.CreateDirectPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetDirectPaymentQuoteRequest,
            $1.GetDirectPaymentQuoteResponse>(
        'GetDirectPaymentQuote',
        getDirectPaymentQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetDirectPaymentQuoteRequest.fromBuffer(value),
        ($1.GetDirectPaymentQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateEscrowPaymentRequest,
            $1.CreateEscrowPaymentResponse>(
        'CreateEscrowPayment',
        createEscrowPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateEscrowPaymentRequest.fromBuffer(value),
        ($1.CreateEscrowPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ReceiveEscrowPaymentRequest,
            $1.ReceiveEscrowPaymentResponse>(
        'ReceiveEscrowPayment',
        receiveEscrowPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ReceiveEscrowPaymentRequest.fromBuffer(value),
        ($1.ReceiveEscrowPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CancelEscrowPaymentRequest,
            $1.CancelEscrowPaymentResponse>(
        'CancelEscrowPayment',
        cancelEscrowPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CancelEscrowPaymentRequest.fromBuffer(value),
        ($1.CancelEscrowPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetOutgoingEscrowPaymentQuoteRequest,
            $1.GetOutgoingEscrowPaymentQuoteResponse>(
        'GetOutgoingEscrowPaymentQuote',
        getOutgoingEscrowPaymentQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetOutgoingEscrowPaymentQuoteRequest.fromBuffer(value),
        ($1.GetOutgoingEscrowPaymentQuoteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetIncomingEscrowPaymentQuoteRequest,
            $1.GetIncomingEscrowPaymentQuoteResponse>(
        'GetIncomingEscrowPaymentQuote',
        getIncomingEscrowPaymentQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetIncomingEscrowPaymentQuoteRequest.fromBuffer(value),
        ($1.GetIncomingEscrowPaymentQuoteResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$1.CreateDirectPaymentResponse> createDirectPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateDirectPaymentRequest> request) async {
    return createDirectPayment(call, await request);
  }

  $async.Future<$1.GetDirectPaymentQuoteResponse> getDirectPaymentQuote_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetDirectPaymentQuoteRequest> request) async {
    return getDirectPaymentQuote(call, await request);
  }

  $async.Future<$1.CreateEscrowPaymentResponse> createEscrowPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateEscrowPaymentRequest> request) async {
    return createEscrowPayment(call, await request);
  }

  $async.Future<$1.ReceiveEscrowPaymentResponse> receiveEscrowPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ReceiveEscrowPaymentRequest> request) async {
    return receiveEscrowPayment(call, await request);
  }

  $async.Future<$1.CancelEscrowPaymentResponse> cancelEscrowPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CancelEscrowPaymentRequest> request) async {
    return cancelEscrowPayment(call, await request);
  }

  $async.Future<$1.GetOutgoingEscrowPaymentQuoteResponse>
      getOutgoingEscrowPaymentQuote_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetOutgoingEscrowPaymentQuoteRequest>
              request) async {
    return getOutgoingEscrowPaymentQuote(call, await request);
  }

  $async.Future<$1.GetIncomingEscrowPaymentQuoteResponse>
      getIncomingEscrowPaymentQuote_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.GetIncomingEscrowPaymentQuoteRequest>
              request) async {
    return getIncomingEscrowPaymentQuote(call, await request);
  }

  $async.Future<$1.CreateDirectPaymentResponse> createDirectPayment(
      $grpc.ServiceCall call, $1.CreateDirectPaymentRequest request);
  $async.Future<$1.GetDirectPaymentQuoteResponse> getDirectPaymentQuote(
      $grpc.ServiceCall call, $1.GetDirectPaymentQuoteRequest request);
  $async.Future<$1.CreateEscrowPaymentResponse> createEscrowPayment(
      $grpc.ServiceCall call, $1.CreateEscrowPaymentRequest request);
  $async.Future<$1.ReceiveEscrowPaymentResponse> receiveEscrowPayment(
      $grpc.ServiceCall call, $1.ReceiveEscrowPaymentRequest request);
  $async.Future<$1.CancelEscrowPaymentResponse> cancelEscrowPayment(
      $grpc.ServiceCall call, $1.CancelEscrowPaymentRequest request);
  $async.Future<$1.GetOutgoingEscrowPaymentQuoteResponse>
      getOutgoingEscrowPaymentQuote($grpc.ServiceCall call,
          $1.GetOutgoingEscrowPaymentQuoteRequest request);
  $async.Future<$1.GetIncomingEscrowPaymentQuoteResponse>
      getIncomingEscrowPaymentQuote($grpc.ServiceCall call,
          $1.GetIncomingEscrowPaymentQuoteRequest request);
}
