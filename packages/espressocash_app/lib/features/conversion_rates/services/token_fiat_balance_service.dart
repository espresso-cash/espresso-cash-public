import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../balances/data/repository.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';

@injectable
class TokenFiatBalanceService {
  const TokenFiatBalanceService(
    this._conversionRatesRepository,
    this._balancesRepository,
  );

  final ConversionRatesRepository _conversionRatesRepository;
  final TokenBalancesRepository _balancesRepository;

  Stream<FiatAmount?> watch(Token token) {
    const fiatCurrency = defaultFiatCurrency;
    final conversionRate = _conversionRatesRepository.watchRate(
      CryptoCurrency(token: token),
      to: fiatCurrency,
    );

    final balance = _balancesRepository.watch(token);

    return Rx.combineLatest2(
      balance,
      conversionRate,
      (cryptoAmount, rate) {
        if (rate == null) return null;

        return cryptoAmount.convert(rate: rate, to: fiatCurrency) as FiatAmount;
      },
    ).distinct();
  }

  Stream<FiatAmount> watchTotal() => _balancesRepository
      .watchUserTokens(ignoreTokens: [Token.usdc])
      .flatMap(
        (tokens) => Rx.combineLatest(
          tokens.map(watch),
          (values) => values.whereNotNull().fold(
                const FiatAmount(value: 0, fiatCurrency: defaultFiatCurrency),
                (total, next) => (total + next) as FiatAmount,
              ),
        ),
      )
      .distinct();

  Stream<FiatAmount> watchMainBalance() => watch(Token.usdc).map(
        (it) => it ?? const FiatAmount(value: 0, fiatCurrency: Currency.usd),
      );
}
