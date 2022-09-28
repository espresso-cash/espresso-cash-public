import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.gr.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/datetime.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/tx_creator_strategy.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/tx_processor.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_transfer_status_bloc/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_status/components/cancel_dialog.dart';
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
          repository: context.read<OutgoingTransferRepository>(),
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
          const OutgoingTransferStatusEvent.init(),
        );
  }

  void onCancelPressed() {
    context
        .read<OutgoingTransferStatusBloc>()
        .add(const OutgoingTransferStatusEvent.cancelled());
  }

  void onResendLinks() {
    context.router.push(SplitKeyReadyRoute(transfer: widget.transfer));
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OutgoingTransferStatusBloc, OutgoingTransferStatusState>(
        builder: (context, state) {
          final transfer = widget.transfer;

          final amount =
              '${transfer.toAmount().decimal} ${transfer.toAmount().currency.symbol}';
          final created = transfer.created;

          final firstItem = CpTimelineItem(
            title: context.l10n.splitKeyProgressCreated,
            subtitle: created.formatDate(),
            trailing: amount,
          );

          return state.map(
            ongoing: (state) => CpLoader(
              isLoading: state.processingState.isProcessing,
              child: _Ongoing(
                amount: amount,
                onResendLinks: onResendLinks,
                onCancelPressed: onCancelPressed,
                items: [
                  firstItem,
                  CpTimelineItem(
                    title: context.l10n.splitKeyProgressWaiting,
                  ),
                  CpTimelineItem(
                    title: context.l10n.splitKeyProgressSuccess,
                  ),
                ],
              ),
            ),
            success: (state) => _Success(
              items: [
                firstItem,
                CpTimelineItem(
                  title: context.l10n.splitKeyProgressWithdrawn,
                  subtitle: state.executedDate?.formatDate(),
                ),
                CpTimelineItem(
                  title: context.l10n.splitKeyProgressSuccess,
                  subtitle: state.executedDate?.formatDate(),
                ),
              ],
            ),
            cancelled: (state) => _Cancelled(
              items: [
                firstItem,
                CpTimelineItem(
                  title: context.l10n.splitKeyProgressCanceled,
                  subtitle: state.executedDate?.formatDate(),
                ),
              ],
            ),
          );
        },
      );
}

class _Ongoing extends StatelessWidget {
  const _Ongoing({
    required this.amount,
    required this.items,
    required this.onResendLinks,
    required this.onCancelPressed,
  });

  final String amount;
  final List<CpTimelineItem> items;
  final VoidCallback onResendLinks;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) => StatusScreen(
        onBackButtonPressed: () => context.router.pop(),
        title: context.l10n.splitKeyTransferTitle,
        statusType: CpStatusType.info,
        statusContent: Text(context.l10n.splitKeyProgressOngoing(amount)),
        backgroundImage:
            Assets.icons.logoBgOrange.svg(alignment: Alignment.bottomCenter),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              SizedBox(
                height: 280,
                child: CpTimeline(
                  items: items,
                  status: CpTimelineStatus.inProgress,
                  active: items.length - 2,
                ),
              ),
              const SizedBox(height: 90),
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.resendLink,
                onPressed: onResendLinks,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => showCancelDialog(
                  context,
                  onCancelPressed: onCancelPressed,
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
  const _Success({required this.items});

  final List<CpTimelineItem> items;

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
              SizedBox(
                height: 280,
                child: CpTimeline(
                  items: items,
                  status: CpTimelineStatus.success,
                  active: items.length - 1,
                ),
              ),
            ],
          ),
        ),
      );
}

class _Cancelled extends StatelessWidget {
  const _Cancelled({required this.items});

  final List<CpTimelineItem> items;

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
              SizedBox(
                height: 280,
                child: CpTimeline(
                  items: items,
                  status: CpTimelineStatus.failure,
                  active: items.length - 1,
                ),
              ),
            ],
          ),
        ),
      );
}
