import 'package:brij_client/brij_client.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/country_picker.dart';
import '../models/bank.dart';
import '../services/kyc_service.dart';
import '../widgets/bank_text_field.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class BankAccountScreen extends StatefulWidget {
  const BankAccountScreen({super.key, this.initialBankInfo, this.buttonLabel});

  static Future<bool> push(
    BuildContext context, {
    BankInfo? initialBankInfo,
    String? buttonLabel,
  }) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder:
              (context) =>
                  BankAccountScreen(initialBankInfo: initialBankInfo, buttonLabel: buttonLabel),
        ),
      )
      .then((result) => result ?? false);

  final BankInfo? initialBankInfo;
  final String? buttonLabel;

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final _bankAccountNumberController = TextEditingController();
  final _bankCodeController = TextEditingController();
  Bank? _selectedBank;
  Country? _selectedCountry;

  bool get _isValid =>
      _bankAccountNumberController.text.trim().isNotEmpty &&
      (_selectedBank != null || _bankCodeController.text.trim().isNotEmpty) &&
      _selectedCountry != null;

  Future<void> _handleSubmitted() async {
    final success = await runWithLoader<bool>(context, () async {
      try {
        await sl<KycSharingService>().updateBankInfo(
          hash: widget.initialBankInfo?.hash,
          bankAccountNumber: _bankAccountNumberController.text,
          bankCode: _selectedBank?.code ?? _bankCodeController.text.trim(),
          bankName: _selectedBank?.name ?? '',
          countryCode: _selectedCountry?.code ?? '',
        );

        return true;
      } on Exception {
        if (!mounted) return false;
        showCpErrorSnackbar(context, message: context.l10n.failedToUpdateData);

        return false;
      }
    });

    if (!mounted) return;
    if (success) Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();

    _bankCodeController
      ..text = widget.initialBankInfo?.bankCode ?? ''
      ..addListener(_updateSelectedBank);

    _bankAccountNumberController.text = widget.initialBankInfo?.accountNumber ?? '';

    final initialBank = ngBanks.firstWhereOrNull(
      (bank) => bank.code == widget.initialBankInfo?.bankCode,
    );

    _selectedCountry = Country.findByCode(widget.initialBankInfo?.countryCode ?? '');

    _selectedBank = initialBank;
  }

  void _updateSelectedBank() {
    if (_selectedCountry?.code != 'NG') {
      return;
    }

    final code = _bankCodeController.text.trim();
    setState(() => _selectedBank = (code: code, name: code));
  }

  @override
  void dispose() {
    _bankAccountNumberController.dispose();
    _bankCodeController
      ..removeListener(_updateSelectedBank)
      ..dispose();
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
      CountryPicker(
        backgroundColor: CpColors.blackGreyColor,
        placeholder: context.l10n.countryOfBank,
        country: _selectedCountry,
        onSubmitted:
            (country) => setState(() {
              _selectedCountry = country;
              _selectedBank = null;
              _bankCodeController.clear();
              _bankAccountNumberController.clear();
            }),
      ),
      const SizedBox(height: 16),
      if (_selectedCountry?.code == 'NG')
        BankTextField(
          placeholder: context.l10n.selectBank,
          initialBank: _selectedBank,
          onBankChanged: (bank) => setState(() => _selectedBank = bank),
        )
      else
        KycTextField(
          controller: _bankCodeController,
          inputType: TextInputType.name,
          placeholder: 'Bank Code',
        ),
      const SizedBox(height: 16),
      KycTextField(
        controller: _bankAccountNumberController,
        inputType: TextInputType.name,
        placeholder: context.l10n.accountNumber,
      ),
      const Spacer(),
      ListenableBuilder(
        listenable: Listenable.merge([_bankAccountNumberController, _bankCodeController]),
        builder:
            (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: widget.buttonLabel ?? context.l10n.next,
              onPressed: _isValid ? _handleSubmitted : null,
            ),
      ),
    ],
  );
}
