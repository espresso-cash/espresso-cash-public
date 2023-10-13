import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';

import '../../../l10n/l10n.dart';
import '../../core/extensions.dart';
import '../pay/desktop.dart';
import '../pay/mobile.dart';

class PayRequestScreen extends StatelessWidget {
  const PayRequestScreen({super.key, required this.request});

  final SolanaPayRequest request;

  @override
  Widget build(BuildContext context) {
    final actionLink = Uri.parse(request.toUrl());
    final actionText = context.l10n.landingReceiveMoney;
    final title = context.l10n.landingTitle;

    return Scaffold(
      body: isMobile
          ? MobileView(
              actionLink: actionLink,
              actionText: actionText,
              title: title,
            )
          : DesktopView(
              actionLink: actionLink,
              title: title,
            ),
    );
  }
}
