import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/tokens/token.dart';
import '../../../core/user_preferences.dart';
import '../../conversion_rates/services/watch_user_total_fiat_balance.dart';

@injectable
class WatchUserHasInvestments {
  const WatchUserHasInvestments(
    this._watchUserTotalFiatBalance,
    this._userPreferences,
  );

  final WatchUserTotalFiatBalance _watchUserTotalFiatBalance;
  final UserPreferences _userPreferences;

  ValueStream<bool> call() => _watchUserTotalFiatBalance(
        _userPreferences.fiatCurrency,
        ignoreTokens: [Token.usdc],
      ).map((it) => it.decimal != Decimal.zero).shareValue();
}
