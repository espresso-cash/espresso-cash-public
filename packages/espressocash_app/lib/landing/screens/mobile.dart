import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../gen/assets.gen.dart';
import '../../l10n/l10n.dart';
import '../../ui/button.dart';
import '../widgets/extensions.dart';
import '../widgets/landing_widget.dart';
import '../widgets/step_circle.dart';

class MobileView extends StatelessWidget {
  const MobileView(this.uri, {super.key});

  final Uri uri;

  @override
  Widget build(BuildContext context) => LandingScreenWidget(
        children: [
          Assets.images.logoIcon.image(height: 120),
          const SizedBox(height: 60),
          Text(
            context.l10n.landingTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.landingSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
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
              uri,
              mode: LaunchMode.externalNonBrowserApplication,
            ),
            text: context.l10n.landingReceiveMoney,
          ),
        ],
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
