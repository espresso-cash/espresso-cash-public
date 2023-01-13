import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di.dart';
import '../../../../../ui/transfer_status/transfer_error.dart';
import '../../../../../ui/transfer_status/transfer_progress.dart';
import '../../../../../ui/transfer_status/transfer_success.dart';
import '../../../../l10n/l10n.dart';
import '../bl/bloc.dart';
import '../bl/repository.dart';
import '../cancel_outgoing_payment.dart';

class COPScreen extends StatefulWidget {
  const COPScreen({
    super.key,
    required this.paymentId,
  });

  final String paymentId;

  @override
  State<COPScreen> createState() => _COPScreenState();
}

class _COPScreenState extends State<COPScreen> {
  late final Stream<CancelOutgoingPayment?> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<COPRepository>().watch(widget.paymentId);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<CancelOutgoingPayment?>(
        stream: _stream,
        builder: (context, state) {
          final cancel = state.data;

          return BlocBuilder<COPBloc, COPState>(
            builder: (context, state) {
              if (cancel == null) return const TransferProgress();
              if (state.contains(cancel.paymentId)) {
                return const TransferProgress();
              }

              return cancel.status.maybeMap(
                success: (_) => TransferSuccess(
                  onOkPressed: () => context.router.pop(),
                  content: context.l10n.outgoingPaymentCanceled,
                ),
                orElse: () => TransferError(
                  onBack: () => context.router.pop(),
                  onRetry: () => context
                      .read<COPBloc>()
                      .add(COPEvent.process(cancel.paymentId)),
                ),
              );
            },
          );
        },
      );
}
