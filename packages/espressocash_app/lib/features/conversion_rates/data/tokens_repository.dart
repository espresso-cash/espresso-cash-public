import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import 'jupiter_client.dart';

@lazySingleton
class TokenConversionRatesRepository extends ChangeNotifier {
  TokenConversionRatesRepository({
    required JupiterPriceClient client,
  })  : _maxIds = 100,
        _coingeckoClient = client;

  final BehaviorSubject<IMap<FiatCurrency, IMap<CryptoCurrency, Decimal>>>
      _value = BehaviorSubject.seeded(const IMapConst({}));

  final int _maxIds;
  final JupiterPriceClient _coingeckoClient;

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

        final ids = await Stream.fromIterable(tokens.addresses)
            .bufferCount(_maxIds)
            .toList();

        final results = await Future.wait(
          ids.map((ids) async {
            final request = RateRequestDto(
              ids: ids.lock,
            );

            return _coingeckoClient.getPrice(request);
          }),
        );

        final Map<String, PricesMapDto> conversionRates = {};
        for (final element in results) {
          conversionRates.addAll(element.data);
        }

        final previous = _value.value[currency] ?? const IMapConst({});

        final newValue = _value.value.add(
          currency,
          previous.addAll(
            conversionRates.keys.fold<IMap<CryptoCurrency, Decimal>>(
                const IMapConst({}), (map, value) {
              final data = conversionRates[value];

              if (data == null) return map;

              final rate = data.price;

              return map.add(
                CryptoCurrency(
                  token: tokens.firstWhere((t) => t.symbol == value),
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
