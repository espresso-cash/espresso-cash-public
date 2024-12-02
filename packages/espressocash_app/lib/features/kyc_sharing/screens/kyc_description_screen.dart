import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../ramp_partner/models/ramp_type.dart';
import '../widgets/kyc_page.dart';
import '../widgets/styles.dart';

class KycDescriptionScreen extends StatelessWidget {
  const KycDescriptionScreen({super.key, required this.rampType});

  static Future<bool> push(BuildContext context, RampType rampType) =>
      Navigator.of(context)
          .push<bool>(
            MaterialPageRoute(
              builder: (context) => KycDescriptionScreen(rampType: rampType),
            ),
          )
          .then((result) => result ?? false);

  final RampType rampType;

  @override
  Widget build(BuildContext context) => KycPage(
        title: switch (rampType) {
          RampType.onRamp => context.l10n.ramp_btnAddCash,
          RampType.offRamp => context.l10n.ramp_btnCashOut,
        }
            .toUpperCase(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: MarkdownBody(
              data: switch (rampType) {
                RampType.onRamp =>
                  context.l10n.onRampKycInitialDescription.toUpperCase(),
                RampType.offRamp =>
                  context.l10n.offRampKycInitialDescription.toUpperCase(),
              },
              styleSheet: kycMarkdownStyleSheet,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              context.l10n.reVerificationNotice,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
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
