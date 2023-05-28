import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/tokens/token.dart';
import 'chart_interval.dart';
import 'data/coingecko_client.dart';
import 'token_chart_item.dart';

@injectable
class ChartRepository {
  ChartRepository({
    required ChartCoingeckoClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final ChartCoingeckoClient _coingeckoClient;

  AsyncResult<IList<TokenChartItem>> getMarketChart(
    Token crypto, {
    required ChartInterval interval,
  }) async =>
      _coingeckoClient
          .getCoinChart(
            crypto.extensions?.coingeckoId ?? crypto.name,
            TokenChartRequestDto(
              days: interval.dtoDays,
              interval: interval.dtoInterval,
            ),
          )
          .toEither()
          .mapAsync(
            (response) =>
                response.prices?.map((e) => e.toTokenChartItem()).toIList() ??
                const IListConst([]),
          );
}

extension on List<num> {
  TokenChartItem toTokenChartItem() => TokenChartItem(
        date: DateTime.fromMillisecondsSinceEpoch(first as int),
        price: last as double,
      );
}

extension on ChartInterval {
  String get dtoInterval {
    switch (this) {
      case ChartInterval.oneDay:
      case ChartInterval.oneWeek:
        return 'hourly';
      case ChartInterval.oneMonth:
      case ChartInterval.threeMonth:
      case ChartInterval.oneYear:
      case ChartInterval.all:
        return 'daily';
    }
  }

  String get dtoDays {
    switch (this) {
      case ChartInterval.oneDay:
        return '1';
      case ChartInterval.oneWeek:
        return '7';
      case ChartInterval.oneMonth:
        return '30';
      case ChartInterval.threeMonth:
        return '90';
      case ChartInterval.oneYear:
        return '365';
      case ChartInterval.all:
        return 'max';
    }
  }
}
