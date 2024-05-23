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

  final BehaviorSubject<IMap<CryptoCurrency, Decimal>> _value =
      BehaviorSubject.seeded(const IMapConst({}));

  final int _maxIds;
  final JupiterPriceClient _coingeckoClient;

  Decimal? readRate(CryptoCurrency crypto) => _value.value[crypto];

  Stream<Decimal?> watchRate(CryptoCurrency crypto) =>
      _value.map((v) => v[crypto]).distinct();

  AsyncResult<void> refresh(Iterable<Token> tokens) =>
      tryEitherAsync((_) async {
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

        final previous = _value.value;

        final newValue = previous.addAll(
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
        );
        _value.add(newValue);
        notifyListeners();
      });
}
