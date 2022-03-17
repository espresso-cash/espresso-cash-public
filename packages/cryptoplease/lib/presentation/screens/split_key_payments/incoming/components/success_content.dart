import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/common_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SuccessContent extends StatelessWidget {
  const SuccessContent({Key? key}) : super(key: key);

  void _onSuccessConfirmed(BuildContext context) {
    context
        .read<SplitKeyIncomingPaymentBloc>()
        .add(const SplitKeyIncomingPaymentEvent.cleared());

    final account = context.read<AccountsBloc>().state.account!;
    context
        .read<BalancesBloc>()
        .add(BalancesEvent.requested(address: account.address));
  }

  @override
  Widget build(BuildContext context) => CommonSuccess(
        text: context.l10n.splitKeySuccessMessage,
        onClosePressed: () => _onSuccessConfirmed(context),
      );
}
