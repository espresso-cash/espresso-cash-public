import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/text_field.dart';
import '../services/kyc_service.dart';
import 'phone_confirmation_screen.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const PhoneVerificationScreen(),
        ),
      );

  @override
  State<PhoneVerificationScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneVerificationScreen> {
  final _numberController = TextEditingController();

  bool get _isValid => RegExp(
        r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
      ).hasMatch(_numberController.text);

  Future<void> _sendSms(String phoneNumber) async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          final service = sl<KycSharingService>();

          await service.updateField(
              key: DataInfoKeys.email, value: phoneNumber);

          return true;
        } on Exception catch (ex) {
          print('failed: $ex');

          if (!mounted) return false;

          showCpErrorSnackbar(
            context,
            message: 'Failed to send verification code',
          );

          return false;
        }
      },
    );
    if (!mounted) return;
    if (success) PhoneConfirmationScreen.push(context);
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CpAppBar(
          title: Text('Phone number Verification'),
        ),
        backgroundColor: const Color(0xFFC8B57D),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  'Enter phone number to get verification code:',
                  style: TextStyle(
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
                  controller: _numberController,
                  inputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  backgroundColor: const Color(0xFF9D8A59),
                  placeholder: 'Enter number',
                  placeholderColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 16,
                ),
                const Spacer(),
                ListenableBuilder(
                  listenable: _numberController,
                  builder: (context, child) => CpButton(
                    width: double.infinity,
                    text: 'Send verification code',
                    onPressed: _isValid
                        ? () => _sendSms(_numberController.text)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
