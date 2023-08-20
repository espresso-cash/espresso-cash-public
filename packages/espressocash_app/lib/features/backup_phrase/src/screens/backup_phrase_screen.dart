import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../l10n/l10n.dart';
import '../../../../../../ui/app_bar.dart';
import '../../../../../../ui/back_button.dart';
import '../../../../../../ui/onboarding_screen.dart';
import '../../../../../../ui/recovery_phrase_text_view.dart';
import '../../../../../../ui/theme.dart';
import '../../../../di.dart';
import '../../../../routes.gr.dart';
import '../../../accounts/data/account_repository.dart';

@RoutePage()
class BackupPhraseScreen extends StatefulWidget {
  const BackupPhraseScreen({super.key, required this.onConfirmed});

  final ValueSetter<String> onConfirmed;

  static const route = BackupPhraseRoute.new;

  @override
  State<BackupPhraseScreen> createState() => _BackupPhraseScreenState();
}

class _BackupPhraseScreenState extends State<BackupPhraseScreen> {
  String _phrase = '';

  @override
  void initState() {
    super.initState();
    sl<AccountRepository>().loadMnemonic().then((String? phrase) {
      if (phrase != null) {
        setState(() => _phrase = phrase);
      }
    });
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: context.l10n.next,
              onPressed: () => widget.onConfirmed(_phrase),
            ),
            children: [
              CpAppBar(
                leading: CpBackButton(onPressed: () => context.router.pop()),
              ),
              const OnboardingLogo(),
              OnboardingTitle(text: context.l10n.yourRecoveryPhrase),
              OnboardingDescription(text: context.l10n.recoverySubHeading),
              OnboardingPadding(child: RecoveryPhraseTextView(phrase: _phrase)),
            ],
          ),
        ),
      );
}
