import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/snackbar.dart';
import '../../profile/data/profile_repository.dart';
import '../services/kyc_service.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(
        MaterialPageRoute(
          builder: (context) => const EmailConfirmationScreen(),
        ),
      )
      .then((result) => result ?? false);

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  final _controller = TextEditingController();

  bool get _isValid => _controller.text.length == 6;

  Future<void> _handleConfirm() async {
    final service = sl<KycSharingService>();

    try {
      await service.verifyEmail(code: _controller.text);

      if (!mounted) return;

      Navigator.pop(context, true);
    } on Exception {
      showCpErrorSnackbar(
        context,
        message: 'Wrong verification code',
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
