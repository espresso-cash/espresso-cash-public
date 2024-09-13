import 'package:flutter/material.dart';
import 'package:kyc_app_client/kyc_app_client.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../utils/email.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';
import 'email_confirmation_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const EmailVerificationScreen(),
        ),
      );

  static void pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
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
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          final service = sl<KycSharingService>();

          await service.updateField(
            key: OtpType.email,
            value: _emailController.text,
          );

          return true;
        } on Exception {
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
  Widget build(BuildContext context) => KycPage(
        title: 'Email verification',
        children: [
          const SizedBox(height: 20),
          const Text(
            'Enter your email address to receive your confirmation code.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 21 / 16,
              letterSpacing: .19,
            ),
          ),
          const SizedBox(height: 40),
          KycTextField(
            controller: _emailController,
            inputType: TextInputType.emailAddress,
            placeholder: 'Email Address',
          ),
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: _emailController,
            builder: (context, child) => CpButton(
              text: 'Send Verification Code',
              onPressed: _emailController.text.isValidEmail ? _sendEmail : null,
            ),
          ),
        ],
      );
}
