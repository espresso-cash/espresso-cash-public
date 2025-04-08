import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../utils/phone.dart';
import '../../country_picker/models/country.dart';
import '../widgets/extensions.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';
import '../widgets/phone_text_field.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (context) => const PhoneVerificationScreen()))
      .then((result) => result ?? false);

  @override
  State<PhoneVerificationScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneVerificationScreen> {
  final _numberController = TextEditingController();
  String _fullPhoneNumber = '';

  Future<void> _handleSendVerification() async {
    final result = await context.sendPhoneVerification(context, phone: _fullPhoneNumber);

    if (!mounted) return;
    if (result) Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycPage(
    children: [
      KycHeader(
        title: context.l10n.phoneVerificationTitle.toUpperCase(),
        description: context.l10n.enterPhoneNumberHintText,
      ),
      const SizedBox(height: 16),
      PhoneNumberTextField(
        controller: _numberController,
        initialCountry: Country.findByCode('NG'),
        placeholder: context.l10n.phoneNumber,
        onPhoneChanged: (fullNumber) => setState(() => _fullPhoneNumber = fullNumber),
      ),
      const SizedBox(height: 16),
      const Spacer(),
      ListenableBuilder(
        listenable: _numberController,
        builder:
            (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.sendVerificationCode,
              onPressed: _fullPhoneNumber.isValidPhone ? _handleSendVerification : null,
            ),
      ),
    ],
  );
}
