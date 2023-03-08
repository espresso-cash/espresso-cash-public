import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/amount.dart';
import '../../../core/balances/bl/balances_bloc.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../../../core/user_preferences.dart';
import '../../conversion_rates/context_ext.dart';

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

  Amount watchUserTotalFiatBalance(
    Currency currency, {
    Iterable<Token> ignoreTokens = const [],
  }) =>
      watch<BalancesBloc>()
          .state
          .balances
          .keys
          .where((token) => !ignoreTokens.contains(token))
          .map(watchUserFiatBalance)
          .whereType<Amount>()
          .fold(
            Amount.zero(currency: currency),
            (total, next) => total + next,
          );
}
