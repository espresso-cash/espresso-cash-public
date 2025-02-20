import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../models/bank.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';
import '../widgets/bank_text_field.dart';
import '../widgets/kyc_header.dart';
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
  Bank? _selectedBank;

  bool get _isValid =>
      _bankAccountNumberController.text.trim().isNotEmpty &&
      _selectedBank != null;

  Future<void> _handleSubmitted() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          await sl<KycSharingService>().updateBankInfo(
            bankAccountNumber: _bankAccountNumberController.text,
            bankCode: _selectedBank?.code ?? '',
            bankName: _selectedBank?.name ?? '',
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
  void initState() {
    super.initState();

    final user = sl<KycSharingService>().value;

    _bankAccountNumberController.text = user?.accountNumber ?? '';

    final initialBank = nigerianBanks.firstWhereOrNull(
      (bank) => bank.code == user?.bankCode,
    );

    _selectedBank = initialBank;
  }

  @override
  void dispose() {
    _bankAccountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycPage(
        children: [
          KycHeader(
            title: context.l10n.bankAccountVerificationTitle.toUpperCase(),
            description: context.l10n.bankAccountInfoCorrectText,
          ),
          const SizedBox(height: 16),
          BankTextField(
            placeholder: context.l10n.selectBank,
            initialBank: _selectedBank,
            onBankChanged: (bank) => setState(() => _selectedBank = bank),
          ),
          const SizedBox(height: 16),
          KycTextField(
            controller: _bankAccountNumberController,
            inputType: TextInputType.name,
            placeholder: context.l10n.accountNumber,
          ),
          const Spacer(),
          ListenableBuilder(
            listenable: _bankAccountNumberController,
            builder: (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.next,
              onPressed: _isValid ? _handleSubmitted : null,
            ),
          ),
        ],
      );
}
