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

  CpStatusType _getStatus(OutgoingTransferStatus? status) {
    if (status == null) {
      return CpStatusType.info;
    }

    switch (status.status) {
      case OutgoingStatus.success:
        return CpStatusType.success;
      case OutgoingStatus.canceled:
        return CpStatusType.error;
      case OutgoingStatus.ongoing:
        return CpStatusType.info;
    }
  }

  Color _getColor(OutgoingTransferStatus? status) {
    if (status == null) {
      return CpColors.infoBackgroundColor;
    }

    switch (status.status) {
      case OutgoingStatus.success:
        return CpColors.successBackgroundColor;
      case OutgoingStatus.canceled:
        return CpColors.errorBackgroundColor;
      case OutgoingStatus.ongoing:
        return CpColors.infoBackgroundColor;
    }
  }

  Widget _getBackground(OutgoingTransferStatus? status) {
    if (status == null) {
      return Assets.icons.logoBgOrange.svg(alignment: Alignment.bottomCenter);
    }

    switch (status.status) {
      case OutgoingStatus.success:
        return Assets.icons.logoBgGreen.svg(alignment: Alignment.bottomCenter);
      case OutgoingStatus.canceled:
        return Assets.icons.logoBgRed.svg(alignment: Alignment.bottomCenter);
      case OutgoingStatus.ongoing:
        return Assets.icons.logoBgOrange.svg(alignment: Alignment.bottomCenter);
    }
  }

  Widget? _getStatusTitle(OutgoingTransferStatus? status) {
    if (status?.status == OutgoingStatus.success) {
      return Text(context.l10n.splitKeySuccessMessage1);
    }
  }

  String _getStatusContent(OutgoingTransferStatus? status) {
    final transfer = widget.transfer;

    final amount =
        '${transfer.toAmount().decimal} ${transfer.toAmount().currency.symbol}';

    if (status == null) {
      return context.l10n.splitKeyProgressOngoing(amount);
    }

    switch (status.status) {
      case OutgoingStatus.success:
        return context.l10n.splitKeySuccessMessage2;
      case OutgoingStatus.canceled:
        return context.l10n.transactionCanceled;
      case OutgoingStatus.ongoing:
        return context.l10n.splitKeyProgressOngoing(amount);
    }
  }

  List<CpTimelineData> _buildTimeline(OutgoingTransferStatus? status) {
    final transfer = widget.transfer;

    final amount =
        '${transfer.toAmount().decimal} ${transfer.toAmount().currency.symbol}';
    final created = transfer.created;

    return [
      CpTimelineData(
        title: context.l10n.splitKeyProgressCreated,
        subtitle: created.formatDate(),
        trailing: amount,
      ),
      if (status == null)
        CpTimelineData(
          title: context.l10n.splitKeyProgressWaiting,
          connectorColor: Colors.white,
        ),
      if (status?.status == OutgoingStatus.success) ...[
        CpTimelineData(
          title: context.l10n.splitKeyProgressWithdrawn,
          subtitle: status?.created?.formatDate(),
        ),
        CpTimelineData(
          title: context.l10n.splitKeyProgressSuccess,
          subtitle: status?.created?.formatDate(),
          icon: const Icon(
            Icons.check,
            color: Colors.white,
            size: 16,
          ),
        ),
      ],
      if (status?.status == OutgoingStatus.canceled)
        CpTimelineData(
          title: context.l10n.splitKeyProgressCanceled,
          subtitle: status?.created?.formatDate(),
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 16,
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OutgoingTransferStatusBloc, OutgoingTransferStatusState>(
        builder: (context, state) {
          final status = state.transferStatus;
          final isLoading = state.processingState.isProcessing;

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
                    CpTimelineWidget(
                      data: _buildTimeline(status),
                      backgroundColor: _getColor(status),
                    ),
                    if (status == null) ...[
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
