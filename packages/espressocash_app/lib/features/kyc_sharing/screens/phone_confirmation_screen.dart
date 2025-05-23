import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_exception.dart';
import '../utils/kyc_utils.dart';
import '../widgets/kyc_page.dart';
import '../widgets/kyc_text_field.dart';

class PhoneConfirmationScreen extends StatefulWidget {
  const PhoneConfirmationScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (context) => const PhoneConfirmationScreen()))
      .then((result) => result ?? false);

  @override
  State<PhoneConfirmationScreen> createState() => _PhoneConfirmationScreenState();
}

class _PhoneConfirmationScreenState extends State<PhoneConfirmationScreen> {
  final _controller = TextEditingController();

  bool get _isValid => _controller.text.length == 6;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleConfirm() async {
    final success = await runWithLoader<bool>(context, () async {
      try {
        await sl<KycSharingService>().verifyPhone(code: _controller.text);

        return true;
      } on KycException catch (error) {
        if (!mounted) return false;

        final message = switch (error) {
          KycInvalidCode() => context.l10n.wrongVerificationCode,
          _ => context.l10n.tryAgainLater,
        };

        showCpErrorSnackbar(context, message: message);

        return false;
      }
    });

    if (!mounted) return;
    if (success) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) => KycPage(
    title: context.l10n.phoneVerification.toUpperCase(),
    children: [
      Text(
        context.l10n.checkSmsText(sl<KycSharingService>().value?.phoneValue ?? ''),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, height: 21 / 16, letterSpacing: .19),
      ),
      const SizedBox(height: 16),
      KycTextField(
        controller: _controller,
        inputType: TextInputType.number,
        placeholder: context.l10n.enterVerificationCode,
      ),
      const SizedBox(height: 16),
      const Spacer(),
      ListenableBuilder(
        listenable: _controller,
        builder:
            (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.verify,
              onPressed: _isValid ? _handleConfirm : null,
            ),
      ),
    ],
  );
}
