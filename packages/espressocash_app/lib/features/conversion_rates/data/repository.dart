import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'conversion_rates_client.dart';

@lazySingleton
class ConversionRatesRepository extends ChangeNotifier {
  ConversionRatesRepository({
    required ConversionRatesClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final BehaviorSubject<IMap<FiatCurrency, Decimal>> _value =
      BehaviorSubject.seeded(const IMapConst({}));

  final ConversionRatesClient _coingeckoClient;

  Decimal? readRate({required FiatCurrency to}) => _value.value[to];

  Stream<Decimal?> watchRate({
    required FiatCurrency to,
  }) =>
      _value.map((v) => v[to]).distinct();

  AsyncResult<void> refresh(FiatCurrency currency) => tryEitherAsync((_) async {
        if (currency != Currency.usd) throw UnimplementedError();

        // ignore:  avoid-non-null-assertion, we know its not null
        final usdcId = Token.usdc.coingeckoId!;

        final request = RateRequestDto(
          vsCurrencies: [currency.symbol].lock,
          ids: [usdcId].lock,
        );

        final data =
            await _coingeckoClient.getPrice(request).letAsync((p) => p[usdcId]);

        if (data == null) return;

        final value = _value.value.add(
          currency,
          data.to(currency),
        );

        _value.add(value);
        notifyListeners();
      });
}
