import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/tokens/token.dart';
import 'data/coingecko_client.dart';

@injectable
class MarketDetailsRepository {
  MarketDetailsRepository({
    required MarketsCoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final MarketsCoingeckoClient _coingeckoClient;

  AsyncResult<Map<Token, double>> getTopMarketTokens({
    required String currency,
    required int noOfTokens,
  }) async =>
      _coingeckoClient
          .getMarketTokens(
            MarketsRequestDto(
              vsCurrency: currency,
              order: 'market_cap_desc',
              perPage: noOfTokens,
            ),
          )
          .toEither()
          .mapAsync(
            (response) => {
              for (var e in response) e.fromCoingecko(): e.currentPrice ?? 0
            },
          );
}
