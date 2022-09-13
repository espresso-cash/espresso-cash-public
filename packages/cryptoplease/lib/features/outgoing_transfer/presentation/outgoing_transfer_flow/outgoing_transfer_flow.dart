import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/components/timeline_widget.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/direct_success_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/draft_screen.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension SendFlowExt on BuildContext {
  /// Navigates to the [OutgoingTransferFlowScreen].
  ///
  /// If [autoSubmit] is true, it also automatically submits the transfer (sends
  /// the transaction).
  void navigateToOutgoingTransfer(
    OutgoingTransferId id, {
    bool autoSubmit = true,
  }) {
    router.navigate(OutgoingTransferFlowRoute(id: id));
    if (autoSubmit) {
      read<OutgoingTransfersBloc>().add(OutgoingTransfersEvent.submitted(id));
    }
  }
}

class OutgoingTransferFlowScreen extends StatefulWidget {
  const OutgoingTransferFlowScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<OutgoingTransferFlowScreen> createState() =>
      _OutgoingTransferFlowScreenState();
}

class _OutgoingTransferFlowScreenState
    extends State<OutgoingTransferFlowScreen> {
  late final Stream<OutgoingTransfer> _payment =
      context.read<OutgoingTransferRepository>().watchPayment(widget.id);

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingTransfer>(
        stream: _payment,
        builder: (context, snapshot) {
          final transfer = snapshot.data;

          return transfer?.state.map(
                draft: (_) => DraftScreen(transfer: transfer),
                ready: (_) => transfer.map(
                  // splitKey: (t) => SplitKeyReadyScreen(transfer: t), //TODO
                  splitKey: (t) => SplitKeyStatusScreen(transfer: t),
                  direct: (t) => DirectSuccessScreen(transfer: t),
                ),
              ) ??
              const DraftScreen(transfer: null);
        },
      );
}

class SplitKeyStatusScreen extends StatelessWidget {
  const SplitKeyStatusScreen({super.key, required this.transfer});

  final OutgoingTransferSplitKey transfer;

  @override
  Widget build(BuildContext context) => StatusScreen(
        onBackButtonPressed: () => context.router.pop(),
        title: context.l10n.splitKeyTransferTitle,
        statusType: CpStatusType.info,
        statusContent: Text(
          'Sending ${transfer.toAmount().decimal} ${transfer.toAmount().currency.symbol} using secure links...',
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
                    title: 'Links are created',
                    subtitle: 'Today at 2:57 PM',
                    trailing: '12.34 USDC',
                  ),
                  CpTimelineData(
                    title: 'Waiting for the receiver to withdraw the funds',
                    connectorColor: Colors.white,
                  ),
                  CpTimelineData(
                    title: 'Money has been successfully received',
                    // icon: const Icon(Icons.check),
                    iconColor: Colors.white,
                  ),
                ],
                backgroundColor: CpColors.infoBackgroundColor,
              ),
              const SizedBox(height: 60),
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: 'Resend Links',
                onPressed: () =>
                    context.router.push(SplitKeyReadyRoute(transfer: transfer)),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Cancel Transfer',
                  style: TextStyle(
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
