//
//  Generated code. Do not modify.
//  source: espressocash/api/moneygram/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapimoneygramv1service;
import "service.connect.spec.dart" as specs;

extension type MoneygramServiceClient (connect.Transport _transport) {
  Future<espressocashapimoneygramv1service.MoneygramChallengeSignResponse> signChallenge(
    espressocashapimoneygramv1service.MoneygramChallengeSignRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.MoneygramService.signChallenge,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapimoneygramv1service.MoneygramSwapResponse> swapToSolana(
    espressocashapimoneygramv1service.SwapToSolanaRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.MoneygramService.swapToSolana,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapimoneygramv1service.MoneygramSwapResponse> swapToStellar(
    espressocashapimoneygramv1service.SwapToStellarRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.MoneygramService.swapToStellar,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapimoneygramv1service.MoneygramFeeResponse> calculateFee(
    espressocashapimoneygramv1service.MoneygramFeeRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.MoneygramService.calculateFee,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapimoneygramv1service.FundXlmResponse> fundXlm(
    espressocashapimoneygramv1service.FundXlmRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.MoneygramService.fundXlm,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
