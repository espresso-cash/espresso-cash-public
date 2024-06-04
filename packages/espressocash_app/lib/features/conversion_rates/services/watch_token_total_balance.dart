import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../analytics/analytics_manager.dart';
import '../../balances/data/token_balance_repository.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import 'watch_token_fiat_balance.dart';

@injectable
class WatchTotalTokenFiatBalance {
  const WatchTotalTokenFiatBalance(
    this._balancesRepository,
    this._watchTokenFiatBalance,
    this._analyticsManager,
  );

  final TokenBalancesRepository _balancesRepository;
  final WatchTokenFiatBalance _watchTokenFiatBalance;
  final AnalyticsManager _analyticsManager;

  void _logTotalCryptoBalance(Amount total) =>
      _analyticsManager.setTotalCryptoBalance(total.decimal);

  Stream<Amount> call() => _balancesRepository
      .watchUserTokens(ignoreTokens: [Token.usdc])
      .flatMap(
        (tokens) => Rx.combineLatest(
          tokens.map(_watchTokenFiatBalance.call),
          (values) => values.whereNotNull().fold(
                Amount.zero(currency: defaultFiatCurrency),
                (total, next) => total + next,
              ),
        ),
      )
      .distinct()
      .doOnData(_logTotalCryptoBalance);
}
