import 'package:cryptoplease/app/components/status_screen.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SuccessContent extends StatelessWidget {
  const SuccessContent({Key? key}) : super(key: key);

  void _onSuccessConfirmed(BuildContext context) {
    context
        .read<SplitKeyIncomingPaymentBloc>()
        .add(const SplitKeyIncomingPaymentEvent.cleared());

    // ignore: avoid-non-null-assertion, cannot be null here
    final account = context.read<AccountsBloc>().state.account!;
    context
        .read<BalancesBloc>()
        .add(BalancesEvent.requested(address: account.address));
  }

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        status: CpStatusType.success,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              CpStatusWidget(
                status: CpStatusType.success,
                title: Text(context.l10n.splitKeySuccessMessage1),
                content: Text(context.l10n.splitKeySuccessMessage2),
              ),
              const SizedBox(height: 160),
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.ok,
                onPressed: () => _onSuccessConfirmed(context),
              )
            ],
          ),
        ),
      );
}
