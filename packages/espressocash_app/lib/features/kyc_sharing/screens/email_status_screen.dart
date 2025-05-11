import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../utils/email.dart';
import '../models/kyc_validation_status.dart';
import '../utils/kyc_utils.dart';
import '../widgets/extensions.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';
import '../widgets/user_data_listener.dart';
import 'email_confirmation_screen.dart';

class EmailStatusScreen extends StatelessWidget {
  const EmailStatusScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (context) => const EmailStatusScreen()))
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => UserDataListener(
    builder: (context, userData) {
      final status = userData.emailStatus;
      final email = userData.emailValue ?? '-';

      return KycPage(
        icon: status.kycIcon,
        children: [
          switch (status) {
            KycValidationStatus.unverified || KycValidationStatus.pending => KycHeader(
              title: context.l10n.emailPendingStatusTitle,
              description: context.l10n.emailPendingStatusDescription(email),
            ),
            KycValidationStatus.approved => KycHeader(
              title: context.l10n.emailApprovedStatusTitle,
              description: context.l10n.emailApprovedStatusDescription(email),
            ),
            KycValidationStatus.rejected => KycHeader(
              title: context.l10n.emailRejectedStatusTitle,
              description: context.l10n.emailRejectedStatusDescription(email),
            ),
          },
          const SizedBox(height: 16),
          // ignore: avoid-flexible-outside-flex, inside column
          Expanded(child: _UpdateEmailContent(status: status)),
        ],
      );
    },
  );
}

class _UpdateEmailContent extends StatefulWidget {
  const _UpdateEmailContent({required this.status});

  final KycValidationStatus status;

  @override
  State<_UpdateEmailContent> createState() => __UpdateEmailContentState();
}

class __UpdateEmailContentState extends State<_UpdateEmailContent> {
  final _emailController = TextEditingController();

  String get _placeholderText => switch (widget.status) {
    KycValidationStatus.rejected => context.l10n.emailAddress,
    KycValidationStatus.approved ||
    KycValidationStatus.pending ||
    KycValidationStatus.unverified => context.l10n.updateEmailAddress,
  };

  Future<void> _handleSendVerification() async {
    final result = await context.sendEmailVerification(context, email: _emailController.text);

    if (!mounted) return;
    if (!result) return;

    Navigator.pop(context);
    await EmailConfirmationScreen.push(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      KycTextField(
        controller: _emailController,
        inputType: TextInputType.emailAddress,
        placeholder: _placeholderText,
      ),
      const SizedBox(height: 16),
      const Spacer(),
      ListenableBuilder(
        listenable: _emailController,
        builder:
            (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.sendVerificationCode,
              onPressed: _emailController.text.isValidEmail ? _handleSendVerification : null,
            ),
      ),
    ],
  );
}
