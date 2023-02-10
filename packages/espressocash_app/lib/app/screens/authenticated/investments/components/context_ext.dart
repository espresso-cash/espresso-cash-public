import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../core/user_preferences.dart';

extension InvestmentExt on BuildContext {
  bool watchUserHasInvestments() => watchUserTotalFiatBalance(
        watch<UserPreferences>().fiatCurrency,
        ignoreTokens: [Token.usdc],
      ).let((it) => it.decimal != Decimal.zero);
}
