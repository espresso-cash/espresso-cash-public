import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kyc_app_client/kyc_app_client.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/text_field.dart';
import '../data/client.dart';
import '../data/verification_repository.dart';
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
    final response = await otpClient.verifyOtp(
      VerifyOtpRequest(
        identifier: 'email',
        otp: _controller.text,
      ),
    );

    if (response.isValid) {
      if (!mounted) return;

      showCpSnackbar(context, message: 'Success, email verified');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      showCpErrorSnackbar(
        context,
        message: 'Invalid verification code',
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CpAppBar(
          title: Text('Email Verification'),
        ),
        backgroundColor: const Color(0xFFC8B57D),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Please enter the 6-digit code sent to ${sl<VerificationRepository>().email ?? ''}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                CpTextField(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 16,
                    left: 26,
                    right: 26,
                  ),
                  border: CpTextFieldBorder.rounded,
                  controller: _controller,
                  inputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  textInputAction: TextInputAction.next,
                  backgroundColor: const Color(0xFF9D8A59),
                  placeholder: 'enter code',
                  placeholderColor: Colors.white,
                  textColor: Colors.white,
                  textAlign: TextAlign.center,
                  fontSize: 16,
                ),
                const Spacer(),
                ListenableBuilder(
                  listenable: _controller,
                  builder: (context, child) => CpButton(
                    width: double.infinity,
                    text: 'Confirm',
                    onPressed: _isValid ? _handleConfirm : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
