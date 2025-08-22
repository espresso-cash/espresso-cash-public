// This is a generated file - do not edit.
//
// Generated from espressocash/api/payments/v1/service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'service.pb.dart' as $0;
import 'service.pbjson.dart';

export 'service.pb.dart';

abstract class PaymentServiceBase extends $pb.GeneratedService {
  $async.Future<$0.CreateDirectPaymentResponse> createDirectPayment(
      $pb.ServerContext ctx, $0.CreateDirectPaymentRequest request);
  $async.Future<$0.GetDirectPaymentQuoteResponse> getDirectPaymentQuote(
      $pb.ServerContext ctx, $0.GetDirectPaymentQuoteRequest request);
  $async.Future<$0.CreateEscrowPaymentResponse> createEscrowPayment(
      $pb.ServerContext ctx, $0.CreateEscrowPaymentRequest request);
  $async.Future<$0.ReceiveEscrowPaymentResponse> receiveEscrowPayment(
      $pb.ServerContext ctx, $0.ReceiveEscrowPaymentRequest request);
  $async.Future<$0.CancelEscrowPaymentResponse> cancelEscrowPayment(
      $pb.ServerContext ctx, $0.CancelEscrowPaymentRequest request);
  $async.Future<$0.GetOutgoingEscrowPaymentQuoteResponse>
      getOutgoingEscrowPaymentQuote($pb.ServerContext ctx,
          $0.GetOutgoingEscrowPaymentQuoteRequest request);
  $async.Future<$0.GetIncomingEscrowPaymentQuoteResponse>
      getIncomingEscrowPaymentQuote($pb.ServerContext ctx,
          $0.GetIncomingEscrowPaymentQuoteRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'CreateDirectPayment':
        return $0.CreateDirectPaymentRequest();
      case 'GetDirectPaymentQuote':
        return $0.GetDirectPaymentQuoteRequest();
      case 'CreateEscrowPayment':
        return $0.CreateEscrowPaymentRequest();
      case 'ReceiveEscrowPayment':
        return $0.ReceiveEscrowPaymentRequest();
      case 'CancelEscrowPayment':
        return $0.CancelEscrowPaymentRequest();
      case 'GetOutgoingEscrowPaymentQuote':
        return $0.GetOutgoingEscrowPaymentQuoteRequest();
      case 'GetIncomingEscrowPaymentQuote':
        return $0.GetIncomingEscrowPaymentQuoteRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'CreateDirectPayment':
        return createDirectPayment(
            ctx, request as $0.CreateDirectPaymentRequest);
      case 'GetDirectPaymentQuote':
        return getDirectPaymentQuote(
            ctx, request as $0.GetDirectPaymentQuoteRequest);
      case 'CreateEscrowPayment':
        return createEscrowPayment(
            ctx, request as $0.CreateEscrowPaymentRequest);
      case 'ReceiveEscrowPayment':
        return receiveEscrowPayment(
            ctx, request as $0.ReceiveEscrowPaymentRequest);
      case 'CancelEscrowPayment':
        return cancelEscrowPayment(
            ctx, request as $0.CancelEscrowPaymentRequest);
      case 'GetOutgoingEscrowPaymentQuote':
        return getOutgoingEscrowPaymentQuote(
            ctx, request as $0.GetOutgoingEscrowPaymentQuoteRequest);
      case 'GetIncomingEscrowPaymentQuote':
        return getIncomingEscrowPaymentQuote(
            ctx, request as $0.GetIncomingEscrowPaymentQuoteRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => PaymentServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => PaymentServiceBase$messageJson;
}
