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

  AsyncResult<List<CoingeckoToken>> getTopMarketTokens({
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
            (response) => response.map((e) => e.fromCoingecko()).toList(),
          );
}
