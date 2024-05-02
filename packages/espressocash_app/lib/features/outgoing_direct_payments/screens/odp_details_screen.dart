import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/web_view_screen.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/repository.dart';
import '../models/outgoing_direct_payment.dart';
import '../widgets/extensions.dart';

class ODPDetailsScreen extends StatefulWidget {
  const ODPDetailsScreen({
    super.key,
    required this.id,
  });

  static void push(BuildContext context, {required String id}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => ODPDetailsScreen(id: id),
        ),
      );

  static void open(BuildContext context, {required String id}) =>
      Navigator.of(context).pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (context) => ODPDetailsScreen(id: id),
        ),
        (route) => route.isFirst,
      );

  final String id;

  @override
  State<ODPDetailsScreen> createState() => _ODPDetailsScreenState();
}

class _ODPDetailsScreenState extends State<ODPDetailsScreen> {
  late final Stream<OutgoingDirectPayment> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<ODPRepository>().watch(widget.id);
  }

  void _handleCancel(String id) => showConfirmationDialog(
        context,
        title: context.l10n.outgoingDirectPayments_lblCancelConfirmationTitle
            .toUpperCase(),
        message:
            context.l10n.outgoingDirectPayments_lblCancelConfirmationSubtitle,
        onConfirm: () => context.cancelODP(paymentId: id),
      );

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingDirectPayment>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;

          return payment == null
              ? TransferProgress(onBack: () => Navigator.pop(context))
              : payment.status.maybeMap(
                  success: (status) => TransferSuccess(
                    onBack: () => Navigator.pop(context),
                    onOkPressed: () => Navigator.pop(context),
                    statusContent: context.l10n.outgoingTransferSuccess(
                      payment.amount.format(DeviceLocale.localeOf(context)),
                    ),
                    onMoreDetailsPressed: () {
                      final link = status.txId
                          .let(createTransactionLink)
                          .let(Uri.parse)
                          .toString();
                      context.openLink(link);
                    },
                  ),
                  txFailure: (it) => TransferError(
                    onBack: () => Navigator.pop(context),
                    onRetry: () => context.retryODP(paymentId: payment.id),
                    onCancel: () => _handleCancel(payment.id),
                    reason: it.reason,
                  ),
                  orElse: () => TransferProgress(
                    onBack: () => Navigator.pop(context),
                  ),
                );
        },
      );
}
