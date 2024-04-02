import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/db/db.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/web_view_screen.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../models/transaction_request.dart';
import '../service/otr_service.dart';
import '../widgets/extensions.dart';

class OTRDetailsScreen extends StatefulWidget {
  const OTRDetailsScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<OTRDetailsScreen> createState() => _OTRDetailsScreenState();
}

class _OTRDetailsScreenState extends State<OTRDetailsScreen> {
  late final Stream<TransactionRequestPayment> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<OTRService>().watch(widget.id);
  }

  void _handleCancel(String id) => showConfirmationDialog(
        context,
        title: context.l10n.outgoingDirectPayments_lblCancelConfirmationTitle
            .toUpperCase(),
        message:
            context.l10n.outgoingDirectPayments_lblCancelConfirmationSubtitle,
        onConfirm: () => context.cancelOTR(id),
      );

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<TransactionRequestPayment>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;

          final loading = TransferProgress(
            onBack: () => context.pop(),
          );

          if (payment == null) return loading;

          return switch (payment.status) {
            OTRStatus.success => TransferSuccess(
                onBack: () => context.pop(),
                onOkPressed: () => context.pop(),
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
            OTRStatus.failure => TransferError(
                onBack: () => context.pop(),
                onRetry: () => context.retryOTR(payment.id),
                onCancel: () => _handleCancel(payment.id),
                // reason: it.reason,
              ),
            OTRStatus.created || OTRStatus.sent => loading,
          };
        },
      );
}

class OTRDetailsRoute extends GoRouteData {
  const OTRDetailsRoute(this.id);

  final String id;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OTRDetailsScreen(id: id);
}
