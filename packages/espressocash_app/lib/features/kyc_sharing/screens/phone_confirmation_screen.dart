import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/snackbar.dart';
import '../data/kyc_repository.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_text_field.dart';
import 'basic_information_screen.dart';
import 'kyc_screen.dart';

class PhoneConfirmationScreen extends StatefulWidget {
  const PhoneConfirmationScreen(this.phone, {super.key});

  final String phone;

  static void push(BuildContext context, String phone) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => PhoneConfirmationScreen(phone),
        ),
      );

  @override
  State<PhoneConfirmationScreen> createState() =>
      _PhoneConfirmationScreenState();
}

class _PhoneConfirmationScreenState extends State<PhoneConfirmationScreen> {
  final _controller = TextEditingController();

  bool get _isValid => _controller.text.length == 6;

  Future<void> _handleConfirm() async {
    final service = sl<KycSharingService>();

    final isValid =
        await service.verifyField(identifier: 'phone', value: _controller.text);

    if (isValid) {
      if (!mounted) return;

      showCpSnackbar(context, message: 'Success, phone number verified');
      sl<KycRepository>().hasValidatedPhone = true;
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      if (!mounted) return;
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
  Widget build(BuildContext context) => KycScreen(
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
