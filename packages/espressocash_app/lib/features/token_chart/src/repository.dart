import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../core/tokens/token.dart';
import 'chart_interval.dart';
import 'data/coingecko_client.dart';
import 'data/token_chart_cache.dart';
import 'token_chart_item.dart';

@injectable
class ChartRepository {
  ChartRepository({
    required ChartCoingeckoClient coingeckoClient,
    required TokenChartCache tokenChartCache,
  })  : _coingeckoClient = coingeckoClient,
        _cache = tokenChartCache;

  final ChartCoingeckoClient _coingeckoClient;
  final TokenChartCache _cache;

  AsyncResult<IList<TokenChartItem>> getMarketChart(
    Token crypto, {
    required ChartInterval interval,
  }) async {
    final id =
        '${interval.dtoId}_${crypto.name}_${crypto.symbol}'.toUpperCase();

    final cachedResult = await _cache.get(id);

    if (cachedResult != null && cachedResult.isNotEmpty) {
      return Either.right(cachedResult.toIList());
    }

    return _coingeckoClient
        .getCoinChart(
          crypto.extensions?.coingeckoId ?? crypto.name,
          TokenChartRequestDto(
            days: interval.dtoDays,
            interval: interval.dtoInterval,
          ),
        )
        .toEither()
        .mapAsync(
          (response) => response.prices?.map((e) => e.toTokenChartItem()),
        )
        .doOnRightAsync((r) => _cache.set(id, r?.toList() ?? []))
        .mapAsync((r) => r?.toIList() ?? const IListConst([]));
  }
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

  String get dtoId {
    switch (this) {
      case ChartInterval.oneDay:
        return '1D';
      case ChartInterval.oneWeek:
        return '1W';
      case ChartInterval.oneMonth:
        return '1M';
      case ChartInterval.threeMonth:
        return '3M';
      case ChartInterval.oneYear:
        return '1Y';
      case ChartInterval.all:
        return 'ALL';
    }
  }
}
