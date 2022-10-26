import 'package:cryptoplease/features/onboarding/bl/sign_up_bloc.dart';
import 'package:cryptoplease/features/onboarding/presentation/sign_up/sign_up_flow_screen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/onboarding_screen.dart';
import 'package:cryptoplease/ui/recovery_phrase_text_view.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<SignUpBloc>().add(const SignUpEvent.phraseRequested());
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: FooterButton(
              text: context.l10n.next,
              onPressed: () =>
                  context.read<SignUpRouter>().onMnemonicConfirmed(),
            ),
            children: [
              CpAppBar(),
              const OnboardingLogo(),
              OnboardingTitle(text: context.l10n.yourRecoveryPhrase),
              OnboardingDescription(text: context.l10n.yourRecoveryPhraseSub),
              OnboardingPadding(
                child: BlocBuilder<SignUpBloc, SignUpState>(
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
