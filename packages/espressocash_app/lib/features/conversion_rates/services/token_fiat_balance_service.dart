import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../analytics/analytics_manager.dart';
import '../../balances/data/repository.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';

typedef CryptoFiatAmount = (CryptoAmount, FiatAmount);

@injectable
class TokenFiatBalanceService {
  const TokenFiatBalanceService(
    this._conversionRatesRepository,
    this._balancesRepository,
    this._analyticsManager,
  );

  final ConversionRatesRepository _conversionRatesRepository;
  final TokenBalancesRepository _balancesRepository;
  final AnalyticsManager _analyticsManager;

  static const _zeroFiat =
      FiatAmount(value: 0, fiatCurrency: defaultFiatCurrency);

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
      (cryptoAmount, rate) => rate == null
          ? null
          : cryptoAmount.convert(rate: rate, to: fiatCurrency) as FiatAmount,
    ).distinct();
  }

  Stream<FiatAmount> watchInvestmentsBalance() => _balancesRepository
      .watchUserTokens(ignoreTokens: [Token.usdc])
      .flatMap(
        (tokens) => Rx.combineLatest(
          tokens.map(watch),
          (values) => values
              .whereNotNull()
              .fold(_zeroFiat, (total, next) => (total + next) as FiatAmount),
        ),
      )
      .distinct()
      .doOnData(_logTotalCryptoBalance);

  Stream<FiatAmount> watchMainBalance() =>
      watch(Token.usdc).map((it) => it ?? _zeroFiat);

  Stream<IList<CryptoFiatAmount>> watchBalances() => _balancesRepository
      .watchTokenBalances(ignoreTokens: [Token.usdc])
      .flatMap(
        (cryptoAmounts) => Rx.combineLatest(
          cryptoAmounts.map((c) => watch(c.token).map((fiat) => (c, fiat))),
          (values) => values.map((e) => (e.$1, e.$2 ?? _zeroFiat)),
        ),
      )
      .map((amount) => amount.toIList())
      .map(
        (amounts) => amounts.sort((a, b) => b.$2.value.compareTo(a.$2.value)),
      )
      .distinct();

  void _logTotalCryptoBalance(Amount total) =>
      _analyticsManager.setTotalInvestmentsBalance(total.decimal);
}
