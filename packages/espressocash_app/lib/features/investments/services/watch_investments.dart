import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/tokens/token.dart';
import '../../balances/data/balances_repository.dart';
import '../../conversion_rates/services/watch_user_fiat_balance.dart';

@injectable
class WatchInvestments {
  const WatchInvestments(
    this._watchUserFiatBalance,
    this._balancesRepository,
  );

  final WatchUserFiatBalance _watchUserFiatBalance;
  final BalancesRepository _balancesRepository;

  static final Decimal _minimumUsdAmount = Decimal.parse('0.01');

  ValueStream<IList<Token>> call({
    required bool displayEmptyBalances,
  }) =>
      _balancesRepository
          .watchUserTokens()
          .map((event) => event.where((e) => e != Token.usdc))
          .flatMap(
            (tokens) => displayEmptyBalances
                ? Stream.value(tokens)
                : Rx.combineLatest(
                    tokens.map(
                      (t) => _watchUserFiatBalance(t)
                          .map((event) => (t, event?.decimal ?? Decimal.zero)),
                    ),
                    (values) => values
                        .where((v) => v.$2 >= _minimumUsdAmount)
                        .map((e) => e.$1),
                  ),
          )
          .map((event) => event.toIList())
          .shareValue();
}
