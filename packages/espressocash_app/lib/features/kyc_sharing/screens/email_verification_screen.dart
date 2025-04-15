import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../utils/email.dart';
import '../widgets/extensions.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (context) => const EmailVerificationScreen()))
      .then((result) => result ?? false);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSendVerification() async {
    final result = await context.sendEmailVerification(context, email: _emailController.text);

    if (!mounted) return;
    if (result) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => KycPage(
    children: [
      KycHeader(
        title: context.l10n.emailVerificationTitle.toUpperCase(),
        description: context.l10n.enterEmailHintText,
      ),
      const SizedBox(height: 16),
      KycTextField(
        controller: _emailController,
        inputType: TextInputType.emailAddress,
        placeholder: context.l10n.emailAddress,
      ),
      const SizedBox(height: 16),
      const Spacer(),
      ListenableBuilder(
        listenable: _emailController,
        builder:
            (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.send,
              onPressed: _emailController.text.isValidEmail ? _handleSendVerification : null,
            ),
      ),
    ],
  );
}
