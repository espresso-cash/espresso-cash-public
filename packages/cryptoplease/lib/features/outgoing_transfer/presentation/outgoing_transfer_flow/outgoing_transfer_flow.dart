import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/direct_success_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/draft_screen.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/outgoing_transfer_flow/split_key_ready_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension SendFlowExt on BuildContext {
  /// Navigates to the [OutgoingTransferFlowScreen].
  ///
  /// If [autoSubmit] is true, it also automatically submits the transfer (sends
  /// the transaction).
  void navigateToOutgoingTransfer(
    OutgoingTransferId id, {
    GlobalKey<AutoRouterState>? routerKey,
    bool autoSubmit = true,
  }) {
    (routerKey?.currentState?.controller ?? router)
      ..popUntilRoot()
      ..navigate(OutgoingTransferFlowRoute(id: id));
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
                  splitKey: (t) => SplitKeyReadyScreen(transfer: t),
                  direct: (t) => DirectSuccessScreen(transfer: t),
                ),
              ) ??
              const DraftScreen(transfer: null);
        },
      );
}
