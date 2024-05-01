import 'package:flutter/material.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/theme.dart';
import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/loader.dart';
import '../../blockchain/models/blockchain.dart';
import '../../currency/models/amount.dart';
import '../models/payment_quote.dart';
import '../services/dln_order_service.dart';
import '../widgets/confirmation.dart';
import 'details_screen.dart';

class OutgoingDlnPaymentConfirmationScreen extends StatefulWidget {
  const OutgoingDlnPaymentConfirmationScreen({
    super.key,
    required this.receiverAddress,
    required this.blockchain,
    required this.amount,
  });

  static void push(
    BuildContext context, {
    required CryptoAmount amount,
    required String receiverAddress,
    required Blockchain blockchain,
  }) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => OutgoingDlnPaymentConfirmationScreen(
            amount: amount,
            receiverAddress: receiverAddress,
            blockchain: blockchain,
          ),
        ),
      );

  final CryptoAmount amount;
  final String receiverAddress;
  final Blockchain blockchain;

  @override
  State<OutgoingDlnPaymentConfirmationScreen> createState() => _FlowState();
}

class _FlowState extends State<OutgoingDlnPaymentConfirmationScreen> {
  Future<void> _onConfirm(PaymentQuote quote) async {
    final id = await context.createDlnPayment(quote);

    if (!mounted) return;
    OutgoingDlnPaymentDetailsScreen.open(context, id: id);
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.confirmation.toUpperCase()),
            leading: const CloseButton(),
          ),
          body: ConfirmationContent(
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
