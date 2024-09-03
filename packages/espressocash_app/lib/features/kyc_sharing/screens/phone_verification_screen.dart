import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/form_page.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/text_field.dart';
import '../services/kyc_service.dart';
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
  Widget build(BuildContext context) => FormPage(
        colorTheme: FormPageColorTheme.gold,
        title: Text('Phone Verification'.toUpperCase()),
        header: const SizedBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  'Enter phone number to get verification code:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                CpTextField(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 16,
                    left: 26,
                    right: 26,
                  ),
                  controller: _numberController,
                  inputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  backgroundColor: const Color(0xFF9D8A59),
                  placeholder: 'Enter number',
                  placeholderColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 16,
                ),
                const Spacer(),
                ListenableBuilder(
                  listenable: _numberController,
                  builder: (context, child) => CpButton(
                    width: double.infinity,
                    text: 'Send verification code',
                    onPressed: _isValid ? _sendSms : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
