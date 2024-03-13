import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../routing.dart';
import '../../../ui/button.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/form_page.dart';
import '../../../ui/recovery_phrase_text_view.dart';
import '../../accounts/data/account_repository.dart';
import '../../ramp/models/ramp_type.dart';
import '../../ramp/screens/ramp_onboarding_screen.dart';
import 'confirm_recovery_phrase_screen.dart';
import 'onboarding_screen.dart';

class ViewRecoveryPhraseScreen extends StatefulWidget {
  const ViewRecoveryPhraseScreen({
    super.key,
    required this.onConfirmed,
  });

  final VoidCallback onConfirmed;

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

  void _handleConfirmPress() => showConfirmationDialog(
        context,
        title: 'Did you write down the Secret Recovery Phrase?',
        message:
            'Without the secret recovery phrase you will not be able to access your key or any assets associated with it.',
        onConfirm: () => widget.onConfirmed(),
      );

  @override
  Widget build(BuildContext context) => FormPage(
        colorTheme: FormPageColorTheme.gold,
        title: const SizedBox(),
        header: FormPageHeader(
          title:
              const Text('Save your secret recovery phrase in a safe place.'),
          description: const Text(
            'Your recovery phrase is composed of randomly generated 12 words. Write it down and save it carefully. You will not be able to recover your funds if you lose these words.',
          ),
          icon: Assets.images.securityGraphic,
        ),
        child: Column(
          children: [
            RecoveryPhraseTextView(phrase: _phrase),
            const Spacer(),
            CpButton(
              text: 'Ok, I saved it somewhere',
              width: double.infinity,
              size: CpButtonSize.big,
              onPressed: _handleConfirmPress,
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
}

class OnboardingRecoveryPhraseRoute extends GoRouteData {
  const OnboardingRecoveryPhraseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ViewRecoveryPhraseScreen(
        onConfirmed: () {
          const OnboardingProfileRoute().push(context);
        },
      );
}
