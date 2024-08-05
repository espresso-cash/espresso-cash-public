import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../di.dart';
import '../../../ui/button.dart';
import '../../../ui/form_page.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/text_field.dart';
import '../data/kyc_repository.dart';
import '../services/kyc_service.dart';
import 'kyc_details_screen.dart';

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
      KycDetailsScreen.pushReplacement(context);
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
  Widget build(BuildContext context) => FormPage(
        colorTheme: FormPageColorTheme.gold,
        title: Text('Phone Verification'.toUpperCase()),
        header: const SizedBox(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Please enter the 6-digit code sent to ${widget.phone}',
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
