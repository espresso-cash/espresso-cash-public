import 'package:async/async.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/async_cache.dart';
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
  final AsyncCache<void> _cache = AsyncCache(const Duration(minutes: 1));

  @PostConstruct()
  void init() {
    final rate = _storage.getDouble(_usdcRateKey);

    if (rate == null) return;

    _value.add(
      IMapConst({
        Currency.usd: Decimal.tryParse(rate.toString()) ?? Decimal.zero,
      }),
    );
  }

  Decimal? readRate({required FiatCurrency to}) => _value.value[to];

  Stream<Decimal?> watchRate({
    required FiatCurrency to,
  }) =>
      _value.map((v) => v[to]).distinct();

  AsyncResult<void> refresh() => _cache.fetchEither(() async {
        final data = await _ecClient.getRates().then((p) => p.usdc);
        await _storage.setDouble(_usdcRateKey, data);
        final value = _value.value.add(
          Currency.usd,
          Decimal.parse(data.toString()),
        );
        _value.add(value);

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
