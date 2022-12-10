import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/tokens/token.dart';
import '../../../core/tokens/token_list.dart';
import 'data/coingecko_client.dart';

@injectable
class MarketDetailsRepository {
  MarketDetailsRepository({
    required MarketsCoingeckoClient coingeckoClient,
    required TokenList tokenList,
  })  : _coingeckoClient = coingeckoClient,
        _tokenList = tokenList;

  final MarketsCoingeckoClient _coingeckoClient;
  final TokenList _tokenList;

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
            (responses) => responses
                .map(
                  (r) => r
                      .toToken(_tokenList)
                      ?.let((t) => MapEntry(t, r.currentPrice ?? 0)),
                )
                .compact(),
          )
          .mapAsync(IMap.fromEntries);
}

extension on MarketsResponseDto {
  Token? toToken(TokenList tokenList) {
    final id = this.id;
    final symbol = this.symbol;

    if (id == null) return null;

    return tokenList.tokens.singleWhereOrNull(
      (t) => t.symbol.toLowerCase() == symbol && t.coingeckoId == id,
    );
  }
}
