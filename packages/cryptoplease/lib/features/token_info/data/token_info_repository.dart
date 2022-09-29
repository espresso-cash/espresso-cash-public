import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_info/bl/repository.dart';
import 'package:cryptoplease/features/token_info/data/coingecko_client.dart';
import 'package:cryptoplease/features/token_info/presentation/components/chart_widget.dart';

class CoingeckoTokenInfoRepository implements TokenRepository {
  CoingeckoTokenInfoRepository({
    required CoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final CoingeckoClient _coingeckoClient;

  @override
  Future<TokenInfoResponseDto> getTokenInfo(Token crypto) async =>
      _coingeckoClient.getCoinInfo(
        crypto.extensions?.coingeckoId ?? crypto.name,
        const TokenInfoRequestDto(),
      );

  @override
  Future<List<TokenChartItem>?> getMarketChart(
    Token crypto, {
    ChartInterval interval = ChartInterval.oneWeek,
  }) async {
    final response = await _coingeckoClient.getCoinChart(
      crypto.extensions?.coingeckoId ?? crypto.name,
      TokenChartRequestDto(days: interval.value),
    );

    return response.prices;
  }
}
