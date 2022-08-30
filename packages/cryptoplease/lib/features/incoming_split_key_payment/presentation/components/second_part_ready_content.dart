import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/bloc.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/presentation/components/cancel_dialog.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
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

  void _onRetry() {
    // ignore: avoid-non-null-assertion, cannot be null here
    final wallet = context.read<AccountsBloc>().state.account!;
    final event = SplitKeyIncomingPaymentEvent.retried(
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

    return (error == null)
        ? const _ProgressView()
        : _ErrorView(
            error: error,
            onPressed: _onRetry,
          );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView({Key? key}) : super(key: key);

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
              child: Assets.icons.logoBgOrange.svg(),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    CpStatusWidget(
                      backgroundColor: CpColors.pendingBackgroundColor,
                      child: Text(
                        context.l10n.splitKeyTransactionLoading,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 52),
                    const Center(
                      child: CircularProgressIndicator(
                        color: CpColors.yellowColor,
                        strokeWidth: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    Key? key,
    required this.error,
    this.onPressed,
  }) : super(key: key);

  final SplitKeyIncomingPaymentError error;
  final VoidCallback? onPressed;

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
          leading: BackButton(onPressed: () => showCancelDialog(context)),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Assets.icons.logoBgRed.svg(),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    CpStatusWidget(
                      backgroundColor: CpColors.errorBackgroundColor,
                      child: Column(
                        children: [
                          Text(
                            context.l10n.splitKeyErrorMessage1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${context.l10n.splitKeyErrorMessage2} ${error.isRecoverable ? context.l10n.splitKeyErrorRetry : ''}',
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
                    const SizedBox(height: 140),
                    if (error.isRecoverable)
                      CpButton(
                        size: CpButtonSize.big,
                        width: double.infinity,
                        text: context.l10n.retry,
                        onPressed: onPressed,
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
