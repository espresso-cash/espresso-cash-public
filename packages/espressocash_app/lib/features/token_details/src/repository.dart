import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/tokens/token.dart';
import 'data/coingecko_client.dart';
import 'data/token_details_cache.dart';
import 'token_details.dart';

@injectable
class TokenDetailsRepository {
  TokenDetailsRepository({
    required DetailsCoingeckoClient coingeckoClient,
    required TokenDetailsCache tokenDetailsCache,
  })  : _coingeckoClient = coingeckoClient,
        _cache = tokenDetailsCache;

  final DetailsCoingeckoClient _coingeckoClient;
  final TokenDetailsCache _cache;

  AsyncResult<TokenDetails> getTokenDetails({
    required Token token,
    required String fiatCurrency,
  }) async {
    final id = token.extensions?.coingeckoId ?? token.name;

    final cachedResult = await _cache.get(id);

    if (cachedResult != null) {
      return Either.right(cachedResult);
    }

    return _coingeckoClient
        .getCoinDetails(
          id,
          const TokenDetailsRequestDto(marketData: true),
        )
        .toEither()
        .mapAsync(
          (result) =>
              result.toModel(name: token.name, fiatCurrency: fiatCurrency),
        )
        .doOnRightAsync((result) => _cache.set(id, result));
  }
}
