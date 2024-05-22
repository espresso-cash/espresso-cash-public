import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../balances/data/token_balance_repository.dart';
import '../../conversion_rates/services/watch_token_fiat_balance.dart';
import '../../tokens/token.dart';

@injectable
class WatchInvestments {
  const WatchInvestments(
    this._watchUserFiatBalance,
    this._balancesRepository,
  );

  final WatchTokenFiatBalance _watchUserFiatBalance;
  final TokenBalancesRepository _balancesRepository;

  static final Decimal _minimumUsdAmount = Decimal.parse('0.01');

  Stream<IList<Token>> call() => _balancesRepository
      .watchUserTokens()
      .map((event) => event.where((e) => e != Token.usdc))
      .flatMap(
        (tokens) => Rx.combineLatest(
          tokens.map(
            (t) => _watchUserFiatBalance(t).$1.map(
                  (event) => (t, event?.decimal ?? Decimal.zero),
                ),
          ),
          (values) =>
              values.where((v) => v.$2 >= _minimumUsdAmount).map((e) => e.$1),
        ),
      )
      .map((event) => event.toIList())
      .distinct();
}
