import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/onboarding_screen.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/info_icon.dart';
import 'package:cryptoplease/ui/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BackupWarningScreen extends StatelessWidget {
  const BackupWarningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => OnboardingScreen(
        title: '',
        nextLabel: context.l10n.iUnderstand,
        onNextPressed: () => context.router.push(const BackupPhraseFlowRoute()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CpInfoWidget(
              icon: const CpInfoIcon(),
              message: Text(
                context.l10n.recoveryWarningInfo,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 18),
            Builder(
              builder: (context) => Markdown(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                styleSheet: MarkdownStyleSheet(
                  p: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: WrapAlignment.start,
                ),
                data: context.l10n.recoveryWarningParagraph,
              ),
            ),
          ],
        ),
      );
}
