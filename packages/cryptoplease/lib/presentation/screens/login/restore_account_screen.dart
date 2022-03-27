import 'package:cryptoplease/bl/sign_up/sign_up_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/onboarding_screen.dart';
import 'package:cryptoplease/presentation/screens/login/mnemonic_input_formatter.dart';
import 'package:cryptoplease/presentation/screens/sign_up/sign_up_flow_screen.dart';
import 'package:cryptoplease/presentation/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreAccountScreen extends StatefulWidget {
  const RestoreAccountScreen({Key? key}) : super(key: key);

  @override
  _RestoreAccountScreenState createState() => _RestoreAccountScreenState();
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
            Text(context.l10n.toRestoreYourAccount),
            const SizedBox(height: 32),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
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
