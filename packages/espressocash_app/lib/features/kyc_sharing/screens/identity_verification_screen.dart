import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';
import 'kyc_camera_screen.dart';

class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (context) => const IdentityVerificationScreen()))
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => KycPage(
    children: [
      KycHeader(
        title: context.l10n.selfieVerificationTitle.toUpperCase(),
        description: context.l10n.identityVerificationDescription,
      ),
      const SizedBox(height: 16),
      const Spacer(),
      CpBottomButton(
        horizontalPadding: 16,
        text: context.l10n.startSelfieVerification,
        onPressed: () async {
          final success = await KycCameraScreen.push(context);

          if (!context.mounted) return;
          if (!success) return;

          Navigator.pop(context, true);
        },
      ),
    ],
  );
}
