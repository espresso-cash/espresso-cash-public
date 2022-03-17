import 'package:cryptoplease/bl/sign_up/sign_up_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/onboarding_screen.dart';
import 'package:cryptoplease/presentation/components/recovery_phrase_text_view.dart';
import 'package:cryptoplease/presentation/screens/sign_up/sign_up_flow_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRecoveryPhraseScreen extends StatefulWidget {
  const CreateRecoveryPhraseScreen({Key? key}) : super(key: key);

  @override
  _CreateRecoveryPhraseScreenState createState() =>
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
  Widget build(BuildContext context) => OnboardingScreen(
        onNextPressed: () => context.read<SignUpRouter>().onMnemonicConfirmed(),
        nextLabel: context.l10n.next,
        title: context.l10n.yourRecoveryPhrase,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.l10n.yourRecoveryPhraseSub),
            const SizedBox(height: 24),
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) => RecoveryPhraseTextView(
                phrase: state.phrase,
              ),
            ),
          ],
        ),
      );
}
