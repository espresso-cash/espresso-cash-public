import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di.dart';
import '../../../../features/activities/module.dart';
import '../../../../features/outgoing_split_key_payments/module.dart';
import '../../../../ui/transfer_status/transfer_error.dart';
import '../../../../ui/transfer_status/transfer_progress.dart';
import '../../../../ui/transfer_status/transfer_success.dart';

class OSKPCancelScreen extends StatefulWidget {
  const OSKPCancelScreen({
    super.key,
    required this.payment,
  });

  final OutgoingSplitKeyPayment payment;

  @override
  State<OSKPCancelScreen> createState() => _OSKPCancelScreenState();
}

class _OSKPCancelScreenState extends State<OSKPCancelScreen> {
  late final Stream<OSKPCancel?> _cancel;

  @override
  void initState() {
    super.initState();
    _cancel = sl<OSKPCancelRepository>().watch(widget.payment.id);
    context
        .read<OSKPCancelBloc>()
        .add(OSKPCancelEvent.cancelRequested(widget.payment));
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OSKPCancel?>(
        stream: _cancel,
        builder: (context, state) {
          final cancel = state.data;

          return BlocBuilder<OSKPCancelBloc, OSKPCancelState>(
            builder: (context, state) {
              if (cancel == null) return const TransferProgress();
              if (state.contains(cancel.oskpId)) {
                return const TransferProgress();
              }

              return cancel.status.maybeMap(
                success: (_) => TransferSuccess(
                  onOkPressed: () => context.router.pop(),
                ),
                orElse: () => TransferError(
                  onBack: () => context.router.pop(),
                  onRetry: () => context
                      .read<OSKPCancelBloc>()
                      .add(OSKPCancelEvent.process(cancel.oskpId)),
                ),
              );
            },
          );
        },
      );
}
