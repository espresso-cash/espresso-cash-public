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
      TokenChartRequestDto(
        days: interval.value,
        interval: _getChartInterval(interval),
      ),
    );

    return response.prices;
  }
}

String? _getChartInterval(ChartInterval interval) {
  switch (interval) {
    case ChartInterval.oneDay:
      return 'hourly';
    case ChartInterval.oneWeek:
      return 'hourly';
    case ChartInterval.oneMonth:
      return 'daily';
    case ChartInterval.threeMonth:
      return 'daily';
    case ChartInterval.oneYear:
      return 'daily';
    case ChartInterval.all:
      return 'daily';
  }
}
