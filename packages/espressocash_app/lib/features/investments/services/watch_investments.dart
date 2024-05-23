import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../balances/data/token_balance_repository.dart';
import '../../tokens/token.dart';

@injectable
class WatchInvestments {
  const WatchInvestments(this._balancesRepository);

  final TokenBalancesRepository _balancesRepository;

  Stream<IList<Token>> call() => _balancesRepository
      .watchUserTokens()
      .map((event) => event.toIList())
      .distinct();
}
