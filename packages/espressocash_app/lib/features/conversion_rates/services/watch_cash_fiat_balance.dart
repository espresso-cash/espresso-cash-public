import 'package:dfunc/dfunc.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../balances/data/cash_balance_repository.dart';

import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';

@injectable
class WatchUserCashBalance {
  const WatchUserCashBalance(
    this._conversionRatesRepository,
    this._balancesRepository,
  );

  final ConversionRatesRepository _conversionRatesRepository;
  final CashBalanceRepository _balancesRepository;

  (Stream<FiatAmount>, FiatAmount) call() {
    const fiatCurrency = defaultFiatCurrency;
    const token = Token.usdc;
    final conversionRate = _conversionRatesRepository
        .watchRate(const CryptoCurrency(token: token), to: fiatCurrency);

    final balance = _balancesRepository.watch();

    return (
      Rx.combineLatest2(
        balance.$1,
        conversionRate,
        (cryptoAmount, rate) => rate == null
            ? const FiatAmount(value: 0, fiatCurrency: Currency.usd)
            : cryptoAmount.convert(rate: rate, to: fiatCurrency) as FiatAmount,
      ).distinct(),
      _conversionRatesRepository
              .readRate(const CryptoCurrency(token: token), to: fiatCurrency)
              ?.let(
                (rate) => balance.$2.convert(rate: rate, to: fiatCurrency)
                    as FiatAmount,
              ) ??
          const FiatAmount(value: 0, fiatCurrency: Currency.usd),
    );
  }
}
