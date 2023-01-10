import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di.dart';
import '../../../../../ui/transfer_status/transfer_error.dart';
import '../../../../../ui/transfer_status/transfer_progress.dart';
import '../../../../../ui/transfer_status/transfer_success.dart';
import '../../../../l10n/l10n.dart';
import '../../models/outgoing_split_key_payment.dart';
import '../oskp_cancel/bloc.dart';
import '../oskp_cancel/oskp_cancel.dart';
import '../oskp_cancel/repository.dart';

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
                  content: context.l10n.canceling,
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
