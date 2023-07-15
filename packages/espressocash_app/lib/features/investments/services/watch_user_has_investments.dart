import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';

import '../../../core/tokens/token.dart';
import '../../conversion_rates/services/watch_user_total_fiat_balance.dart';

@injectable
class WatchUserHasInvestments {
  const WatchUserHasInvestments(
    this._watchUserTotalFiatBalance,
  );

  final WatchUserTotalFiatBalance _watchUserTotalFiatBalance;

  (Stream<bool>, bool) call() {
    final result = _watchUserTotalFiatBalance(ignoreTokens: [Token.usdc]);

    return (
      result.$1.map((it) => it.decimal != Decimal.zero).distinct(),
      result.$2.decimal != Decimal.zero,
    );
  }
}
