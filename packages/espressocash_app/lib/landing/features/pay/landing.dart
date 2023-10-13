import 'package:flutter/material.dart';

import '../../../core/link_payments.dart';
import '../../../l10n/l10n.dart';
import '../../core/extensions.dart';
import 'desktop.dart';
import 'mobile.dart';

class EspressoPayScreen extends StatelessWidget {
  const EspressoPayScreen({
    super.key,
    required this.payment,
  });

  final LinkPayments payment;

  @override
  Widget build(BuildContext context) {
    final actionLink = payment.toDeepLinkUri();
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
