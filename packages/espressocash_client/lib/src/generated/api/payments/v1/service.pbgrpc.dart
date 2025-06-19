//
//  Generated code. Do not modify.
//  source: api/payments/v1/service.proto
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

import 'service.pb.dart' as $2;

export 'service.pb.dart';

@$pb.GrpcServiceName('espressocash.api.payments.v1.PaymentService')
class PaymentServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  static final _$createDirectPayment =
      $grpc.ClientMethod<$2.CreateDirectPaymentRequest, $2.CreateDirectPaymentResponse>(
          '/espressocash.api.payments.v1.PaymentService/CreateDirectPayment',
          ($2.CreateDirectPaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.CreateDirectPaymentResponse.fromBuffer(value));
  static final _$getDirectPaymentQuote =
      $grpc.ClientMethod<$2.GetDirectPaymentQuoteRequest, $2.GetDirectPaymentQuoteResponse>(
          '/espressocash.api.payments.v1.PaymentService/GetDirectPaymentQuote',
          ($2.GetDirectPaymentQuoteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.GetDirectPaymentQuoteResponse.fromBuffer(value));
  static final _$createEscrowPayment =
      $grpc.ClientMethod<$2.CreateEscrowPaymentRequest, $2.CreateEscrowPaymentResponse>(
          '/espressocash.api.payments.v1.PaymentService/CreateEscrowPayment',
          ($2.CreateEscrowPaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.CreateEscrowPaymentResponse.fromBuffer(value));
  static final _$receiveEscrowPayment =
      $grpc.ClientMethod<$2.ReceiveEscrowPaymentRequest, $2.ReceiveEscrowPaymentResponse>(
          '/espressocash.api.payments.v1.PaymentService/ReceiveEscrowPayment',
          ($2.ReceiveEscrowPaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.ReceiveEscrowPaymentResponse.fromBuffer(value));
  static final _$cancelEscrowPayment =
      $grpc.ClientMethod<$2.CancelEscrowPaymentRequest, $2.CancelEscrowPaymentResponse>(
          '/espressocash.api.payments.v1.PaymentService/CancelEscrowPayment',
          ($2.CancelEscrowPaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.CancelEscrowPaymentResponse.fromBuffer(value));
  static final _$getOutgoingEscrowPaymentQuote = $grpc.ClientMethod<
          $2.GetOutgoingEscrowPaymentQuoteRequest, $2.GetOutgoingEscrowPaymentQuoteResponse>(
      '/espressocash.api.payments.v1.PaymentService/GetOutgoingEscrowPaymentQuote',
      ($2.GetOutgoingEscrowPaymentQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetOutgoingEscrowPaymentQuoteResponse.fromBuffer(value));
  static final _$getIncomingEscrowPaymentQuote = $grpc.ClientMethod<
          $2.GetIncomingEscrowPaymentQuoteRequest, $2.GetIncomingEscrowPaymentQuoteResponse>(
      '/espressocash.api.payments.v1.PaymentService/GetIncomingEscrowPaymentQuote',
      ($2.GetIncomingEscrowPaymentQuoteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.GetIncomingEscrowPaymentQuoteResponse.fromBuffer(value));

  PaymentServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$2.CreateDirectPaymentResponse> createDirectPayment(
      $2.CreateDirectPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDirectPayment, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetDirectPaymentQuoteResponse> getDirectPaymentQuote(
      $2.GetDirectPaymentQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDirectPaymentQuote, request, options: options);
  }

  $grpc.ResponseFuture<$2.CreateEscrowPaymentResponse> createEscrowPayment(
      $2.CreateEscrowPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createEscrowPayment, request, options: options);
  }

  $grpc.ResponseFuture<$2.ReceiveEscrowPaymentResponse> receiveEscrowPayment(
      $2.ReceiveEscrowPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$receiveEscrowPayment, request, options: options);
  }

  $grpc.ResponseFuture<$2.CancelEscrowPaymentResponse> cancelEscrowPayment(
      $2.CancelEscrowPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelEscrowPayment, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetOutgoingEscrowPaymentQuoteResponse> getOutgoingEscrowPaymentQuote(
      $2.GetOutgoingEscrowPaymentQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOutgoingEscrowPaymentQuote, request, options: options);
  }

  $grpc.ResponseFuture<$2.GetIncomingEscrowPaymentQuoteResponse> getIncomingEscrowPaymentQuote(
      $2.GetIncomingEscrowPaymentQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIncomingEscrowPaymentQuote, request, options: options);
  }
}

@$pb.GrpcServiceName('espressocash.api.payments.v1.PaymentService')
abstract class PaymentServiceBase extends $grpc.Service {
  $core.String get $name => 'espressocash.api.payments.v1.PaymentService';

  PaymentServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CreateDirectPaymentRequest, $2.CreateDirectPaymentResponse>(
        'CreateDirectPayment',
        createDirectPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CreateDirectPaymentRequest.fromBuffer(value),
        ($2.CreateDirectPaymentResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.GetDirectPaymentQuoteRequest, $2.GetDirectPaymentQuoteResponse>(
            'GetDirectPaymentQuote',
            getDirectPaymentQuote_Pre,
            false,
            false,
            ($core.List<$core.int> value) => $2.GetDirectPaymentQuoteRequest.fromBuffer(value),
            ($2.GetDirectPaymentQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CreateEscrowPaymentRequest, $2.CreateEscrowPaymentResponse>(
        'CreateEscrowPayment',
        createEscrowPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CreateEscrowPaymentRequest.fromBuffer(value),
        ($2.CreateEscrowPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.ReceiveEscrowPaymentRequest, $2.ReceiveEscrowPaymentResponse>(
        'ReceiveEscrowPayment',
        receiveEscrowPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.ReceiveEscrowPaymentRequest.fromBuffer(value),
        ($2.ReceiveEscrowPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CancelEscrowPaymentRequest, $2.CancelEscrowPaymentResponse>(
        'CancelEscrowPayment',
        cancelEscrowPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CancelEscrowPaymentRequest.fromBuffer(value),
        ($2.CancelEscrowPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetOutgoingEscrowPaymentQuoteRequest,
            $2.GetOutgoingEscrowPaymentQuoteResponse>(
        'GetOutgoingEscrowPaymentQuote',
        getOutgoingEscrowPaymentQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetOutgoingEscrowPaymentQuoteRequest.fromBuffer(value),
        ($2.GetOutgoingEscrowPaymentQuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.GetIncomingEscrowPaymentQuoteRequest,
            $2.GetIncomingEscrowPaymentQuoteResponse>(
        'GetIncomingEscrowPaymentQuote',
        getIncomingEscrowPaymentQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.GetIncomingEscrowPaymentQuoteRequest.fromBuffer(value),
        ($2.GetIncomingEscrowPaymentQuoteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.CreateDirectPaymentResponse> createDirectPayment_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.CreateDirectPaymentRequest> $request) async {
    return createDirectPayment($call, await $request);
  }

  $async.Future<$2.GetDirectPaymentQuoteResponse> getDirectPaymentQuote_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.GetDirectPaymentQuoteRequest> $request) async {
    return getDirectPaymentQuote($call, await $request);
  }

  $async.Future<$2.CreateEscrowPaymentResponse> createEscrowPayment_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.CreateEscrowPaymentRequest> $request) async {
    return createEscrowPayment($call, await $request);
  }

  $async.Future<$2.ReceiveEscrowPaymentResponse> receiveEscrowPayment_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.ReceiveEscrowPaymentRequest> $request) async {
    return receiveEscrowPayment($call, await $request);
  }

  $async.Future<$2.CancelEscrowPaymentResponse> cancelEscrowPayment_Pre(
      $grpc.ServiceCall $call, $async.Future<$2.CancelEscrowPaymentRequest> $request) async {
    return cancelEscrowPayment($call, await $request);
  }

  $async.Future<$2.GetOutgoingEscrowPaymentQuoteResponse> getOutgoingEscrowPaymentQuote_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$2.GetOutgoingEscrowPaymentQuoteRequest> $request) async {
    return getOutgoingEscrowPaymentQuote($call, await $request);
  }

  $async.Future<$2.GetIncomingEscrowPaymentQuoteResponse> getIncomingEscrowPaymentQuote_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$2.GetIncomingEscrowPaymentQuoteRequest> $request) async {
    return getIncomingEscrowPaymentQuote($call, await $request);
  }

  $async.Future<$2.CreateDirectPaymentResponse> createDirectPayment(
      $grpc.ServiceCall call, $2.CreateDirectPaymentRequest request);
  $async.Future<$2.GetDirectPaymentQuoteResponse> getDirectPaymentQuote(
      $grpc.ServiceCall call, $2.GetDirectPaymentQuoteRequest request);
  $async.Future<$2.CreateEscrowPaymentResponse> createEscrowPayment(
      $grpc.ServiceCall call, $2.CreateEscrowPaymentRequest request);
  $async.Future<$2.ReceiveEscrowPaymentResponse> receiveEscrowPayment(
      $grpc.ServiceCall call, $2.ReceiveEscrowPaymentRequest request);
  $async.Future<$2.CancelEscrowPaymentResponse> cancelEscrowPayment(
      $grpc.ServiceCall call, $2.CancelEscrowPaymentRequest request);
  $async.Future<$2.GetOutgoingEscrowPaymentQuoteResponse> getOutgoingEscrowPaymentQuote(
      $grpc.ServiceCall call, $2.GetOutgoingEscrowPaymentQuoteRequest request);
  $async.Future<$2.GetIncomingEscrowPaymentQuoteResponse> getIncomingEscrowPaymentQuote(
      $grpc.ServiceCall call, $2.GetIncomingEscrowPaymentQuoteRequest request);
}
