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

  CpStatusType _getStatus(OutgoingStatus status) {
    switch (status) {
      case OutgoingStatus.success:
        return CpStatusType.success;
      case OutgoingStatus.canceled:
        return CpStatusType.error;
      case OutgoingStatus.ongoing:
        return CpStatusType.info;
    }
  }

  CpTimelineStatus _timelineStatusFromStatusType(OutgoingStatus status) {
    switch (status) {
      case OutgoingStatus.success:
        return CpTimelineStatus.success;
      case OutgoingStatus.ongoing:
        return CpTimelineStatus.inProgress;
      case OutgoingStatus.canceled:
        return CpTimelineStatus.failure;
    }
  }

  Widget _getBackground(OutgoingStatus status) {
    switch (status) {
      case OutgoingStatus.success:
        return Assets.icons.logoBgGreen.svg(alignment: Alignment.bottomCenter);
      case OutgoingStatus.canceled:
        return Assets.icons.logoBgRed.svg(alignment: Alignment.bottomCenter);
      case OutgoingStatus.ongoing:
        return Assets.icons.logoBgOrange.svg(alignment: Alignment.bottomCenter);
    }
  }

  Widget? _getStatusTitle(OutgoingStatus status) {
    if (status == OutgoingStatus.success) {
      return Text(context.l10n.splitKeySuccessMessage1);
    }
  }

  String _getStatusContent(OutgoingStatus status) {
    final transfer = widget.transfer;

    final amount =
        '${transfer.toAmount().decimal} ${transfer.toAmount().currency.symbol}';

    switch (status) {
      case OutgoingStatus.success:
        return context.l10n.splitKeySuccessMessage2;
      case OutgoingStatus.canceled:
        return context.l10n.transactionCanceled;
      case OutgoingStatus.ongoing:
        return context.l10n.splitKeyProgressOngoing(amount);
    }
  }

  List<CpTimelineItem> _buildTimeline({
    required OutgoingStatus status,
    required DateTime? date,
  }) {
    final transfer = widget.transfer;

    final amount =
        '${transfer.toAmount().decimal} ${transfer.toAmount().currency.symbol}';
    final created = transfer.created;

    return [
      CpTimelineItem(
        title: context.l10n.splitKeyProgressCreated,
        subtitle: created.formatDate(),
        trailing: amount,
      ),
      if (status == OutgoingStatus.ongoing) ...[
        CpTimelineItem(
          title: context.l10n.splitKeyProgressWaiting,
        ),
        CpTimelineItem(
          title: context.l10n.splitKeyProgressSuccess,
        ),
      ],
      if (status == OutgoingStatus.success) ...[
        CpTimelineItem(
          title: context.l10n.splitKeyProgressWithdrawn,
          subtitle: date?.formatDate(),
        ),
        CpTimelineItem(
          title: context.l10n.splitKeyProgressSuccess,
          subtitle: date?.formatDate(),
        ),
      ],
      if (status == OutgoingStatus.canceled)
        CpTimelineItem(
          title: context.l10n.splitKeyProgressCanceled,
          subtitle: date?.formatDate(),
        ),
    ];
  }

  int _getActive(OutgoingStatus status, int itemLength) {
    switch (status) {
      case OutgoingStatus.ongoing:
        return itemLength - 2;
      case OutgoingStatus.success:
        return itemLength - 1;
      case OutgoingStatus.canceled:
        return itemLength - 1;
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OutgoingTransferStatusBloc, OutgoingTransferStatusState>(
        builder: (context, state) {
          final isLoading = state.processingState.isProcessing;
          final status = state.transferStatus?.status ?? OutgoingStatus.ongoing;

          final items = _buildTimeline(
            status: status,
            date: state.transferStatus?.created,
          );

          return CpLoader(
            isLoading: isLoading,
            child: StatusScreen(
              onBackButtonPressed: () => context.router.pop(),
              title: context.l10n.splitKeyTransferTitle,
              statusType: _getStatus(status),
              statusTitle: _getStatusTitle(status),
              statusContent: Text(_getStatusContent(status)),
              backgroundImage: _getBackground(status),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    SizedBox(
                      height: 280,
                      child: CpTimeline(
                        items: items,
                        status: _timelineStatusFromStatusType(status),
                        active: _getActive(status, items.length),
                      ),
                    ),
                    if (status == OutgoingStatus.ongoing) ...[
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
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      );
}
