//
//  Generated code. Do not modify.
//  source: espressocash/api/rates/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapiratesv1service;
import "service.connect.spec.dart" as specs;

extension type RateServiceClient (connect.Transport _transport) {
  Future<espressocashapiratesv1service.GetRatesResponse> getRates(
    espressocashapiratesv1service.GetRatesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.RateService.getRates,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<espressocashapiratesv1service.GetFiatRatesResponse> getFiatRates(
    espressocashapiratesv1service.GetFiatRatesRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.RateService.getFiatRates,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
