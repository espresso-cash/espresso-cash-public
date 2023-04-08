import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';
import '../../models/crypto_categories.dart';
import '../data/coingecko_client.dart';

@injectable
class SearchRepository {
  SearchRepository({
    required SearchCoingeckoClient coingeckoClient,
    required TokenList tokenList,
  })  : _coingeckoClient = coingeckoClient,
        _tokenList = tokenList;

  final SearchCoingeckoClient _coingeckoClient;
  final TokenList _tokenList;

  AsyncResult<IList<Token>> search(String query) async =>
      _coingeckoClient.search(query).toEither().mapAsync(
            (response) =>
                response.coins.map((e) => e.toToken(_tokenList)).toIList(),
          );

  AsyncResult<IList<Token>> category(CryptoCategories category) async =>
      _coingeckoClient
          .searchByCategory(CategorySearchRequestDto(category: category.dtoId))
          .toEither()
          .mapAsync(
            (response) => response.map((e) => e.toToken(_tokenList)).toIList(),
          );
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
