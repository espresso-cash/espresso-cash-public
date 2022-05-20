import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/split_key_payments/incoming/components/cancel_dialog.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SecondPartReadyContent extends StatefulWidget {
  const SecondPartReadyContent({Key? key, required this.payment})
      : super(key: key);

  final PaymentSecondPartReady payment;

  @override
  State<SecondPartReadyContent> createState() => _SecondPartReadyContentState();
}

class _SecondPartReadyContentState extends State<SecondPartReadyContent> {
  void _onSubmit() {
    // ignore: avoid-non-null-assertion, cannot be null here
    final wallet = context.read<AccountsBloc>().state.account!;
    final event = SplitKeyIncomingPaymentEvent.paymentRequested(
      recipient: wallet.address,
    );
    context.read<SplitKeyIncomingPaymentBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
    if (_shouldTriggerSubmit) _onSubmit();
  }

  bool get _shouldTriggerSubmit =>
      widget.payment.processingState.maybeWhen(none: T, orElse: F) &&
      context.read<AccountsBloc>().state.account != null;

  @override
  Widget build(BuildContext context) {
    final error = widget.payment.processingState.maybeWhen(
      error: identity,
      orElse: () => null,
    );
    final isLoading =
        widget.payment.processingState.maybeWhen(processing: T, orElse: F);

    final child = Scaffold(
      backgroundColor: Colors.white,
      appBar: CpAppBar(
        hasBorder: false,
        leading: BackButton(
          onPressed: () => showCancelDialog(context),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              context.l10n.splitKeySecondLinkReadyTitle,
              style: Theme.of(context).textTheme.headline2?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: CpColors.primaryTextColor,
                  ),
            ),
            const SizedBox(height: 20),
            if (error != null) _ErrorView(error: error),
            const Spacer(),
            if (error != null)
              CpBottomButton(
                text: context.l10n.retry,
                onPressed: _onSubmit,
              ),
          ],
        ),
      ),
    );

    return CpLoader(isLoading: isLoading, child: child);
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({Key? key, required this.error}) : super(key: key);

  final SplitKeyIncomingPaymentError error;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Text(
          error.maybeWhen(
            consumed: () => context.l10n.splitKeyTransactionErrorConsumed,
            orElse: () => context.l10n.splitKeyTransactionError,
          ),
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: CpColors.primaryColor,
                fontSize: 24,
              ),
        ),
      );
}
