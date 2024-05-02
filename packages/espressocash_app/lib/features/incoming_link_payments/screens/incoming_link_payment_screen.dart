import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/info_icon.dart';
import '../../../ui/message_info_widget.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
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

  static void push(BuildContext context, {required String id}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => IncomingLinkPaymentScreen(id: id),
        ),
      );

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
                  onBack: () => Navigator.pop(context),
                )
              : payment.status.maybeMap(
                  success: (e) => TransferSuccess(
                    onBack: () => Navigator.pop(context),
                    onOkPressed: () => Navigator.pop(context),
                    content: e.fee?.let(_FeeNotice.new),
                    statusContent: context.l10n.moneyReceived,
                  ),
                  txFailure: (it) => it.reason == TxFailureReason.escrowFailure
                      ? const InvalidEscrowErrorWidget()
                      : TransferError(
                          onBack: () => Navigator.pop(context),
                          onRetry: () => context.retryILP(payment),
                        ),
                  orElse: () => TransferProgress(
                    onBack: () => Navigator.pop(context),
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
