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
import '../models/transaction_request.dart';
import '../service/tr_service.dart';

class TRDetailsScreen extends StatefulWidget {
  const TRDetailsScreen({
    super.key,
    required this.id,
  });

  static void push(BuildContext context, {required String id}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => TRDetailsScreen(id: id),
        ),
      );

  final String id;

  @override
  State<TRDetailsScreen> createState() => _TRDetailsScreenState();
}

class _TRDetailsScreenState extends State<TRDetailsScreen> {
  late final Stream<TransactionRequestPayment> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<TRService>().watch(widget.id);
  }

  void _cancelTR(String id) {
    sl<TRService>().cancel(id);
    Navigator.pop(context);
  }

  void _retryTR(String id) => sl<TRService>().retry(id);

  void _handleCancel(String id) => showConfirmationDialog(
        context,
        title: context.l10n.outgoingDirectPayments_lblCancelConfirmationTitle
            .toUpperCase(),
        message:
            context.l10n.outgoingDirectPayments_lblCancelConfirmationSubtitle,
        onConfirm: () => _cancelTR(id),
      );

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<TransactionRequestPayment>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;

          final loading = TransferProgress(
            onBack: () => Navigator.pop(context),
          );

          if (payment == null) return loading;

          return switch (payment.status) {
            TRStatus.success => TransferSuccess(
                onBack: () => Navigator.pop(context),
                onOkPressed: () => Navigator.pop(context),
                statusContent: context.l10n.outgoingTransferSuccess(
                  payment.amount.format(DeviceLocale.localeOf(context)),
                ),
                onMoreDetailsPressed: () {
                  final link = payment.txId
                      .let(createTransactionLink)
                      .let(Uri.parse)
                      .toString();
                  context.openLink(link);
                },
              ),
            TRStatus.failure => TransferError(
                onBack: () => Navigator.pop(context),
                onRetry: () => _retryTR(payment.id),
                onCancel: () => _handleCancel(payment.id),
              ),
            TRStatus.created || TRStatus.sent => loading,
          };
        },
      );
}
