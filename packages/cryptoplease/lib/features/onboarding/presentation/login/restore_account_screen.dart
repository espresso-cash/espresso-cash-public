import 'package:cryptoplease/features/onboarding/bl/sign_up_bloc.dart';
import 'package:cryptoplease/features/onboarding/presentation/login/mnemonic_input_formatter.dart';
import 'package:cryptoplease/features/onboarding/presentation/sign_up/sign_up_flow_screen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/onboarding_screen.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreAccountScreen extends StatefulWidget {
  const RestoreAccountScreen({Key? key}) : super(key: key);

  @override
  State<RestoreAccountScreen> createState() => _RestoreAccountScreenState();
}

class _RestoreAccountScreenState extends State<RestoreAccountScreen> {
  late final TextEditingController _controller;
  bool _mnemonicIsValid = false;

  void _restoreAccount() {
    context
        .read<SignUpBloc>()
        .add(SignUpEvent.phraseUpdated(_controller.text.trim()));
    context.read<SignUpRouter>().onMnemonicConfirmed();
  }

  void _onTextChange() {
    final isValid = validateMnemonic(_controller.text.trim());

    if (isValid != _mnemonicIsValid) {
      setState(() => _mnemonicIsValid = isValid);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => OnboardingScreen(
        title: context.l10n.enterYourSecretWords,
        nextLabel: context.l10n.next,
        onNextPressed: _mnemonicIsValid ? _restoreAccount : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.l10n.toRestoreYourAccount, textAlign: TextAlign.left),
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
                fillColor: CpColors.darkBackground,
                filled: true,
              ),
              inputFormatters: [MnemonicInputFormatter()],
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              style: twelveWordsTextStyle,
              maxLines: 3,
              minLines: 3,
            ),
          ],
        ),
      );
}
