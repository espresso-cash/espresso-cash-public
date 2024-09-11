import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_screen.dart';
import '../widgets/kyc_text_field.dart';
import 'email_verification_screen.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const BankAccountScreen(),
        ),
      );

  static void pushReplacement(BuildContext context) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const BankAccountScreen(),
        ),
      );

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final _bankAccountNumberController = TextEditingController();
  final _bankCodeController = TextEditingController();

  bool get _isValid =>
      _bankAccountNumberController.text.isNotEmpty &&
      _bankCodeController.text.isNotEmpty;

  Future<void> _handleSubmitted() async {
    try {
      final service = sl<KycSharingService>();

      await service.updateInfo(
        data: V1UserData(
          bankAccountNumber: _bankAccountNumberController.text,
          bankCode: _bankCodeController.text,
        ),
        photo: null,
      );

      if (!mounted) return;

      showCpSnackbar(context, message: 'Success, Data updated');
      EmailVerificationScreen.pushReplacement(context);
    } on Exception {
      showCpErrorSnackbar(context, message: 'Failed to update data');
    }
  }

  @override
  void dispose() {
    _bankAccountNumberController.dispose();
    _bankCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycScreen(
        title: 'Bank Account',
        children: [
          const SizedBox(height: 30),
          KycTextField(
            controller: _bankAccountNumberController,
            inputType: TextInputType.name,
            placeholder: 'Account Number',
          ),
          const SizedBox(height: 18),
          KycTextField(
            controller: _bankCodeController,
            inputType: TextInputType.name,
            placeholder: 'Bank Code',
          ),
          const SizedBox(height: 18),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListenableBuilder(
              listenable: Listenable.merge([
                _bankAccountNumberController,
                _bankCodeController,
              ]),
              builder: (context, child) => CpButton(
                width: double.infinity,
                text: 'Next',
                onPressed: _isValid ? _handleSubmitted : null,
              ),
            ),
          ),
        ],
      );
}
