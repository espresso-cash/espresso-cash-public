import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/form_page.dart';
import '../../../ui/recovery_phrase_text_view.dart';
import '../../accounts/data/account_repository.dart';
import '../data/onboarding_repository.dart';

class ViewRecoveryPhraseScreen extends StatefulWidget {
  const ViewRecoveryPhraseScreen({super.key, required this.onConfirmed});

  final VoidCallback onConfirmed;

  static void open(
    BuildContext context, {
    NavigatorState? navigator,
    required VoidCallback onConfirmed,
  }) =>
      (navigator ?? Navigator.of(context, rootNavigator: true))
          .pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (context) => ViewRecoveryPhraseScreen(
            onConfirmed: onConfirmed,
          ),
        ),
        F,
      );

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
        title: context.l10n.onboardingPhraseConfirmTitle,
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        message: context.l10n.onboardingPhraseConfirmSubtitle,
        messageStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        onConfirm: () {
          sl<OnboardingRepository>().hasConfirmedPassphrase = true;
          widget.onConfirmed();
        },
      );

  @override
  Widget build(BuildContext context) => FormPage(
        colorTheme: FormPageColorTheme.gold,
        title: const SizedBox(),
        header: FormPageHeader(
          title: Text(
            context.l10n.onboardingPhraseTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          description: Text(
            context.l10n.onboardingPhraseSubtitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          icon: Assets.images.securityGraphic,
        ),
        child: Column(
          children: [
            RecoveryPhraseTextView(phrase: _phrase),
            const Spacer(),
            CpButton(
              text: context.l10n.onboardingPhraseConfirmBtn,
              width: double.infinity,
              size: CpButtonSize.big,
              onPressed: _handleConfirmPress,
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
}
