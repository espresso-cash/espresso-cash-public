import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';
import 'phone_confirmation_screen.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const PhoneVerificationScreen(),
        ),
      );

  static void pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const PhoneVerificationScreen(),
        ),
      );

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

          await service.updateField(
            key: 'phone',
            value: _numberController.text,
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
    if (success) PhoneConfirmationScreen.push(context, _numberController.text);
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: 'Phone verification',
        children: [
          const SizedBox(height: 20),
          const Text(
            'Enter your mobile phone number to receive your confirmation code.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 21 / 16,
              letterSpacing: .19,
            ),
          ),
          const SizedBox(height: 40),
          KycTextField(
            controller: _numberController,
            inputType: TextInputType.phone,
            placeholder: 'Phone Number',
          ),
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: _numberController,
            builder: (context, child) => CpButton(
              text: 'Send verification code',
              onPressed: _isValid ? _sendSms : null,
            ),
          ),
        ],
      );
}
