import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/confirm_screen/components/direct_content.dart';
import 'package:cryptoplease/features/request_pay/bl/request_pay_bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DirectPayConfirmScreen extends StatefulWidget {
  const DirectPayConfirmScreen({
    super.key,
    required this.recipient,
    required this.amount,
  });

  final String recipient;
  final Amount amount;

  @override
  State<DirectPayConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<DirectPayConfirmScreen> {
  @override
  Widget build(BuildContext context) => DirectContent(
        fee: Amount.fromDecimal(
          value: Decimal.parse('0.1'),
          currency: Currency.usdc,
        ),
        recipientAddress: widget.recipient,
        tokenAmount: widget.amount,
        isProcessing: false,
        onSubmitted: () {},
      );
}
