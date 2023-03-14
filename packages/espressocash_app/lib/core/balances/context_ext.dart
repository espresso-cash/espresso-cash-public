import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config.dart';
import '../accounts/bl/account.dart';
import '../accounts/bl/ec_wallet.dart';
import 'bl/balances_bloc.dart';

extension BalancesExt on BuildContext {
  void notifyBalanceAffected() {
    final bloc = read<BalancesBloc>();
    final account = read<MyAccount>();

    final ethWallet =
        (account.wallet as LocalWallet).wallet?.getAddressForCoin(ethCoinId);

    bloc.add(
      BalancesEvent.requested(
        address: account.address,
        ethAddress: ethWallet,
      ),
    );
  }
}
