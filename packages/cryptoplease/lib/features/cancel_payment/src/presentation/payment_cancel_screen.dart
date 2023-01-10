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
import '../payment_cancel.dart';

class PaymentCancelScreen extends StatefulWidget {
  const PaymentCancelScreen({
    super.key,
    required this.paymentId,
  });

  final String paymentId;

  @override
  State<PaymentCancelScreen> createState() => _PaymentCancelScreenState();
}

class _PaymentCancelScreenState extends State<PaymentCancelScreen> {
  late final Stream<PaymentCancel?> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<PaymentCancelRepository>().watch(widget.paymentId);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PaymentCancel?>(
        stream: _stream,
        builder: (context, state) {
          final cancel = state.data;

          return BlocBuilder<PaymentCancelBloc, PaymentCancelState>(
            builder: (context, state) {
              if (cancel == null) return const TransferProgress();
              if (state.contains(cancel.paymentId)) {
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
                      .read<PaymentCancelBloc>()
                      .add(PaymentCancelEvent.process(cancel.paymentId)),
                ),
              );
            },
          );
        },
      );
}
