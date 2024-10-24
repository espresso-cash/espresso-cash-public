import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const PhoneVerificationScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  State<PhoneVerificationScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneVerificationScreen> {
  final _numberController = TextEditingController();

  bool get _isValid => RegExp(
        r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
      ).hasMatch(_numberController.text);

  Future<void> _sendSms() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          final service = sl<KycSharingService>();

          await service.initPhoneVerification(phone: _numberController.text);

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

    if (success) Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: context.l10n.phoneVerification,
        children: [
          const SizedBox(height: 20),
          Text(
            context.l10n.enterPhoneNumberHintText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 21 / 16,
              letterSpacing: .19,
            ),
          ),
          const SizedBox(height: 40),
          KycTextField(
            controller: _numberController,
            inputType: TextInputType.phone,
            placeholder: context.l10n.phoneNumber,
          ),
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: _numberController,
            builder: (context, child) => CpButton(
              text: context.l10n.sendVerificationCode,
              onPressed: _isValid ? _sendSms : null,
            ),
          ),
        ],
      );
}
