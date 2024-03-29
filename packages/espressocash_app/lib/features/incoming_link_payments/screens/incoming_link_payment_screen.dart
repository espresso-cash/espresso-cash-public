import 'package:dfunc/dfunc.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/presentation/format_amount.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/info_icon.dart';
import '../../../ui/message_info_widget.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';
import '../widgets/extensions.dart';
import '../widgets/invalid_escrow_error_widget.dart';

class IncomingLinkPaymentScreen extends StatefulWidget {
  const IncomingLinkPaymentScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<IncomingLinkPaymentScreen> createState() =>
      _IncomingLinkPaymentScreenState();
}

class _IncomingLinkPaymentScreenState extends State<IncomingLinkPaymentScreen> {
  late final Stream<IncomingLinkPayment?> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<ILPRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IncomingLinkPayment?>(
        stream: _payment,
        builder: (context, state) {
          final payment = state.data;

          return payment == null
              ? TransferProgress(
                  onBack: () => context.pop(),
                )
              : payment.status.maybeMap(
                  success: (e) => TransferSuccess(
                    onBack: () => context.pop(),
                    onOkPressed: () => context.pop(),
                    content: e.fee?.let(_FeeNotice.new),
                    statusContent: context.l10n.moneyReceived,
                  ),
                  txFailure: (it) => it.reason == TxFailureReason.escrowFailure
                      ? const InvalidEscrowErrorWidget()
                      : TransferError(
                          onBack: () => context.pop(),
                          onRetry: () => context.retryILP(payment),
                        ),
                  orElse: () => TransferProgress(
                    onBack: () => context.pop(),
                  ),
                );
        },
      );
}

class IncomingLinkPaymentRoute extends GoRouteData {
  const IncomingLinkPaymentRoute(this.id);

  final String id;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      IncomingLinkPaymentScreen(id: id);
}

class _FeeNotice extends StatelessWidget {
  const _FeeNotice(this.amount);

  final CryptoAmount amount;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CpMessageInfoWidget(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(18),
              content: Row(
                children: [
                  const CircleAvatar(
                    maxRadius: 14,
                    backgroundColor: CpColors.yellowColor,
                    child: CpInfoIcon(
                      iconColor: CpColors.darkBackgroundColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      context.l10n
                          .incomingUsdcFeeNotice(amount.format(context.locale)),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.50,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
}
