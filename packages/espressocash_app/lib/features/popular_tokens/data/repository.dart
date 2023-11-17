import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/tokens/token.dart';
import '../../../core/tokens/token_list.dart';
import 'coingecko_client.dart';

@injectable
class PopularTokenRepository {
  PopularTokenRepository({
    required MarketsCoingeckoClient coingeckoClient,
    required TokenList tokenList,
  })  : _coingeckoClient = coingeckoClient,
        _tokenList = tokenList;

  final MarketsCoingeckoClient _coingeckoClient;
  final TokenList _tokenList;

  AsyncResult<IMap<Token, double>> refresh({required String currency}) =>
      _coingeckoClient
          .getMarketTokens(
            MarketsRequestDto(
              vsCurrency: currency,
              perPage: _popularTokensCoinGeckoId.length,
              ids: _popularTokensCoinGeckoId.join(','),
            ),
          )
          .toEither()
          .mapAsync(_sortTokens)
          .mapAsync(
            (responses) => responses.map(
              (r) => r
                  .toToken(_tokenList)
                  .let((t) => MapEntry(t, r.currentPrice ?? 0)),
            ),
          )
          .mapAsync(IMap.fromEntries);

  List<MarketsResponseDto> _sortTokens(
    List<MarketsResponseDto> response,
  ) {
    final solanaId = Token.sol.coingeckoId ?? 'solana';
    final sol = response.firstWhereOrNull((r) => r.id == solanaId);

    if (sol == null) return response;

    return response
      ..remove(sol)
      ..insert(0, sol);
  }
}

const _popularTokensCoinGeckoId = [
  'solana',
  'raydium',
  'orca',
  'mango',
  'usd-coin',
  'tether',
  'bonk',
];
