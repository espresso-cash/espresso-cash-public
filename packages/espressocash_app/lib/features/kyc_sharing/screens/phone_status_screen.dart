import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/bottom_button.dart';
import '../../../utils/phone.dart';
import '../../country_picker/models/country.dart';
import '../models/kyc_validation_status.dart';
import '../utils/kyc_utils.dart';
import '../widgets/extensions.dart';
import '../widgets/kyc_header.dart';
import '../widgets/kyc_page.dart';
import '../widgets/phone_text_field.dart';
import '../widgets/user_data_listener.dart';
import 'phone_confirmation_screen.dart';

class PhoneStatusScreen extends StatelessWidget {
  const PhoneStatusScreen({super.key});

  static Future<bool> push(BuildContext context) => Navigator.of(context)
      .push<bool>(MaterialPageRoute(builder: (context) => const PhoneStatusScreen()))
      .then((result) => result ?? false);

  @override
  Widget build(BuildContext context) => UserDataListener(
    builder: (context, userData) {
      final status = userData.phoneStatus;
      final phone = userData.phoneValue ?? '-';

      return KycPage(
        icon: status.kycIcon,
        children: [
          switch (status) {
            KycValidationStatus.unverified || KycValidationStatus.pending => KycHeader(
              title: context.l10n.phonePendingStatusTitle,
              description: context.l10n.phonePendingStatusDescription(phone),
            ),
            KycValidationStatus.approved => KycHeader(
              title: context.l10n.phoneApprovedStatusTitle,
              description: context.l10n.phoneApprovedStatusDescription(phone),
            ),
            KycValidationStatus.rejected => KycHeader(
              title: context.l10n.phoneRejectedStatusTitle,
              description: context.l10n.phoneRejectedStatusDescription(phone),
            ),
          },
          const SizedBox(height: 16),
          // ignore: avoid-flexible-outside-flex, inside column
          Expanded(child: _UpdatePhoneContent(status: status)),
        ],
      );
    },
  );
}

class _UpdatePhoneContent extends StatefulWidget {
  const _UpdatePhoneContent({required this.status});

  final KycValidationStatus status;

  @override
  State<_UpdatePhoneContent> createState() => __UpdatePhoneContentState();
}

class __UpdatePhoneContentState extends State<_UpdatePhoneContent> {
  final _phoneController = TextEditingController();
  String _fullPhoneNumber = '';

  String get _placeholderText => switch (widget.status) {
    KycValidationStatus.rejected => context.l10n.phoneNumber,
    KycValidationStatus.approved ||
    KycValidationStatus.pending ||
    KycValidationStatus.unverified => context.l10n.updatePhoneNumber,
  };

  Future<void> _handleSendVerification() async {
    final result = await context.sendPhoneVerification(context, phone: _fullPhoneNumber);

    if (!mounted) return;
    if (!result) return;

    Navigator.pop(context);
    await PhoneConfirmationScreen.push(context);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      PhoneNumberTextField(
        controller: _phoneController,
        initialCountry: Country.findByCode('NG'),
        placeholder: _placeholderText,
        onPhoneChanged: (fullNumber) => setState(() => _fullPhoneNumber = fullNumber),
      ),
      const SizedBox(height: 16),
      const Spacer(),
      ListenableBuilder(
        listenable: _phoneController,
        builder:
            (context, child) => CpBottomButton(
              horizontalPadding: 16,
              text: context.l10n.sendVerificationCode,
              onPressed: _fullPhoneNumber.isValidPhone ? _handleSendVerification : null,
            ),
      ),
    ],
  );
}
