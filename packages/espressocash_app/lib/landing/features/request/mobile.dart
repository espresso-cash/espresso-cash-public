import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../core/arrow.dart';
import '../../core/landing_widget.dart';

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
    required this.actionLink,
    required this.actionText,
    required this.title,
    required this.amount,
  });

  final Uri actionLink;
  final String actionText;
  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) => LandingScreenWidget(
        children: [
          Assets.images.logoIcon.image(height: 120),
          const SizedBox(height: 60),
          Text(
            context.l10n.landingPaymentRequestTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.23,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '$amount USDC',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 41,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 48),
          CpButton(
            text: context.l10n.landingRequestPayEspressoButton,
            size: CpButtonSize.big,
            width: double.infinity,
            trailing: const Arrow(),
            onPressed: () => launchUrl(
              actionLink,
              mode: LaunchMode.externalNonBrowserApplication,
            ),
          ),
        ],
      );
}
