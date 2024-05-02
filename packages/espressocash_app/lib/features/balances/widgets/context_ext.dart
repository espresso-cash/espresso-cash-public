import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../accounts/models/account.dart';
import '../services/balances_bloc.dart';

extension BalancesExt on BuildContext {
  void notifyBalanceAffected() {
    final bloc = sl<BalancesBloc>();
    final account = sl<MyAccount>();

    bloc.add(BalancesEventRequested(address: account.address));
  }
}
