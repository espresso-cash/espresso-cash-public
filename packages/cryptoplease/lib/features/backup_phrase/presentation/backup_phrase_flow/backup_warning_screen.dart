import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/info_widget.dart';
import 'package:cryptoplease/ui/onboarding_screen.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackupWarningScreen extends StatelessWidget {
  const BackupWarningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: context.l10n.iUnderstand,
              onPressed: () =>
                  context.read<BackupPhraseRouter>().onWarningConfirmed(),
            ),
            children: [
              CpAppBar(
                leading: BackButton(
                  onPressed: () => context.router.pop(),
                ),
              ),
              const OnboardingLogo(),
              OnboardingPadding(
                child: CpInfoWidget(
                  message: Text(context.l10n.recoveryWarningInfo),
                ),
              ),
              const SizedBox(height: 38),
              OnboardingDescription(
                text: context.l10n.recoveryWarningParagraph,
              ),
            ],
          ),
        ),
      );
}
