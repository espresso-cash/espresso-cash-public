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
import '../data/repository.dart';
import '../models/outgoing_direct_payment.dart';
import '../widgets/extensions.dart';

class ODPDetailsScreen extends StatefulWidget {
  const ODPDetailsScreen({
    super.key,
    required this.id,
  });

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
              ? TransferProgress(onBack: () => context.pop())
              : payment.status.maybeMap(
                  success: (status) => TransferSuccess(
                    onBack: () => context.pop(),
                    onOkPressed: () => context.pop(),
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
                    onBack: () => context.pop(),
                    onRetry: () => context.retryODP(paymentId: payment.id),
                    onCancel: () => _handleCancel(payment.id),
                    reason: it.reason,
                  ),
                  orElse: () => TransferProgress(
                    onBack: () => context.pop(),
                  ),
                );
        },
      );
}

class ODPDetailsRoute extends GoRouteData {
  const ODPDetailsRoute(this.id);

  final String id;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ODPDetailsScreen(id: id);
}
