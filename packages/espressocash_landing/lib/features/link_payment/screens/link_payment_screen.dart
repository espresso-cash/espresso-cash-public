import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../ui/pages/instructions_desktop_page.dart';
import '../../../ui/pages/instructions_mobile_page.dart';
import '../../../utils/extensions.dart';
import '../models/link_payments.dart';

class LinkPaymentScreen extends StatelessWidget {
  const LinkPaymentScreen(this.linkPayment, {super.key});

  final LinkPayments linkPayment;

  @override
  Widget build(BuildContext context) {
    final actionLink = linkPayment.toDeepLinkUri();
    final title = context.l10n.linkPaymentTitle;

    return isMobile
        ? InstructionsMobilePage(
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
                    context.l10n.instruction,
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
            actionButtonText: context.l10n.receiveMoney,
          )
        : InstructionsDesktopPage(
            actionLink: actionLink,
            title: title,
            subtitle: context.l10n.instruction,
          );
  }
}
