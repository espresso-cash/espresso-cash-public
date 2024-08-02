import 'package:flutter/material.dart';
import 'package:kyc_app_client/kyc_app_client.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/text_field.dart';
import '../../../../../ui/theme.dart';
import '../../../di.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../profile/data/profile_repository.dart';
import '../data/client.dart';
import '../data/verification_repository.dart';
import 'email_confirmation_screen.dart';

const partnerAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';

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

  Future<void> _sendEmail(String email) async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          final state = sl<VerificationRepository>();

          await state.updateEmail(email);

          await state.generatePartnerToken(partnerAuthPk);

          await otpClient.sendOtpByEmail(
            SendOtpRequest(
              secretKey: state.rawSecretKey,
              partnerToken: state.partnerToken,
              userPk: state.authPublicKey,
            ),
          );

          return true;
        } on Exception catch (ex) {
          print('failed: $ex');

          if (!mounted) return false;

          showCpErrorSnackbar(
            context,
            message: 'Failed to send verification code',
          );

          return false;
        }
      },
    );
    if (!mounted) return;
    if (success) EmailConfirmationScreen.push(context);
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: const CpAppBar(
            title: Text('Email verification'),
          ),
          extendBodyBehindAppBar: true,
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: 'Send verification code',
              onPressed: () => _sendEmail(_emailController.text),
            ),
            children: [
              SizedBox(height: MediaQuery.paddingOf(context).top + 48),
              OnboardingPadding(
                child: CpTextField(
                  disabled: true,
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
