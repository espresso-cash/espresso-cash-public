import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
import '../service/tr_service.dart';

class TRDetailsScreen extends StatefulWidget {
  const TRDetailsScreen({
    super.key,
    required this.id,
  });

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
    context.pop();
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
            onBack: () => context.pop(),
          );

          if (payment == null) return loading;

          return switch (payment.status) {
            TRStatus.success => TransferSuccess(
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
            TRStatus.failure => TransferError(
                onBack: () => context.pop(),
                onRetry: () => _retryTR(payment.id),
                onCancel: () => _handleCancel(payment.id),
              ),
            TRStatus.created || TRStatus.sent => loading,
          };
        },
      );
}

class TRDetailsRoute extends GoRouteData {
  const TRDetailsRoute(this.id);

  final String id;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TRDetailsScreen(id: id);
}
