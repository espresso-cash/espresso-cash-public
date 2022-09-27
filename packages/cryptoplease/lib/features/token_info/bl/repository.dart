import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_info/data/coingecko_client.dart';

abstract class TokenInfoRepository {
  Future<void> getTokenInfo(Token crypto);
  Future<List<TokenChartItem>?> getMarketChart(Token crypto);
}
