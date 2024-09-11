import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/snackbar.dart';
import '../../profile/data/profile_repository.dart';
import '../data/kyc_repository.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_screen.dart';
import '../widgets/kyc_text_field.dart';
import 'phone_verification_screen.dart';

class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const EmailConfirmationScreen(),
        ),
      );

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  final _controller = TextEditingController();

  bool get _isValid => _controller.text.length == 6;

  Future<void> _handleConfirm() async {
    final service = sl<KycSharingService>();

    final isValid =
        await service.verifyField(identifier: 'email', value: _controller.text);

    if (isValid) {
      if (!mounted) return;

      showCpSnackbar(context, message: 'Success, email verified');
      sl<KycRepository>().hasValidatedEmail = true;
      Navigator.pop(context);
      PhoneVerificationScreen.pushReplacement(context);
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
        title: 'Email verification',
        children: [
          const SizedBox(height: 20),
          Text(
            "Check your email. We've sent the code to ${sl<ProfileRepository>().email}",
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
