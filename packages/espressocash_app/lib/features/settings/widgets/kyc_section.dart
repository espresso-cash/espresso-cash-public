import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../country_picker/models/country.dart';
import '../../kyc_sharing/screens/bank_account_screen.dart';
import '../../kyc_sharing/services/kyc_service.dart';
import '../../kyc_sharing/utils/kyc_utils.dart';
import '../../kyc_sharing/widgets/kyc_button.dart';
import '../../kyc_sharing/widgets/kyc_flow.dart';
import 'settings_section.dart';

class KycSection extends StatefulWidget {
  const KycSection({super.key});

  @override
  State<KycSection> createState() => _KycSectionState();
}

class _KycSectionState extends State<KycSection> {
  @override
  void initState() {
    super.initState();
    final kycService = sl<KycSharingService>();
    if (kycService.value == null) {
      kycService.fetchUserData();
    }
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, user, _) =>
            user == null ? const SizedBox.shrink() : _KycInfo(user: user),
      );
}

class _KycInfo extends StatelessWidget {
  const _KycInfo({required this.user});

  final UserData user;

  @override
  Widget build(BuildContext context) => SettingsSection(
        title: context.l10n.accountProfile.toUpperCase(),
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          KycButton(
            label: context.l10n.editProfile,
            description: _getUserDescription(user, context),
            onPressed: context.openBasicInfoFlow,
            status: user.kycStatus.isUnspecified ? null : user.kycStatus,
          ),
          if (user.hasBankInfo)
            KycButton(
              label: context.l10n.bankAccount,
              description: _getBankDescription(user, context),
              onPressed: () => BankAccountScreen.push(context),
            ),
          if (user.getEmail != null)
            KycButton(
              label: context.l10n.emailAddress,
              description: user.getEmail,
              onPressed: context.openEmailFlow,
              status: user.emailStatus,
            ),
          if (user.getPhone != null)
            KycButton(
              label: context.l10n.phoneNumber,
              description: user.getPhone,
              onPressed: context.openPhoneFlow,
              status: user.phoneStatus,
            ),
          // TODO(dev): hidden for now, still in development
          // if (!user.kycStatus.isUnspecified)
          //   KycButton(
          //     label: context.l10n.manageDataAccess,
          //     onPressed: () => ManageDataAccessScreen.push(context),
          //   ),
        ],
      );
}

String? _getUserDescription(UserData user, BuildContext context) {
  final items = [
    [user.firstName, user.lastName].whereType<String>().join(' ').trim(),
    if (user.dob case final dob?)
      context.l10n.userDescriptionItem1Text(_formatDate(dob)),
    if (user.documentType case final idType?)
      context.l10n.userDescriptionItem2Text(idType.name),
    if (user.documentNumber case final documentNumber?)
      context.l10n.userDescriptionItem3Text(documentNumber),
  ].where((s) => s.isNotEmpty);

  return items.isEmpty ? null : items.join('\n');
}

String? _getBankDescription(UserData user, BuildContext context) {
  final country = Country.findByCode(user.countryCode ?? '');

  final items = [
    if (country case final country?)
      context.l10n.bankDescriptionItem1Text(country.name),
    if (user.accountNumber case final accountNumber?)
      context.l10n.bankDescriptionItem2Text(accountNumber),
    if (user.bankCode case final bankCode?)
      context.l10n.bankDescriptionItem3Text(bankCode),
  ].where((s) => s.isNotEmpty);

  return items.isEmpty ? null : items.join('\n');
}

String _formatDate(DateTime date) => DateFormat('MMMM d, yyyy').format(date);
