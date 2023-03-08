import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/currency.dart';
import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';
import 'conversion_rates_client.dart';
import 'token_price_cache.dart';

@lazySingleton
class ConversionRatesRepository extends ChangeNotifier {
  ConversionRatesRepository({
    required ConversionRatesClient coingeckoClient,
    required TokenPriceCache tokenPriceCache,
  })  : _maxCoingeckoIds = 30,
        _tokenPriceCache = tokenPriceCache,
        _coingeckoClient = coingeckoClient;

  @visibleForTesting
  ConversionRatesRepository.test({
    required ConversionRatesClient coingeckoClient,
    required TokenPriceCache tokenPriceCache,
    required int maxCoingeckoIds,
  })  : _maxCoingeckoIds = maxCoingeckoIds,
        _tokenPriceCache = tokenPriceCache,
        _coingeckoClient = coingeckoClient;

  final BehaviorSubject<IMap<FiatCurrency, IMap<CryptoCurrency, Decimal>>>
      _value = BehaviorSubject.seeded(const IMapConst({}));

  final int _maxCoingeckoIds;
  final ConversionRatesClient _coingeckoClient;
  final TokenPriceCache _tokenPriceCache;

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
            final cache = await _tokenPriceCache.get(ids);
            final missingIds = ids.toSet().difference(cache.keys.toSet());

            if (missingIds.isEmpty) {
              return cache;
            }

            final request = RateRequestDto(
              vsCurrencies: [currency.symbol].lock,
              ids: missingIds.toList().lock,
            );

            final priceData = await _coingeckoClient.getPrice(request);
            await _tokenPriceCache.set(data: priceData);

            return {...priceData, ...cache};
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
