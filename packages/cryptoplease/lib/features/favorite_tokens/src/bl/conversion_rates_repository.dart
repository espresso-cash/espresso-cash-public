import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/conversion_rates/bl/conversion_rates_client.dart';
import '../../../../core/currency.dart';
import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';

@injectable
class FavoriteConversionRateRepository {
  FavoriteConversionRateRepository({
    required ConversionRatesClient coingeckoClient,
  })  : _maxCoingeckoIds = 30,
        _coingeckoClient = coingeckoClient;

  @visibleForTesting
  FavoriteConversionRateRepository.test({
    required ConversionRatesClient coingeckoClient,
    required int maxCoingeckoIds,
  })  : _maxCoingeckoIds = maxCoingeckoIds,
        _coingeckoClient = coingeckoClient;

  final int _maxCoingeckoIds;
  final ConversionRatesClient _coingeckoClient;

  AsyncResult<IMap<Token, Decimal?>> refresh(
    FiatCurrency currency,
    Iterable<Token> tokens,
  ) =>
      tryEitherAsync((_) async {
        if (currency != Currency.usd) throw UnimplementedError();

        final ids = await Stream.fromIterable(tokens.coingeckoIds)
            .bufferCount(_maxCoingeckoIds)
            .toList();

        final results = await Future.wait(
          ids.map((ids) async {
            final request = RateRequestDto(
              vsCurrencies: [currency.symbol].lock,
              ids: ids.lock,
            );

            return _coingeckoClient.getPrice(request);
          }),
        );

        final Map<String, PricesMapDto> conversionRates = {};
        results.forEach(conversionRates.addAll);

        return conversionRates.keys
            .fold<IMap<Token, Decimal>>(const IMapConst({}), (map, value) {
          final data = conversionRates[value];

          if (data == null) return map;
          final rate = currency == Currency.usd ? data.usd : data.eur;
          if (rate == null) return map;

          return map.add(
            tokens.firstWhere((t) => t.coingeckoId == value),
            Decimal.parse(rate.toString()),
          );
        });
      });
}
