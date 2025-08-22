//
//  Generated code. Do not modify.
//  source: espressocash/api/rates/v1/service.proto
//

import "package:connectrpc/connect.dart" as connect;
import "service.pb.dart" as espressocashapiratesv1service;

abstract final class RateService {
  /// Fully-qualified name of the RateService service.
  static const name = 'espressocash.api.rates.v1.RateService';

  static const getRates = connect.Spec(
    '/$name/GetRates',
    connect.StreamType.unary,
    espressocashapiratesv1service.GetRatesRequest.new,
    espressocashapiratesv1service.GetRatesResponse.new,
  );

  static const getFiatRates = connect.Spec(
    '/$name/GetFiatRates',
    connect.StreamType.unary,
    espressocashapiratesv1service.GetFiatRatesRequest.new,
    espressocashapiratesv1service.GetFiatRatesResponse.new,
  );
}
