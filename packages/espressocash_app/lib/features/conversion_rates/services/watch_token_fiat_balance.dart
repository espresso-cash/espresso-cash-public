import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../balances/data/token_balance_repository.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';

@injectable
class WatchTokenFiatBalance {
  const WatchTokenFiatBalance(
    this._conversionRatesRepository,
    this._balancesRepository,
  );

  final ConversionRatesRepository _conversionRatesRepository;
  final TokenBalancesRepository _balancesRepository;

  (Stream<FiatAmount?>, FiatAmount?) call(Token token) {
    const fiatCurrency = defaultFiatCurrency;
    final conversionRate = _conversionRatesRepository.watchRate(
      CryptoCurrency(token: token),
      to: fiatCurrency,
    );

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
          )
    );
  }
}
