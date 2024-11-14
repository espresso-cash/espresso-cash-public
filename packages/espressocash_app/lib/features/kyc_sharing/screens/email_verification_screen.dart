import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../utils/email.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_exception.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const EmailVerificationScreen(),
        ),
      )
      .then((result) => result ?? false);

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
          await service.initEmailVerification(email: _emailController.text);

          return true;
        } on KycException catch (error) {
          if (!mounted) return false;

          final message = switch (error.error) {
            KycError.invalidEmail => context.l10n.invalidEmail,
            // ignore: avoid-wildcard-cases-with-enums, check if needed
            _ => context.l10n.failedToSendVerificationCode,
          };

          showCpErrorSnackbar(context, message: message);

          return false;
        }
      },
    );
    if (!mounted) return;
    if (success) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: context.l10n.emailVerification,
        children: [
          const SizedBox(height: 20),
          Text(
            context.l10n.enterEmailHintText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 21 / 16,
              letterSpacing: .19,
            ),
          ),
          const SizedBox(height: 40),
          KycTextField(
            controller: _emailController,
            inputType: TextInputType.emailAddress,
            placeholder: context.l10n.emailAddress,
          ),
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: _emailController,
            builder: (context, child) => CpButton(
              minWidth: 250,
              text: context.l10n.sendVerificationCode,
              onPressed: _emailController.text.isValidEmail ? _sendEmail : null,
            ),
          ),
        ],
      );
}
