import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/direct_success_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/draft_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/split_key_ready_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
