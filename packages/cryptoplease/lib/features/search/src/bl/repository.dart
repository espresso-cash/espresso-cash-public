import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../config.dart';
import '../../../../core/tokens/token.dart';
import '../data/coingecko_client.dart';
import '../data/search_cache.dart';
import '../presentation/discover_header.dart';

@injectable
class SearchRepository {
  SearchRepository({
    required SearchCoingeckoClient coingeckoClient,
    required SearchCache cache,
  })  : _coingeckoClient = coingeckoClient,
        _cache = cache;

  final SearchCoingeckoClient _coingeckoClient;
  final SearchCache _cache;

  AsyncResult<IList<Token>> search(String query) async {
    final cachedResult = _cache.get(query);

    if (cachedResult != null) {
      return Either.right(cachedResult);
    }

    return _coingeckoClient.search(query).toEither().mapAsync(
      (response) {
        final res = response.coins.map((e) => e.fromCoingecko()).toIList();

        _cache.set(query, res);

        return res;
      },
    );
  }

  AsyncResult<IList<Token>> category(CryptoCategories category) async {
    final cachedResult = _cache.get(category.dtoId);

    if (cachedResult != null) {
      return Either.right(cachedResult);
    }

    return _coingeckoClient
        .searchByCategory(CategorySearchRequestDto(category: category.dtoId))
        .toEither()
        .mapAsync(
      (response) {
        final res = response.map((e) => e.fromCoingecko()).toIList();

        _cache.set(category.dtoId, res);

        return res;
      },
    );
  }
}

extension on CryptoCategories {
  String get dtoId {
    switch (this) {
      case CryptoCategories.ethereum:
        return 'ethereum-ecosystem';
      case CryptoCategories.stablecoins:
        return 'stablecoins';
      case CryptoCategories.solana:
        return 'solana-ecosystem';
      case CryptoCategories.defi:
        return 'decentralized-finance-defi';
      case CryptoCategories.amm:
        return 'automated-market-maker-amm';
    }
  }
}

//TODO
extension SearchResponseDataDtoExt on SearchResponseDataDto {
  Token fromCoingecko() => Token(
        symbol: symbol,
        name: name,
        extensions: Extensions(coingeckoId: id),
        chainId: 0,
        address: '0',
        decimals: 0,
        logoURI: thumb,
        tags: const [],
      );
}

//TODO
extension on CategorySearchResponseDto {
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
