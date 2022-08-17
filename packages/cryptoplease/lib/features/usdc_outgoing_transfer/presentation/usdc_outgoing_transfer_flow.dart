import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.gr.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/draft_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/split_key_ready_screen.dart';
import 'package:cryptoplease/features/usdc_outgoing_transfer/bl/usdc_outgoing_transfers_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension SendUsdcFlowExt on BuildContext {
  /// Navigates to the [UsdcOutgoingTransferFlowScreen].
  ///
  /// If [autoSubmit] is true, it also automatically submits the transfer (sends
  /// the transaction).
  void navigateToUsdcOutgoingTransfer(
    OutgoingTransferId id, {
    bool autoSubmit = true,
  }) {
    router.navigate(UsdcOutgoingTransferFlowRoute(id: id));
    if (autoSubmit) {
      read<UsdcOutgoingTransfersBloc>().add(
        UsdcOutgoingTransfersEvent.submitted(id),
      );
    }
  }
}

class UsdcOutgoingTransferFlowScreen extends StatefulWidget {
  const UsdcOutgoingTransferFlowScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final OutgoingTransferId id;

  @override
  State<UsdcOutgoingTransferFlowScreen> createState() =>
      _UsdcOutgoingTransferFlowScreenState();
}

class _UsdcOutgoingTransferFlowScreenState
    extends State<UsdcOutgoingTransferFlowScreen> {
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
                  splitKey: (t) => SplitKeyReadyScreen(transfer: t),
                  direct: (_) => null,
                ),
              ) ??
              const DraftScreen(transfer: null);
        },
      );
}
