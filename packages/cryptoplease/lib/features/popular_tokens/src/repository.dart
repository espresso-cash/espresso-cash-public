import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';

import 'data/coingecko_client.dart';
import 'market_token.dart';

@injectable
class MarketDetailsRepository {
  MarketDetailsRepository({
    required MarketsCoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final MarketsCoingeckoClient _coingeckoClient;

  AsyncResult<List<CoingeckoToken>> getMarketInfo() async => _coingeckoClient
      .getMarketTokens(
        const MarketsRequestDto(
          vsCurrency: 'usd',
          order: 'market_cap_desc',
          perPage: 20,
        ),
      )
      .toEither()
      .mapAsync(
        (response) => response.map((e) => e.fromCoingecko()).toList(),
      );
}
