import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/recovery_phrase_text_view.dart';
import '../../../ui/theme.dart';
import '../../accounts/data/account_repository.dart';

@RoutePage()
class ViewRecoveryPhraseScreen extends StatefulWidget {
  const ViewRecoveryPhraseScreen({super.key, required this.onDone});

  static const route = ViewRecoveryPhraseRoute.new;

  final VoidCallback onDone;

  @override
  State<ViewRecoveryPhraseScreen> createState() =>
      _ViewRecoveryPhraseScreenState();
}

class _ViewRecoveryPhraseScreenState extends State<ViewRecoveryPhraseScreen> {
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
              onPressed: widget.onDone,
            ),
            children: [
              CpAppBar(),
              const OnboardingLogo(),
              OnboardingTitle(text: context.l10n.yourRecoveryPhrase),
              OnboardingDescription(text: context.l10n.yourRecoveryPhraseSub),
              OnboardingPadding(
                child: RecoveryPhraseTextView(
                  phrase: _phrase,
                ),
              ),
            ],
          ),
        ),
      );
}
