import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../balances/data/repository.dart';
import '../../tokens/token.dart';

@injectable
class WatchInvestments {
  const WatchInvestments(this._balancesRepository);

  final TokenBalancesRepository _balancesRepository;

  Stream<IList<Token>> call() => _balancesRepository
      .watchUserTokens()
      .map((event) => event.sortedBy((element) => element.name).toIList())
      .distinct();
}
