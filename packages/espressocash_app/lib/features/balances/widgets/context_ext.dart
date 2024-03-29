import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di.dart';
import '../../accounts/models/account.dart';
import '../services/balances_bloc.dart';

extension BalancesExt on BuildContext {
  void notifyBalanceAffected() {
    final bloc = sl<BalancesBloc>();
    final account = read<MyAccount>();

    bloc.add(BalancesEventRequested(address: account.address));
  }
}
