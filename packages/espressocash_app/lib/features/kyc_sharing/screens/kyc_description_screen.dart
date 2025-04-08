import 'package:flutter/material.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';

class KycDescriptionScreen extends StatelessWidget {
  const KycDescriptionScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (context) => const KycDescriptionScreen()))
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => KycPage(
    children: [
      KycHeader(
        title: context.l10n.kycVerificationTitle,
        description: context.l10n.kycVerificationDescription,
      ),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          context.l10n.kycVerificationFooter,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      const Spacer(),
      CpBottomButton(
        horizontalPadding: 16,
        text: context.l10n.begin,
        onPressed: () => Navigator.pop(context, true),
      ),
    ],
  );
}
