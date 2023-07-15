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

  ValueStream<Amount?> call(Token token) {
    final fiatCurrency = _userPreferences.fiatCurrency;

    final conversionRate = _conversionRatesRepository
        .watchRate(CryptoCurrency(token: token), to: fiatCurrency);

    return _balancesRepository.watch(token).withLatestFrom(
      conversionRate,
      (cryptoAmount, rate) {
        if (rate == null) return null;

        return cryptoAmount.convert(rate: rate, to: fiatCurrency);
      },
    ).shareValue();
  }
}
