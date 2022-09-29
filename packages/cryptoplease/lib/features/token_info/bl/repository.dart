import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_info/data/coingecko_client.dart';
import 'package:cryptoplease/features/token_info/presentation/components/chart_widget.dart';

abstract class TokenRepository {
  Future<TokenInfoResponseDto> getTokenInfo(Token crypto);
  Future<List<TokenChartItem>?> getMarketChart(
    Token crypto, {
    ChartInterval interval,
  });
}
