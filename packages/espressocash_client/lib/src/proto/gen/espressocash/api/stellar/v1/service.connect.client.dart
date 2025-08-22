//
//  Generated code. Do not modify.
//  source: espressocash/api/stellar/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapistellarv1service;
import "service.connect.spec.dart" as specs;

extension type StellarServiceClient (connect.Transport _transport) {
  Future<espressocashapistellarv1service.SubmitTransactionResponse> submitTransaction(
    espressocashapistellarv1service.SubmitTransactionRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.StellarService.submitTransaction,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapistellarv1service.GetTransactionResponse> getTransaction(
    espressocashapistellarv1service.GetTransactionRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.StellarService.getTransaction,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
