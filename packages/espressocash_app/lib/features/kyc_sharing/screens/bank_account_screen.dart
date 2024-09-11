import 'package:flutter/material.dart';

import '../../../ui/button.dart';
import '../widgets/kyc_text_field.dart';
import 'kyc_screen.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key});

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final _accountNumberController = TextEditingController();
  final _bankCodeController = TextEditingController();

  bool get _isValid =>
      _accountNumberController.text.isNotEmpty &&
      _bankCodeController.text.isNotEmpty;

  Future<void> _handleSubmitted() async {}

  @override
  void dispose() {
    _accountNumberController.dispose();
    _bankCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycScreen(
        title: 'Bank Account',
        children: [
          KycTextField(
            controller: _accountNumberController,
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
                _accountNumberController,
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
