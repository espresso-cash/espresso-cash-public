import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const BankAccountScreen(),
        ),
      )
      .then((result) => result ?? false);

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

      await service.updateBankInfo(
        bankAccountNumber: _bankAccountNumberController.text,
        bankCode: _bankCodeController.text,
      );

      if (!mounted) return;

      Navigator.pop(context, true);
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
  Widget build(BuildContext context) => KycPage(
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
