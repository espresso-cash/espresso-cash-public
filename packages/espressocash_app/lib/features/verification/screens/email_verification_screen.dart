import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../di.dart';
import '../../../ui/colors.dart';
import '../../profile/data/profile_repository.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const EmailVerificationScreen(),
        ),
      );

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final repository = sl<ProfileRepository>();

    _emailController.text = repository.email;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: const CpAppBar(),
          extendBodyBehindAppBar: true,
          body: OnboardingScreen(
            footer: const OnboardingFooterButton(
              text: 'Send verification code',
              onPressed: null,
            ),
            children: [
              SizedBox(height: MediaQuery.paddingOf(context).top + 48),
              OnboardingPadding(
                child: CpTextField(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  placeholder: context.l10n.yourEmailPlaceholder,
                  controller: _emailController,
                  textColor: Colors.white,
                  placeholderColor: _placeholderTextColor,
                  backgroundColor: CpColors.blackTextFieldBackgroundColor,
                  fontSize: 16,
                  inputType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
        ),
      );
}

const _placeholderTextColor = Color(0xff858585);
const keyCreateProfileName = Key('createProfileName');
