import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/bloc.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: CpAppBar(
          hasBorder: false,
          title: Text(
            context.l10n.splitKeyTransferTitle,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: CpColors.primaryTextColor,
                ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Assets.icons.logoBgGreen
                  .svg(alignment: Alignment.bottomCenter),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    CpStatusWidget(
                      backgroundColor: CpColors.successBackgroundColor,
                      child: Column(
                        children: [
                          Text(
                            context.l10n.splitKeySuccessMessage1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            context.l10n.splitKeySuccessMessage2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
            ),
          ],
        ),
      );
}
