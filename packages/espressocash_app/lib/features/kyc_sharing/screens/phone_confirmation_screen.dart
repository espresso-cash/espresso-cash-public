import 'package:flutter/material.dart';
import 'package:kyc_app_client/kyc_app_client.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class PhoneConfirmationScreen extends StatefulWidget {
  const PhoneConfirmationScreen(this.phone, {super.key});

  final String phone;

  // Todo(vsumin): pass phone
  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const PhoneConfirmationScreen('phone'),
        ),
      )
      .then((result) => result ?? false);
  @override
  State<PhoneConfirmationScreen> createState() =>
      _PhoneConfirmationScreenState();
}

class _PhoneConfirmationScreenState extends State<PhoneConfirmationScreen> {
  final _controller = TextEditingController();

  bool get _isValid => _controller.text.length == 6;

  Future<void> _handleConfirm() async {
    final service = sl<KycSharingService>();

    final isValid = await service.verifyAndValidateField(
      identifier: OtpType.phone,
      value: _controller.text,
    );

    if (!mounted) return;

    if (isValid) {
      Navigator.pop(context, true);
    } else {
      showCpErrorSnackbar(
        context,
        message: 'Invalid verification code',
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => KycPage(
        title: 'Phone verification',
        children: [
          const SizedBox(height: 20),
          Text(
            "Check your text messages. We've sent the code to ${widget.phone}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 21 / 16,
              letterSpacing: .19,
            ),
          ),
          const SizedBox(height: 40),
          KycTextField(
            controller: _controller,
            inputType: TextInputType.number,
            placeholder: 'Enter Verification Code',
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, child) => CpButton(
                width: double.infinity,
                text: 'Next',
                onPressed: _isValid ? _handleConfirm : null,
              ),
            ),
          ),
        ],
      );
}
