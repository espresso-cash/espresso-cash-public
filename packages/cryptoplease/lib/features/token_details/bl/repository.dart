import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_details/data/coingecko_client.dart';
import 'package:cryptoplease/features/token_details/presentation/components/chart_widget.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TokenDetailsRepository {
  TokenDetailsRepository({
    required TokenCoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final TokenCoingeckoClient _coingeckoClient;

  Future<TokenDetailsResponseDto> getTokenDetails(Token crypto) async =>
      _coingeckoClient.getCoinDetails(
        crypto.extensions?.coingeckoId ?? crypto.name,
        const TokenDetailsRequestDto(),
      );

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
