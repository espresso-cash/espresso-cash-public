import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../../balances/data/balances_repository.dart';
import 'watch_user_fiat_balance.dart';

@injectable
class WatchUserTotalFiatBalance {
  const WatchUserTotalFiatBalance(
    this._watchUserFiatBalance,
    this._balancesRepository,
  );

  final WatchUserFiatBalance _watchUserFiatBalance;
  final BalancesRepository _balancesRepository;

  ValueStream<Amount> call(
    Currency currency, {
    Iterable<Token> ignoreTokens = const [],
  }) =>
      _balancesRepository
          .watchUserTokens()
          .map((event) => event.where((token) => !ignoreTokens.contains(token)))
          .flatMap(
            (tokens) => Rx.combineLatest(
              tokens.map(_watchUserFiatBalance.call),
              (values) => values.whereNotNull().fold(
                    Amount.zero(currency: currency),
                    (total, next) => total + next,
                  ),
            ),
          )
          .shareValue();
}
