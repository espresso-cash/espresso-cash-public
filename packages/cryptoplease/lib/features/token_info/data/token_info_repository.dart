import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_info/bl/repository.dart';
import 'package:cryptoplease/features/token_info/data/coingecko_client.dart';
import 'package:flutter/material.dart';

class CoingeckoTokenInfoRepository extends ChangeNotifier
    implements TokenInfoRepository {
  CoingeckoTokenInfoRepository({
    required CoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final CoingeckoClient _coingeckoClient;

  @override
  Future<void> getMarketChart(Token crypto) async {
    final test = await _coingeckoClient.getCoinChart(
      'solana',
      const CoinMarketChartRequestDto(),
    );

    print(test);
  }

  @override
  Future<void> getTokenInfo(Token crypto) async {
    try {
      final test = await _coingeckoClient.getCoinInfo(
        'solana',
        const CoinInfoRequestDto(),
      );

      print(test);
    } catch (ex) {
      print(ex);
    }
  }
}
