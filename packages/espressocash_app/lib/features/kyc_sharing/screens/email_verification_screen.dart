import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../../../ui/text_field.dart';
import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/form_page.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../../profile/data/profile_repository.dart';
import '../services/kyc_service.dart';
import 'email_confirmation_screen.dart';

const partnerAuthPk = 'HHV5joB6D4c2pigVZcQ9RY5suDMvAiHBLLBCFqmWuM4E';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const EmailVerificationScreen(),
        ),
      );

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final repository = sl<ProfileRepository>();

    _emailController.text = repository.email;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    final success = await runWithLoader<bool>(
      context,
      () async {
        try {
          final service = sl<KycSharingService>();

          await service.updateField(
            key: DataInfoKeys.email,
            value: _emailController.text,
          );

          return true;
        } on Exception {
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
    if (success) EmailConfirmationScreen.push(context);
  }

  @override
  Widget build(BuildContext context) => FormPage(
        colorTheme: FormPageColorTheme.gold,
        title: Text('Email Verification'.toUpperCase()),
        header: const SizedBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  'Enter email to get verification code:',
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
                  controller: _emailController,
                  inputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  backgroundColor: const Color(0xFF9D8A59),
                  placeholder: 'Enter email',
                  placeholderColor: Colors.white,
                  textColor: Colors.white,
                  fontSize: 16,
                ),
                const Spacer(),
                ListenableBuilder(
                  listenable: _emailController,
                  builder: (context, child) => CpButton(
                    width: double.infinity,
                    text: 'Send verification code',
                    onPressed: _sendEmail,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}


