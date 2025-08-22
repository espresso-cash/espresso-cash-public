//
//  Generated code. Do not modify.
//  source: espressocash/api/dln/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapidlnv1service;
import "service.connect.spec.dart" as specs;

extension type DlnServiceClient (connect.Transport _transport) {
  Future<espressocashapidlnv1service.GetOutgoingQuoteResponse> getOutgoingQuote(
    espressocashapidlnv1service.GetOutgoingQuoteRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.DlnService.getOutgoingQuote,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapidlnv1service.GetIncomingQuoteResponse> getIncomingQuote(
    espressocashapidlnv1service.GetIncomingQuoteRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.DlnService.getIncomingQuote,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapidlnv1service.GetOrderIdResponse> getOrderId(
    espressocashapidlnv1service.GetOrderIdRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.DlnService.getOrderId,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapidlnv1service.GetOrderStatusResponse> getOrderStatus(
    espressocashapidlnv1service.GetOrderStatusRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.DlnService.getOrderStatus,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapidlnv1service.GetGasFeesResponse> getGasFees(
    espressocashapidlnv1service.GetGasFeesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.DlnService.getGasFees,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
