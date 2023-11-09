import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/link_payments.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../core/desktop.dart';
import '../../core/extensions.dart';
import '../../core/landing_widget.dart';
import '../../core/presentation/header.dart';
import '../../core/presentation/step_circle.dart';

class LinkPaymentScreen extends StatelessWidget {
  const LinkPaymentScreen(this.linkPayment, {super.key});

  final LinkPayments linkPayment;

  @override
  Widget build(BuildContext context) {
    final actionLink = linkPayment.toDeepLinkUri();
    final actionText = context.l10n.landingReceiveMoney;
    final title = context.l10n.landingLinkPaymentTitle;

    return isMobile
        ? _MobileView(
            actionLink: actionLink,
            actionText: actionText,
            title: title,
          )
        : DesktopView(
            actionLink: actionLink,
            title: title,
          );
  }
}

class _MobileView extends StatelessWidget {
  const _MobileView({
    required this.actionLink,
    required this.actionText,
    required this.title,
  });

  final Uri actionLink;
  final String actionText;
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LandingScreenWidget(
          children: [
            const EspressoHeader(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.landingInstruction,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            _MobileButton(
              step: 1,
              onTap: context.launchStore,
              text: context.l10n.landingInstallApp,
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.landingAlreadyInstalled,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            _MobileButton(
              step: 2,
              onTap: () => launchUrl(
                actionLink,
                mode: LaunchMode.externalNonBrowserApplication,
              ),
              text: actionText,
            ),
          ],
        ),
      );
}

class _MobileButton extends StatelessWidget {
  const _MobileButton({
    required this.step,
    required this.text,
    required this.onTap,
  });
  final int step;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => CpButton(
        size: CpButtonSize.big,
        minWidth: 300,
        width: 500,
        leading: StepCircle(step),
        text: text,
        trailing: const Icon(Icons.arrow_forward_ios),
        onPressed: onTap,
      );
}
