import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/onboarding_screen.dart';
import '../../../../ui/recovery_phrase_text_view.dart';
import '../../../../ui/theme.dart';
import '../bl/onboarding_bloc.dart';
import 'onboarding_flow_screen.dart';

class CreateRecoveryPhraseScreen extends StatefulWidget {
  const CreateRecoveryPhraseScreen({Key? key}) : super(key: key);

  @override
  State<CreateRecoveryPhraseScreen> createState() =>
      _CreateRecoveryPhraseScreenState();
}

class _CreateRecoveryPhraseScreenState
    extends State<CreateRecoveryPhraseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(const OnboardingEvent.phraseRequested());
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: context.l10n.next,
              onPressed: () => context.onboardingRouter.onMnemonicConfirmed(),
            ),
            children: [
              CpAppBar(),
              const OnboardingLogo(),
              OnboardingTitle(text: context.l10n.yourRecoveryPhrase),
              OnboardingDescription(text: context.l10n.yourRecoveryPhraseSub),
              OnboardingPadding(
                child: BlocBuilder<OnboardingBloc, OnboardingState>(
                  builder: (context, state) => RecoveryPhraseTextView(
                    phrase: state.phrase,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
