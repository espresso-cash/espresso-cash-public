import 'package:cryptoplease/features/onboarding/bl/onboarding_bloc.dart';
import 'package:cryptoplease/features/onboarding/presentation/components/mnemonic_input_formatter.dart';
import 'package:cryptoplease/features/onboarding/presentation/onboarding_flow_screen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
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
        .read<OnboardingBloc>()
        .add(OnboardingEvent.phraseUpdated(_controller.text.trim()));
    context.onboardingRouter.onMnemonicConfirmed();
  }

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
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: context.l10n.next,
              onPressed: _mnemonicIsValid ? _restoreAccount : null,
            ),
            children: [
              CpAppBar(),
              const OnboardingLogo(),
              OnboardingTitle(text: context.l10n.enterYourSecretWords),
              OnboardingDescription(text: context.l10n.toRestoreYourAccount),
              OnboardingPadding(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(24),
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
              ),
            ],
          ),
        ),
      );
}
