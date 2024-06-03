import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../balances/data/token_balance_repository.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import 'watch_token_fiat_balance.dart';

typedef CryptoFiatAmount = (CryptoAmount, FiatAmount);

@injectable
class WatchInvestments {
  const WatchInvestments(
    this._balancesRepository,
    this._watchTokenFiatBalance,
  );

  final TokenBalancesRepository _balancesRepository;
  final WatchTokenFiatBalance _watchTokenFiatBalance;

  Stream<IList<CryptoFiatAmount>> call() => _balancesRepository
      .watchTokenBalances() //TODO filter out USDC
      .flatMap(
        (tokens) => Rx.combineLatest(
          tokens.map(
            (t) => _watchTokenFiatBalance(t.token).map(
              (event) => (t, event),
            ),
          ),
          (values) => values.map(
            (e) => (
              e.$1,
              e.$2 ??
                  const FiatAmount(value: 0, fiatCurrency: defaultFiatCurrency),
            ),
          ),
        ),
      )
      .map((event) => event.toIList())
      .map((list) => list.sort((a, b) => b.$2.value.compareTo(a.$2.value)))
      .distinct();
}
