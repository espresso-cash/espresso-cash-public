import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../currency.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import 'conversion_rates_client.dart';

@lazySingleton
class ConversionRatesRepository extends ChangeNotifier {
  ConversionRatesRepository({
    required ConversionRatesClient coingeckoClient,
  })  : _maxCoingeckoIds = 30,
        _coingeckoClient = coingeckoClient;

  @visibleForTesting
  ConversionRatesRepository.test({
    required ConversionRatesClient coingeckoClient,
    required int maxCoingeckoIds,
  })  : _maxCoingeckoIds = maxCoingeckoIds,
        _coingeckoClient = coingeckoClient;

  final BehaviorSubject<IMap<FiatCurrency, IMap<CryptoCurrency, Decimal>>>
      _value = BehaviorSubject.seeded(const IMapConst({}));

  final int _maxCoingeckoIds;
  final ConversionRatesClient _coingeckoClient;

  Decimal? testReadRate(CryptoCurrency crypto, {required FiatCurrency to}) =>
      _value.value[to]
          ?.where(
            (key, value) =>
                crypto.token.extensions?.coingeckoId ==
                key.token.extensions?.coingeckoId,
          )
          .values
          .first;

  Decimal? readRate(CryptoCurrency crypto, {required FiatCurrency to}) =>
      _value.value[to]?[crypto];

  Stream<Decimal?> watchRate(
    CryptoCurrency crypto, {
    required FiatCurrency to,
  }) =>
      _value.map((v) => v[to]?[crypto]).distinct();

  AsyncResult<void> refresh(FiatCurrency currency, Iterable<Token> tokens) =>
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

        final previous = _value.value[currency] ?? const IMapConst({});

        final newValue = _value.value.add(
          currency,
          previous.addAll(
            conversionRates.keys.fold<IMap<CryptoCurrency, Decimal>>(
                const IMapConst({}), (map, value) {
              final data = conversionRates[value];

              if (data == null) return map;
              final rate = currency == Currency.usd ? data.usd : data.eur;
              if (rate == null) return map;

              return map.add(
                CryptoCurrency(
                  token: tokens.firstWhere((t) => t.coingeckoId == value),
                ),
                Decimal.parse(rate.toString()),
              );
            }),
          ),
        );
        _value.add(newValue);
        notifyListeners();
      });
}
