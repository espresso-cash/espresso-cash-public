import 'package:flutter/material.dart';

import '../../../ui/bottom_button.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';

class DocumentInfoScreen extends StatelessWidget {
  const DocumentInfoScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const DocumentInfoScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => KycPage(
        children: [
          const KycHeader(
            title: 'UPLOAD YOUR *ID DOCUMENT*',
            description:
                'For security purposes, we need you to upload a clear photo of your identification document. Ensure all details are visible, avoid glare and shadows, and use good lighting for faster verification.',
          ),
          const SizedBox(height: 16),
          const Spacer(),
          CpBottomButton(
            horizontalPadding: 16,
            text: 'Continue',
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
}
