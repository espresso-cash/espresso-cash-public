import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../config.dart';
import '../../../../core/tokens/token.dart';
import '../data/coingecko_client.dart';
import '../data/popular_token_cache.dart';

@injectable
class PopularTokenRepository {
  PopularTokenRepository({
    required MarketsCoingeckoClient coingeckoClient,
    required PopularTokenCache popularTokenCache,
  })  : _coingeckoClient = coingeckoClient,
        _cache = popularTokenCache;

  final MarketsCoingeckoClient _coingeckoClient;
  final PopularTokenCache _cache;

  AsyncResult<IMap<Token, double>> get({
    required String currency,
    int noOfTokens = 20,
  }) async {
    final cachedResult = await _cache.get();

    if (cachedResult != null && cachedResult.isNotEmpty) {
      return Either.right(cachedResult);
    }

    return refresh(currency: currency, noOfTokens: noOfTokens);
  }

  AsyncResult<IMap<Token, double>> refresh({
    required String currency,
    int noOfTokens = 20,
  }) async =>
      _coingeckoClient
          .getMarketTokens(
            MarketsRequestDto(vsCurrency: currency, perPage: noOfTokens),
          )
          .toEither()
          .mapAsync(
        (responses) {
          final res = IMap(
            {for (var e in responses) e.fromCoingecko(): e.currentPrice ?? 0},
          );

          _cache.set(res);

          return res;
        },
      );

  Future<void> clear() => _cache.remove();
}

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
