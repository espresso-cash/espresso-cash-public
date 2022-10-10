import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_details/data/coingecko_client.dart';
import 'package:cryptoplease/features/token_details/presentation/components/chart_widget.dart';

abstract class TokenRepository {
  Future<TokenDetailsResponseDto> getTokenDetails(Token crypto);
  Future<List<TokenChartItem>?> getMarketChart(
    Token crypto, {
    ChartInterval interval,
  });
}
