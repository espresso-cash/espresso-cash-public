//
//  Generated code. Do not modify.
//  source: espressocash/api/payments/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapipaymentsv1service;
import "service.connect.spec.dart" as specs;

extension type PaymentServiceClient (connect.Transport _transport) {
  Future<espressocashapipaymentsv1service.CreateDirectPaymentResponse> createDirectPayment(
    espressocashapipaymentsv1service.CreateDirectPaymentRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.PaymentService.createDirectPayment,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapipaymentsv1service.GetDirectPaymentQuoteResponse> getDirectPaymentQuote(
    espressocashapipaymentsv1service.GetDirectPaymentQuoteRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.PaymentService.getDirectPaymentQuote,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapipaymentsv1service.CreateEscrowPaymentResponse> createEscrowPayment(
    espressocashapipaymentsv1service.CreateEscrowPaymentRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.PaymentService.createEscrowPayment,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapipaymentsv1service.ReceiveEscrowPaymentResponse> receiveEscrowPayment(
    espressocashapipaymentsv1service.ReceiveEscrowPaymentRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.PaymentService.receiveEscrowPayment,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapipaymentsv1service.CancelEscrowPaymentResponse> cancelEscrowPayment(
    espressocashapipaymentsv1service.CancelEscrowPaymentRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.PaymentService.cancelEscrowPayment,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapipaymentsv1service.GetOutgoingEscrowPaymentQuoteResponse> getOutgoingEscrowPaymentQuote(
    espressocashapipaymentsv1service.GetOutgoingEscrowPaymentQuoteRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.PaymentService.getOutgoingEscrowPaymentQuote,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapipaymentsv1service.GetIncomingEscrowPaymentQuoteResponse> getIncomingEscrowPaymentQuote(
    espressocashapipaymentsv1service.GetIncomingEscrowPaymentQuoteRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.PaymentService.getIncomingEscrowPaymentQuote,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
