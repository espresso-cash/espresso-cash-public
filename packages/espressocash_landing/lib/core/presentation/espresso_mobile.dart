import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/extensions.dart';
import '../../l10n/l10n.dart';
import '../../ui/arrow.dart';
import '../../ui/button.dart';
import '../../ui/colors.dart';
import '../../ui/mobile_page.dart';
import '../../ui/step_circle.dart';

class EspressoMobileView extends StatelessWidget {
  const EspressoMobileView({
    super.key,
    required this.actionLink,
    required this.header,
    required this.actionButtonText,
  });

  final Uri actionLink;
  final Widget header;
  final String actionButtonText;

  @override
  Widget build(BuildContext context) => LandingMobilePage(
        header: header,
        content: Column(
          children: [
            const SizedBox(height: 24),
            const StepCircle(1),
            const SizedBox(height: 8),
            Text(
              context.l10n.installApp,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              context.l10n.alreadyInstalled,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            _MobileButton(
              onTap: context.launchStore,
              text: context.l10n.installApp,
            ),
            const Divider(
              color: EcLandingColors.borderColor,
            ),
            const SizedBox(height: 24),
            const StepCircle(2),
            _MobileButton(
              onTap: () => launchUrl(
                actionLink,
                mode: LaunchMode.externalNonBrowserApplication,
                webOnlyWindowName: '_self',
              ),
              text: actionButtonText,
            ),
          ],
        ),
      );
}

class _MobileButton extends StatelessWidget {
  const _MobileButton({
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: CpButton(
          size: CpButtonSize.big,
          width: 340,
          text: text,
          trailing: const LandingArrow(),
          onPressed: onTap,
        ),
      );
}
