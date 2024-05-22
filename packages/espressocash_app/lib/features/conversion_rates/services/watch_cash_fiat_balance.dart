import 'package:dfunc/dfunc.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../balances/data/cash_balance_repository.dart';

import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../data/cash_repository.dart';

@injectable
class WatchUserCashBalance {
  const WatchUserCashBalance(
    this._conversionRatesRepository,
    this._balancesRepository,
  );

  final CashConversionRatesRepository _conversionRatesRepository;
  final CashBalanceRepository _balancesRepository;

  (Stream<FiatAmount>, FiatAmount) call() {
    const fiatCurrency = defaultFiatCurrency;
    final conversionRate =
        _conversionRatesRepository.watchRate(to: fiatCurrency);

    final balance = _balancesRepository.watch();

    return (
      Rx.combineLatest2(
        balance.$1,
        conversionRate,
        (cryptoAmount, rate) => rate == null
            ? const FiatAmount(value: 0, fiatCurrency: Currency.usd)
            : cryptoAmount.convert(rate: rate, to: fiatCurrency) as FiatAmount,
      ).distinct(),
      _conversionRatesRepository.readRate(to: fiatCurrency)?.let(
                (rate) => balance.$2.convert(rate: rate, to: fiatCurrency)
                    as FiatAmount,
              ) ??
          const FiatAmount(value: 0, fiatCurrency: Currency.usd),
    );
  }
}
