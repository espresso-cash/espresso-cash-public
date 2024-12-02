import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../country_picker/models/country.dart';
import '../../country_picker/widgets/phone_text_field.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_exception.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';
import '../widgets/styles.dart';

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
  String _fullPhoneNumber = '';

  bool get _isValid => RegExp(
        r'^\+[0-9]{1,4}[0-9]{6,14}$',
      ).hasMatch(_fullPhoneNumber);

  Future<void> _sendSms() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          await sl<KycSharingService>()
              .initPhoneVerification(phone: _fullPhoneNumber);

          return true;
        } on KycException catch (error) {
          if (!mounted) return false;

          final message = switch (error) {
            KycInvalidPhone() => context.l10n.invalidPhone,
            _ => context.l10n.failedToSendVerificationCode,
          };

          showCpErrorSnackbar(context, message: message);

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
            onPhoneChanged: (fullNumber) =>
                setState(() => _fullPhoneNumber = fullNumber),
          ),
          const Spacer(),
          ListenableBuilder(
            listenable: _numberController,
            builder: (context, child) => CpBottomButton(
              text: context.l10n.sendVerificationCode,
              onPressed: _isValid ? _sendSms : null,
            ),
          ),
        ],
      );
}
