import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/currency.dart';
import '../../authenticated/auth_scope.dart';
import '../../balances/data/balance_cache_repository.dart';
import '../../tokens/token.dart';
import 'conversion_rates_client.dart';

@Singleton(scope: authScope)
class ConversionRatesRepository extends ChangeNotifier {
  ConversionRatesRepository(
    this._cache, {
    required ConversionRatesClient coingeckoClient,
  }) : _coingeckoClient = coingeckoClient;

  final BehaviorSubject<IMap<FiatCurrency, Decimal>> _value =
      BehaviorSubject.seeded(const IMapConst({}));

  final ConversionRatesClient _coingeckoClient;
  final BalanceCacheRepository _cache;

  @PostConstruct()
  void init() {
    final rate = _cache.fetchRate();

    if (rate == null) return;

    if (rate.$2 != Currency.usd) return;

    _value.add(
      IMapConst({
        rate.$2:
            rate.$1.let((s) => Decimal.tryParse(s.toString()) ?? Decimal.zero),
      }),
    );
  }

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

        _cache.saveRate(
          rate: data.usd ?? 0,
          currency: currency,
        );
      });
}
