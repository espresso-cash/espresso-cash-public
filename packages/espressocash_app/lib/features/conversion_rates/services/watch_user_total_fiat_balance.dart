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

  (Stream<Amount>, Amount) call({
    Iterable<Token> ignoreTokens = const [],
  }) =>
      (
        _balancesRepository
            .watchUserTokens()
            .map((tokens) => tokens.where((t) => !ignoreTokens.contains(t)))
            .flatMap(
              (tokens) => Rx.combineLatest(
                tokens.map((t) => _watchUserFiatBalance(t).$1),
                (values) => values.whereNotNull().fold(
                      Amount.zero(currency: defaultFiatCurrency),
                      (total, next) => total + next,
                    ),
              ),
            )
            .distinct(),
        _balancesRepository
            .readUserTokens()
            .where((t) => !ignoreTokens.contains(t))
            .map((t) => _watchUserFiatBalance(t).$2)
            .whereNotNull()
            .fold(
              Amount.zero(currency: defaultFiatCurrency),
              (total, next) => total + next,
            ),
      );
}
