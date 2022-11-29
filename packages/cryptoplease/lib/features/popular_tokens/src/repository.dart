import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../config.dart';
import '../../../core/tokens/token.dart';
import 'data/coingecko_client.dart';

@injectable
class MarketDetailsRepository {
  MarketDetailsRepository({
    required MarketsCoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final MarketsCoingeckoClient _coingeckoClient;

  AsyncResult<IMap<Token, double>> getTopMarketTokens({
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
            (responses) => IMap({
              for (var e in responses) e.fromCoingecko(): e.currentPrice ?? 0
            }),
          );
}

//TODO
extension on MarketsResponseDto {
  Token fromCoingecko() => Token(
        chainId: currentChainId,
        address: id ?? '',
        symbol: symbol?.toUpperCase() ?? '',
        name: name ?? '',
        decimals: 0,
        logoURI: image,
        tags: const [],
        extensions: Extensions(coingeckoId: id),
      );
}
