import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';
import '../../currency/models/currency.dart';

@Singleton(scope: authScope)
class ConversionRatesRepository extends ChangeNotifier {
  ConversionRatesRepository({
    required SharedPreferences storage,
    required EspressoCashClient ecClient,
  })  : _ecClient = ecClient,
        _storage = storage;

  final BehaviorSubject<IMap<FiatCurrency, Decimal>> _value =
      BehaviorSubject.seeded(const IMapConst({}));

  final EspressoCashClient _ecClient;
  final SharedPreferences _storage;

  @PostConstruct()
  void init() {
    final rate = _storage.getDouble(_usdcRateKey);

    if (rate == null) return;

    _value.add(
      IMapConst({
        Currency.usd: Decimal.tryParse(rate.toString()) ?? Decimal.zero,
      }),
    );
    notifyListeners();
  }

  Decimal? readRate({required FiatCurrency to}) => _value.value[to];

  Stream<Decimal?> watchRate({
    required FiatCurrency to,
  }) =>
      _value.map((v) => v[to]).distinct();

  AsyncResult<void> refresh(FiatCurrency currency) => tryEitherAsync((_) async {
        if (currency != Currency.usd) throw UnimplementedError();

        final data = await _ecClient.getRates().letAsync((p) => p['usdc']);
        if (data == null) return;

        final value = _value.value.add(
          currency,
          data.let((s) => Decimal.parse(s.toString())),
        );
        _value.add(value);

        await _storage.setDouble(_usdcRateKey, data);

        notifyListeners();
      });

  @override
  @disposeMethod
  void dispose() {
    _value.close();
    _storage.remove(_usdcRateKey);
    super.dispose();
  }
}

const _usdcRateKey = 'usdcRate';
