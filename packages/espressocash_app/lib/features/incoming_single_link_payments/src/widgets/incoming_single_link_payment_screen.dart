import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/single_key_payments.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/transfer_status/transfer_error.dart';
import '../../../../ui/transfer_status/transfer_progress.dart';
import '../../../../ui/transfer_status/transfer_success.dart';
import '../../../incoming_split_key_payments/widgets/invalid_escrow_error_widget.dart';
import '../../widgets/extensions.dart';
import '../bl/islp_payment.dart';
import '../bl/islp_repository.dart';

class IncomingSingleLinkScreen extends StatefulWidget {
  const IncomingSingleLinkScreen({
    super.key,
    required this.data,
  });

  final SingleKeyPaymentData data;

  @override
  State<IncomingSingleLinkScreen> createState() =>
      _IncomingSingleLinkScreenState();
}

class _IncomingSingleLinkScreenState extends State<IncomingSingleLinkScreen> {
  Stream<IncomingSingleLinkPayment?>? _payment;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final id = await context.createISLP(widget.data);

    if (!mounted) return;
    setState(() {
      _payment = sl<ISLPRepository>().watch(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading = TransferProgress(
      onBack: () => context.router.pop(),
    );

    if (_payment == null) return loading;

    return StreamBuilder<IncomingSingleLinkPayment?>(
      stream: _payment,
      builder: (context, state) {
        final payment = state.data;

        if (payment == null) {
          return loading;
        }

        return payment.status.maybeMap(
          success: (_) => TransferSuccess(
            onBack: () => context.router.pop(),
            onOkPressed: () => context.router.pop(),
            statusContent: context.l10n.moneyReceived,
          ),
          txFailure: (it) {
            if (it.reason == TxFailureReason.escrowFailure) {
              return const InvalidEscrowErrorWidget();
            }

            return TransferError(
              onBack: () => context.router.pop(),
              onRetry: () => context.retryISLP(payment),
            );
          },
          orElse: () => TransferProgress(
            onBack: () => context.router.pop(),
          ),
        );
      },
    );
  }
}
