import 'package:flutter/material.dart';

import '../../../core/link_payments.dart';
import '../../../l10n/l10n.dart';
import '../../core/extensions.dart';
import '../../core/presentation/espresso_desktop.dart';
import '../../core/presentation/espresso_mobile.dart';

class LinkPaymentScreen extends StatelessWidget {
  const LinkPaymentScreen(this.linkPayment, {super.key});

  final LinkPayments linkPayment;

  @override
  Widget build(BuildContext context) {
    final actionLink = linkPayment.toDeepLinkUri();
    final title = context.l10n.landingLinkPaymentTitle;

    return isMobile
        ? EspressoMobileView(
            actionLink: actionLink,
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.23,
                    ),
                  ),
                  Text(
                    context.l10n.landingInstruction,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            actionButtonText: context.l10n.landingReceiveMoney,
          )
        : EspressoDesktopView(
            actionLink: actionLink,
            title: title,
            subtitle: context.l10n.landingInstruction,
          );
  }
}
