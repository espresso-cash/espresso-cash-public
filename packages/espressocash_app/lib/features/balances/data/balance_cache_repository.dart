import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/currency.dart';

@injectable
class BalanceCacheRepository {
  const BalanceCacheRepository(this._storage);

  final SharedPreferences _storage;

  void saveBalance(int balance) => _storage.setInt(_usdcBalanceKey, balance);

  void saveRate({
    required double rate,
    required FiatCurrency currency,
  }) =>
      _storage
        ..setDouble(_usdcRateKey, rate)
        ..setString(_usdcCurrencyKey, currency.symbol);

  int? get balance => _storage.getInt(_usdcBalanceKey);

  (double, FiatCurrency)? fetchRate() {
    final rate = _storage.getDouble(_usdcRateKey);
    final currency = _storage.getString(_usdcCurrencyKey);

    return rate == null || currency == null
        ? null
        : (rate, currencyFromString(currency));
  }

  void clear() => _storage
    ..remove(_usdcBalanceKey)
    ..remove(_usdcRateKey)
    ..remove(_usdcCurrencyKey);
}

const _usdcBalanceKey = 'usdcBalance';
const _usdcRateKey = 'usdcRate';
const _usdcCurrencyKey = 'usdcCurrency';
