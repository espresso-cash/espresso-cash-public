import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config.dart';
import '../../../l10n/l10n.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    this.textColor = Colors.white,
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.l10n.landingCopyright,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.36,
            ),
          ),
          const SizedBox(height: 4),
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
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.20,
            ),
          ),
        ],
      );
}
