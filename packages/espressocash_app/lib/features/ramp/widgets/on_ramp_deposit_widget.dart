import 'package:flutter/material.dart';

import '../../currency/models/amount.dart';
import '../../ramp_partner/models/ramp_partner.dart';

typedef Deposit = ({
  String orderId,
  DateTime orderCreated,
  CryptoAmount? receiveAmount,
  String bankAccount,
  String bankName,
  DateTime transferExpiryDate,
  FiatAmount transferAmount,
  String? moreInfoUrl,
});

class OnRampDepositWidget extends StatelessWidget {
  const OnRampDepositWidget({super.key, required this.deposit, required this.partner});

  final RampPartner partner;
  final Deposit deposit;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
