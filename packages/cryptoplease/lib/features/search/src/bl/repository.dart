import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';
import '../data/coingecko_client.dart';
import '../data/search_cache.dart';
import '../presentation/discover_header.dart';

@injectable
class SearchRepository {
  SearchRepository({
    required SearchCoingeckoClient coingeckoClient,
    required SearchCache cache,
    required TokenList tokenList,
  })  : _coingeckoClient = coingeckoClient,
        _cache = cache,
        _tokenList = tokenList;

  final SearchCoingeckoClient _coingeckoClient;
  final SearchCache _cache;
  final TokenList _tokenList;

  AsyncResult<IList<Token>> search(String query) async {
    final cachedResult = _cache.get(query);

    if (cachedResult != null) {
      return Either.right(cachedResult);
    }

    return _coingeckoClient.search(query).toEither().mapAsync(
      (response) {
        final res = response.coins.map((e) => e.toToken(_tokenList)).toIList();

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
        final res = response.map((e) => e.toToken(_tokenList)).toIList();

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

extension SearchResponseDataDtoExt on SearchResponseDataDto {
  Token toToken(TokenList tokenList) => Token.fromCoingecko(
        id: id,
        symbol: symbol,
        name: name,
        image: large,
        tokenList: tokenList,
      );
}

extension on CategorySearchResponseDto {
  Token toToken(TokenList tokenList) => Token.fromCoingecko(
        id: id,
        symbol: symbol,
        name: name,
        image: image,
        tokenList: tokenList,
      );
}
