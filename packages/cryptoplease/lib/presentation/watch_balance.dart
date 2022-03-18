import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/user_preferences.dart';
import 'package:cryptoplease/presentation/conversion_rates.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension WatchBalance on BuildContext {
  Amount watchUserCryptoBalance(Token token) =>
      watch<BalancesBloc>().state.balances[token] ??
      Amount.zero(currency: Currency.crypto(token: token));

  Amount? watchUserFiatBalance(Token token) {
    final fiatCurrency = watch<UserPreferences>().fiatCurrency;
    final conversionRate = watchConversionRate(from: token, to: fiatCurrency);
    if (conversionRate == null) return null;

    return watchUserCryptoBalance(token)
        .convert(rate: conversionRate, to: fiatCurrency);
  }

  Amount watchUserTotalFiatBalance(Currency currency) => watch<BalancesBloc>()
      .state
      .balances
      .keys
      .map(watchUserFiatBalance)
      .whereType<Amount>()
      .fold(
        Amount.zero(currency: currency),
        (total, next) => total + next,
      );
}
