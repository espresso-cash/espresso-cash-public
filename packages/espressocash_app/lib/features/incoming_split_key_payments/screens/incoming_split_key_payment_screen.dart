import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/iskp_repository.dart';
import '../models/incoming_split_key_payment.dart';
import '../widgets/extensions.dart';
import '../widgets/invalid_escrow_error_widget.dart';

@RoutePage()
class IncomingSplitKeyPaymentScreen extends StatefulWidget {
  const IncomingSplitKeyPaymentScreen({
    super.key,
    required this.id,
  });

  static const route = IncomingSplitKeyPaymentRoute.new;

  final String id;

  @override
  State<IncomingSplitKeyPaymentScreen> createState() =>
      _IncomingSplitKeyPaymentScreenState();
}

class _IncomingSplitKeyPaymentScreenState
    extends State<IncomingSplitKeyPaymentScreen> {
  late final Stream<IncomingSplitKeyPayment?> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<ISKPRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IncomingSplitKeyPayment?>(
        stream: _payment,
        builder: (context, state) {
          final payment = state.data;

          return payment == null
              ? TransferProgress(
                  onBack: () => context.router.pop(),
                )
              : payment.status.maybeMap(
                  success: (_) => TransferSuccess(
                    onBack: () => context.router.pop(),
                    onOkPressed: () => context.router.pop(),
                    statusContent: context.l10n.moneyReceived,
                  ),
                  txFailure: (it) => it.reason == TxFailureReason.escrowFailure
                      ? const InvalidEscrowErrorWidget()
                      : TransferError(
                          onBack: () => context.router.pop(),
                          onRetry: () => context.retryISKP(payment),
                        ),
                  orElse: () => TransferProgress(
                    onBack: () => context.router.pop(),
                  ),
                );
        },
      );
}
