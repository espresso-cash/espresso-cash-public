import 'package:injectable/injectable.dart';

import '../../../di.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import 'balances_bloc.dart';

@Singleton(scope: authScope)
class RefreshBalance {
  const RefreshBalance(this._wallet);

  final ECWallet _wallet;

  void call() =>
      sl<BalancesBloc>().add(BalancesEventRequested(address: _wallet.address));
}
