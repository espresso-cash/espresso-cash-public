import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../ramp/models/ramp_type.dart';
import '../widgets/kyc_page.dart';

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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: MarkdownBody(
              data: switch (rampType) {
                RampType.onRamp =>
                  context.l10n.onRampKycInitialDescription.toUpperCase(),
                RampType.offRamp =>
                  context.l10n.offRampKycInitialDescription.toUpperCase(),
              },
              styleSheet: MarkdownStyleSheet(
                em: _markdownStyle.copyWith(color: CpColors.yellowColor),
                p: _markdownStyle,
              ),
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

const _markdownStyle = TextStyle(
  fontStyle: FontStyle.normal,
  fontSize: 32,
  fontWeight: FontWeight.w900,
  letterSpacing: 0.25,
  height: 1,
);
