import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';

class DocumentInfoScreen extends StatelessWidget {
  const DocumentInfoScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (context) => const DocumentInfoScreen()))
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => KycPage(
    children: [
      KycHeader(
        title: context.l10n.documentVerificationTitle,
        description: context.l10n.documentVerificationDescription,
      ),
      const SizedBox(height: 16),
      const Spacer(),
      CpBottomButton(
        horizontalPadding: 16,
        text: context.l10n.continueVerification,
        onPressed: () => Navigator.pop(context, true),
      ),
    ],
  );
}
