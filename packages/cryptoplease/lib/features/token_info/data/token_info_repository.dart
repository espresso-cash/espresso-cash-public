import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_info/bl/repository.dart';
import 'package:cryptoplease/features/token_info/data/coingecko_client.dart';

class CoingeckoTokenInfoRepository implements TokenInfoRepository {
  CoingeckoTokenInfoRepository({
    required CoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final CoingeckoClient _coingeckoClient;

  @override
  Future<List<TokenChartItem>?> getMarketChart(Token crypto) async {
    final chartResponse = await _coingeckoClient.getCoinChart(
      crypto.extensions?.coingeckoId ?? crypto.name,
      const TokenChartRequestDto(),
    );

    return chartResponse.prices;
  }

  @override
  Future<void> getTokenInfo(Token crypto) async {
    try {
      final test = await _coingeckoClient.getCoinInfo(
        crypto.extensions?.coingeckoId ?? crypto.name,
        const TokenInfoRequestDto(),
      );

      print(test);
    } catch (ex) {
      print(ex);
    }
  }
}
