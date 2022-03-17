import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/data/api/coingecko_client.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CoingeckoConversionRatesRepository extends ChangeNotifier
    implements ConversionRatesRepository {
  CoingeckoConversionRatesRepository({
    required CoingeckoClient coingeckoClient,
    @visibleForTesting int maxCoingeckoIds = 30,
  })  : _maxCoingeckoIds = maxCoingeckoIds,
        _coingeckoClient = coingeckoClient;

  final BehaviorSubject<IMap<FiatCurrency, IMap<CryptoCurrency, Decimal>>>
      _value = BehaviorSubject.seeded(const IMapConst({}));

  final int _maxCoingeckoIds;
  final CoingeckoClient _coingeckoClient;

  @override
  Decimal? readRate(CryptoCurrency crypto, {required FiatCurrency to}) =>
      _value.value[to]?[crypto];

  @override
  Stream<Decimal?> watchRate(
    CryptoCurrency crypto, {
    required FiatCurrency to,
  }) =>
      _value.map((v) => v[to]?[crypto]).distinct();

  @override
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

        final newValue = _value.value.add(
          currency,
          conversionRates.keys.fold(const IMapConst({}), (map, value) {
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
        );
        _value.add(newValue);
        notifyListeners();
      });
}
