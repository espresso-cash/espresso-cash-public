import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/theme.dart';
import '../services/validate_mnemonic.dart';
import '../widgets/mnemonic_input_formatter.dart';

class RestoreAccountScreen extends StatefulWidget {
  const RestoreAccountScreen({super.key, required this.onSubmit});

  final ValueSetter<String> onSubmit;

  @override
  State<RestoreAccountScreen> createState() => _RestoreAccountScreenState();
}

class _RestoreAccountScreenState extends State<RestoreAccountScreen> {
  late final TextEditingController _controller;
  bool _isValidMnemonic = false;

  void _restoreAccount() => widget.onSubmit(_controller.text.trim());

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      final isValid = isValidMnemonic(_controller.text.trim());

      if (isValid != _isValidMnemonic) {
        setState(() => _isValidMnemonic = isValid);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
    child: Scaffold(
      body: OnboardingScreen(
        footer: OnboardingFooterButton(
          text: context.l10n.next,
          onPressed: _isValidMnemonic ? _restoreAccount : null,
        ),
        children: [
          const CpAppBar(),
          const OnboardingLogo(),
          OnboardingTitle(text: context.l10n.enterYourSecretWords),
          OnboardingDescription(text: context.l10n.toRestoreYourAccount),
          OnboardingPadding(
            child: TextField(
              key: keyRecoverMnemonic,
              controller: _controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.black,
                filled: true,
              ),
              inputFormatters: [MnemonicInputFormatter()],
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              spellCheckConfiguration: const SpellCheckConfiguration.disabled(),
              style: twelveWordsTextStyle,
              maxLines: 3,
              minLines: 3,
            ),
          ),
        ],
      ),
    ),
  );
}

const keyRecoverMnemonic = Key('keyRecoverMnemonic');
