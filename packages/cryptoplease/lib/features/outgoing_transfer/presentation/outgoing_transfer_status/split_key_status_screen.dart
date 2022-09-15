import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.gr.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/datetime.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/tx_creator_strategy.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/tx_processor.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_transfer_status_bloc/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_status/components/cancel_dialog.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_status/components/timeline_widget.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class SplitKeyStatusScreen extends StatelessWidget {
  const SplitKeyStatusScreen({super.key, required this.transfer});

  final OutgoingTransferSplitKey transfer;

  @override
  Widget build(BuildContext context) =>
      BlocProvider<OutgoingTransferStatusBloc>(
        create: (_) => OutgoingTransferStatusBloc(
          client: context.read<RpcClient>(),
          subscriptionClient: context.read<SubscriptionClient>(),
          account: context.read<MyAccount>(),
          txProcessor: TxProcessor(context.read<SolanaClient>()),
          txCreatorStrategy: context.read<TxCreatorStrategy>(),
          transfer: transfer,
        ),
        child: _SplitKeyStatusDetails(transfer),
      );
}

class _SplitKeyStatusDetails extends StatefulWidget {
  const _SplitKeyStatusDetails(this.transfer);

  final OutgoingTransferSplitKey transfer;

  @override
  State<_SplitKeyStatusDetails> createState() => _SplitKeyStatusDetailsState();
}

class _SplitKeyStatusDetailsState extends State<_SplitKeyStatusDetails> {
  @override
  void initState() {
    super.initState();
    context.read<OutgoingTransferStatusBloc>().add(
          const OutgoingTransferStatusEvent.load(),
        );
  }

  void onCancelPressed() {
    context
        .read<OutgoingTransferStatusBloc>()
        .add(const OutgoingTransferStatusEvent.cancelTransfer());
  }

  void onResendLinks() {
    context.router.push(SplitKeyReadyRoute(transfer: widget.transfer));
  }

  @override
  Widget build(BuildContext context) {
    final transfer = widget.transfer;

    final amount =
        '${transfer.toAmount().decimal} ${transfer.toAmount().currency.symbol}';
    final created = transfer.created;

    return BlocBuilder<OutgoingTransferStatusBloc, OutgoingTransferStatusState>(
      builder: (context, state) => state.map(
        ongoing: (s) => CpLoader(
          isLoading: s.processingState.isProcessing,
          child: _Ongoing(
            amount: amount,
            onResendLink: onResendLinks,
            onCancelTransfer: onCancelPressed,
          ),
        ),
        success: (val) => const _Success(),
        cancelled: (val) => const _Cancelled(),
        error: (val) => const _Error(),
      ),
    );
  }
}

class _Ongoing extends StatelessWidget {
  const _Ongoing({
    required this.amount,
    required this.onResendLink,
    required this.onCancelTransfer,
  });

  final String amount;
  final VoidCallback onResendLink;
  final VoidCallback onCancelTransfer;

  @override
  Widget build(BuildContext context) => StatusScreen(
        onBackButtonPressed: () => context.router.pop(),
        title: context.l10n.splitKeyTransferTitle,
        statusType: CpStatusType.info,
        statusContent: Text(
          context.l10n.splitKeyProgressOngoing(amount),
        ),
        backgroundImage:
            Assets.icons.logoBgOrange.svg(alignment: Alignment.bottomCenter),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              CpTimelineWidget(
                data: [
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressCreated,
                    subtitle: DateTime(2022, 1, 4).formatDate(),
                    trailing: amount,
                  ),
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressWaiting,
                    connectorColor: Colors.white,
                  ),
                ],
                backgroundColor: CpColors.infoBackgroundColor,
              ),
              const SizedBox(height: 90),
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.resendLink,
                onPressed: onResendLink,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => showCancelDialog(
                  context,
                  onCancelPressed: onCancelTransfer,
                ),
                child: Text(
                  context.l10n.cancelTransfer,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

class _Success extends StatelessWidget {
  const _Success();

  @override
  Widget build(BuildContext context) => StatusScreen(
        onBackButtonPressed: () => context.router.pop(),
        title: context.l10n.splitKeyTransferTitle,
        statusType: CpStatusType.success,
        statusTitle: Text(context.l10n.splitKeySuccessMessage1),
        statusContent: Text(context.l10n.splitKeySuccessMessage2),
        backgroundImage:
            Assets.icons.logoBgGreen.svg(alignment: Alignment.bottomCenter),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              CpTimelineWidget(
                data: [
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressCreated,
                    subtitle: 'Today at 2:57 PM',
                    trailing: 'amount',
                  ),
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressWithdrawn,
                    subtitle: 'Today at 2:57 PM',
                  ),
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressSuccess,
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
                backgroundColor: CpColors.successBackgroundColor,
              ),
            ],
          ),
        ),
      );
}

class _Cancelled extends StatelessWidget {
  const _Cancelled();

  @override
  Widget build(BuildContext context) => StatusScreen(
        onBackButtonPressed: () => context.router.pop(),
        title: context.l10n.splitKeyTransferTitle,
        statusType: CpStatusType.error,
        statusContent: Text(context.l10n.transactionCanceled),
        backgroundImage:
            Assets.icons.logoBgRed.svg(alignment: Alignment.bottomCenter),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              CpTimelineWidget(
                data: [
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressCreated,
                    subtitle: 'Today at 2:57 PM',
                    trailing: 'amount',
                  ),
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressCanceled,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
                backgroundColor: CpColors.errorBackgroundColor,
              ),
            ],
          ),
        ),
      );
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) => StatusScreen(
        onBackButtonPressed: () => context.router.pop(),
        title: context.l10n.splitKeyTransferTitle,
        statusType: CpStatusType.error,
        statusContent: Text(context.l10n.transactionCanceled),
        backgroundImage:
            Assets.icons.logoBgRed.svg(alignment: Alignment.bottomCenter),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              CpTimelineWidget(
                data: [
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressCreated,
                    subtitle: 'Today at 2:57 PM',
                    trailing: 'amount',
                  ),
                  CpTimelineData(
                    title: context.l10n.splitKeyProgressCanceled,
                    icon: const Icon(Icons.crop_square_sharp),
                  ),
                ],
                backgroundColor: CpColors.errorBackgroundColor,
              ),
            ],
          ),
        ),
      );
}
