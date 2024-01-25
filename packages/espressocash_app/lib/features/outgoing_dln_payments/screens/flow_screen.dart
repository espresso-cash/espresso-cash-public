import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/theme.dart';
import '../../../core/amount.dart';
import '../../../core/blockchain.dart';
import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/loader.dart';
import '../models/payment_quote.dart';
import '../services/dln_order_service.dart';
import 'confirmation_screen.dart';
import 'details_screen.dart';

@RoutePage()
class OutgoingDlnPaymentFlowScreen extends StatefulWidget {
  const OutgoingDlnPaymentFlowScreen({
    super.key,
    required this.receiverAddress,
    required this.blockchain,
    required this.amount,
  });

  static const route = OutgoingDlnPaymentFlowRoute.new;

  final CryptoAmount amount;
  final String receiverAddress;
  final Blockchain blockchain;

  @override
  State<OutgoingDlnPaymentFlowScreen> createState() => _FlowState();
}

class _FlowState extends State<OutgoingDlnPaymentFlowScreen> {
  Future<void> _onConfirm(PaymentQuote quote) async {
    final id = await context.createDlnPayment(quote);

    if (!mounted) return;
    context.router.popUntilRoot();

    if (!mounted) return;
    await context.router.push(OutgoingDlnPaymentDetailsScreen.route(id: id));
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.confirmation.toUpperCase()),
            leading: const CloseButton(),
          ),
          body: OutgoingDlnConfirmationScreen(
            onConfirm: _onConfirm,
            amount: widget.amount,
            receiverAddress: widget.receiverAddress,
            blockchain: widget.blockchain,
          ),
        ),
      );
}

extension on BuildContext {
  Future<String> createDlnPayment(PaymentQuote quote) => runWithLoader(
        this,
        () => sl<OutgoingDlnPaymentService>().create(quote),
      );
}
