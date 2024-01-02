import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import '../../../core/amount.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/colors.dart';
import '../../../ui/info_icon.dart';
import '../../../ui/message_info_widget.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/ilp_repository.dart';
import '../models/incoming_link_payment.dart';
import '../widgets/extensions.dart';
import '../widgets/invalid_escrow_error_widget.dart';

@RoutePage()
class IncomingLinkPaymentScreen extends StatefulWidget {
  const IncomingLinkPaymentScreen({
    super.key,
    required this.id,
  });

  static const route = IncomingLinkPaymentRoute.new;

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
                  onBack: () => context.router.pop(),
                )
              : payment.status.maybeMap(
                  success: (e) => TransferSuccess(
                    onBack: () => context.router.pop(),
                    onOkPressed: () => context.router.pop(),
                    content: e.fee?.let(_FeeNotice.new),
                    statusContent: e.receivedAmount?.let(
                          (it) => context.l10n.incomingLinkSuccessMessage(
                            it.format(context.locale, maxDecimals: 2),
                          ),
                        ) ??
                        context.l10n.moneyReceived,
                  ),
                  txFailure: (it) => it.reason == TxFailureReason.escrowFailure
                      ? const InvalidEscrowErrorWidget()
                      : TransferError(
                          onBack: () => context.router.pop(),
                          onRetry: () => context.retryILP(payment),
                        ),
                  orElse: () => TransferProgress(
                    onBack: () => context.router.pop(),
                  ),
                );
        },
      );
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
