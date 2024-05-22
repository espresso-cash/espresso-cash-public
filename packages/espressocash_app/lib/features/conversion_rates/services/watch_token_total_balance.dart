import 'package:collection/collection.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../balances/data/token_balance_repository.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import 'watch_token_fiat_balance.dart';

@injectable
class WatchTotalTokenFiatBalance {
  const WatchTotalTokenFiatBalance(
    this._balancesRepository,
    this._watchUserFiatBalance,
  );

  final TokenBalancesRepository _balancesRepository;
  final WatchTokenFiatBalance _watchUserFiatBalance;

  (Stream<Amount>, Amount) call() => (
        _balancesRepository
            .watchUserTokens()
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
            .map((t) => _watchUserFiatBalance(t).$2)
            .whereNotNull()
            .fold(
              Amount.zero(currency: defaultFiatCurrency),
              (total, next) => total + next,
            ),
      );
}
