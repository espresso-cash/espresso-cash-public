import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/loader.dart';
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
  final _bankNameController = TextEditingController();

  bool get _isValid =>
      _bankAccountNumberController.text.isNotEmpty &&
      _bankCodeController.text.isNotEmpty &&
      _bankNameController.text.isNotEmpty;

  Future<void> _handleSubmitted() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          await sl<KycSharingService>().updateBankInfo(
            bankAccountNumber: _bankAccountNumberController.text,
            bankCode: _bankCodeController.text,
            bankName: _bankNameController.text,
          );

          return true;
        } on Exception {
          if (!mounted) return false;
          showCpErrorSnackbar(
            context,
            message: context.l10n.failedToUpdateData,
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
    _bankAccountNumberController.dispose();
    _bankCodeController.dispose();
    _bankNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: context.l10n.bankAccount,
        children: [
          const SizedBox(height: 30),
          Text(
            context.l10n.bankAccountInfoCorrectText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 21 / 16,
              letterSpacing: 0.19,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          KycTextField(
            controller: _bankAccountNumberController,
            inputType: TextInputType.name,
            placeholder: context.l10n.accountNumber,
          ),
          const SizedBox(height: 16),
          KycTextField(
            controller: _bankCodeController,
            inputType: TextInputType.name,
            placeholder: context.l10n.bankCode,
          ),
          const SizedBox(height: 16),
          KycTextField(
            controller: _bankNameController,
            inputType: TextInputType.name,
            placeholder: context.l10n.bankName,
          ),
          const SizedBox(height: 16),
          const Spacer(),
          ListenableBuilder(
            listenable: Listenable.merge([
              _bankAccountNumberController,
              _bankCodeController,
              _bankNameController,
            ]),
            builder: (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.next,
              onPressed: _isValid ? _handleSubmitted : null,
            ),
          ),
        ],
      );
}
