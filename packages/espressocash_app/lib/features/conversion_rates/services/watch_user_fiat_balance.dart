import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../../../core/user_preferences.dart';
import '../../balances/data/balances_repository.dart';
import '../data/repository.dart';

@injectable
class WatchUserFiatBalance {
  const WatchUserFiatBalance(
    this._userPreferences,
    this._conversionRatesRepository,
    this._balancesRepository,
  );

  final UserPreferences _userPreferences;
  final ConversionRatesRepository _conversionRatesRepository;
  final BalancesRepository _balancesRepository;

  (Stream<FiatAmount?>, FiatAmount?) call(Token token) {
    final fiatCurrency = _userPreferences.fiatCurrency;

    final conversionRate = _conversionRatesRepository
        .watchRate(CryptoCurrency(token: token), to: fiatCurrency);

    final balance = _balancesRepository.watch(token);

    return (
      Rx.combineLatest2(
        balance.$1,
        conversionRate,
        (cryptoAmount, rate) {
          if (rate == null) return null;

          return cryptoAmount.convert(rate: rate, to: fiatCurrency)
              as FiatAmount;
        },
      ).distinct(),
      _conversionRatesRepository
          .readRate(CryptoCurrency(token: token), to: fiatCurrency)
          ?.let(
            (rate) =>
                balance.$2.convert(rate: rate, to: fiatCurrency) as FiatAmount,
          ),
    );
  }
}
