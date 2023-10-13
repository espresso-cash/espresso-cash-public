import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';

import '../../../l10n/l10n.dart';
import '../../core/extensions.dart';
import '../request/desktop.dart';
import '../request/mobile.dart';

class PayRequestScreen extends StatelessWidget {
  const PayRequestScreen({super.key, required this.request});

  final SolanaPayRequest request;

  @override
  Widget build(BuildContext context) {
    final actionLink = Uri.parse(request.toUrl());
    final actionText = context.l10n.landingReceiveMoney;
    final title = context.l10n.landingTitle;
    final amount = request.amount;

    return Scaffold(
      backgroundColor: Colors.red,
      body: isMobile
          ? MobileView(
              actionLink: actionLink,
              actionText: actionText,
              amount: amount.toString(),
              title: title,
            )
          : DesktopView(
              actionLink: actionLink,
              title: title,
              amount: amount.toString(),
            ),
    );
  }
}
