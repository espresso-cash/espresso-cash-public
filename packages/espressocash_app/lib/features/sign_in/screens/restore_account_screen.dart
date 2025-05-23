import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/loader.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/theme.dart';
import '../services/sign_in_bloc.dart';
import '../services/validate_mnemonic.dart';
import '../widgets/mnemonic_input_formatter.dart';

class RestoreAccountScreen extends StatefulWidget {
  const RestoreAccountScreen({super.key, required this.onSubmit, required this.bloc});

  final ValueSetter<String> onSubmit;
  final SignInBloc bloc;

  @override
  State<RestoreAccountScreen> createState() => _RestoreAccountScreenState();
}

class _RestoreAccountScreenState extends State<RestoreAccountScreen> {
  late final TextEditingController _controller;
  bool _mnemonicIsValid = false;

  void _restoreAccount() => widget.onSubmit(_controller.text.trim());

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      final isValid = validateMnemonic(_controller.text.trim());

      if (isValid != _mnemonicIsValid) {
        setState(() => _mnemonicIsValid = isValid);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<SignInBloc, SignInState>(
    bloc: widget.bloc,
    builder:
        (context, state) => CpLoader(
          isLoading: state.processingState.isProcessing,
          child: CpTheme.black(
            child: Scaffold(
              body: OnboardingScreen(
                footer: OnboardingFooterButton(
                  text: context.l10n.next,
                  onPressed: _mnemonicIsValid ? _restoreAccount : null,
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
          ),
        ),
  );
}

const keyRecoverMnemonic = Key('keyRecoverMnemonic');
