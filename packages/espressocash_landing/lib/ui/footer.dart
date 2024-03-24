import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config.dart';
import '../../../l10n/l10n.dart';
import 'colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.copyright,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: EcLandingColors.footerTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.36,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Terms of Use',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(Uri.parse(termsUrl)),
                ),
                const WidgetSpan(child: SizedBox(width: 12)),
                TextSpan(
                  text: 'Privacy Policy',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(Uri.parse(privacyUrl)),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: EcLandingColors.footerTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.20,
            ),
          ),
        ],
      );
}
