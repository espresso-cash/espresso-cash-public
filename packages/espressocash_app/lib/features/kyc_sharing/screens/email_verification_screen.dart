import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../utils/email.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_exception.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';
import '../widgets/styles.dart';

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
          await sl<KycSharingService>()
              .initEmailVerification(email: _emailController.text);

          return true;
        } on KycException catch (error) {
          if (!mounted) return false;

          final message = switch (error) {
            KycInvalidEmail() => context.l10n.invalidEmail,
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
        children: [
          const _Header(),
          const SizedBox(height: 16),
          KycTextField(
            controller: _emailController,
            inputType: TextInputType.emailAddress,
            placeholder: context.l10n.emailAddress,
          ),
          const Spacer(),
          ListenableBuilder(
            listenable: _emailController,
            builder: (context, child) => CpBottomButton(
              text: context.l10n.sendVerificationCode,
              onPressed: _emailController.text.isValidEmail ? _sendEmail : null,
            ),
          ),
        ],
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarkdownBody(
              data: context.l10n.emailVerificationTitle.toUpperCase(),
              styleSheet: kycMarkdownStyleSheet,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.enterEmailHintText,
              style: const TextStyle(
                fontSize: 16,
                height: 21 / 16,
                letterSpacing: .19,
              ),
            ),
          ],
        ),
      );
}
