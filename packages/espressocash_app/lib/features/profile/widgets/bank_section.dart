import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../country_picker/models/country.dart';
import '../../feature_flags/data/feature_flags_manager.dart';
import '../../kyc_sharing/screens/bank_account_screen.dart';
import '../../kyc_sharing/services/kyc_service.dart';
import '../../kyc_sharing/widgets/kyc_button.dart';
import 'profile_section.dart';

class BankSection extends StatefulWidget {
  const BankSection({super.key});

  @override
  State<BankSection> createState() => _BankSectionState();
}

class _BankSectionState extends State<BankSection> {
  @override
  void initState() {
    super.initState();
    sl<KycSharingService>().initialized;
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<UserData?>(
        valueListenable: sl<KycSharingService>(),
        builder: (context, user, _) =>
            user == null ? const SizedBox.shrink() : _BankInfo(user: user),
      );
}

class _BankInfo extends StatelessWidget {
  const _BankInfo({required this.user});

  final UserData user;

  @override
  Widget build(BuildContext context) {
    final bankInfos = user.bankInfos ?? [];

    return ProfileSection(
      title: context.l10n.bankAccount.toUpperCase() +
          (sl<FeatureFlagsManager>().isBrijDemoEnabled() ? ' (Demo)' : ''),
      padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
      actions: [
        for (final bankInfo in bankInfos)
          KycButton(
            label: context.l10n.bankAccount,
            description: _getBankDescription(bankInfo, context),
            onPressed: () => BankAccountScreen.push(context),
          ),
        KycButton(
          label: 'Add New Bank',
          icon: Icons.add,
          onPressed: () => BankAccountScreen.push(context),
        ),
      ],
    );
  }
}

String? _getBankDescription(BankInfo bankInfo, BuildContext context) {
  final country = Country.findByCode(bankInfo.countryCode);

  final items = [
    if (country case final country?)
      context.l10n.bankDescriptionItem1Text(country.name),
    if (bankInfo.accountNumber case final accountNumber)
      context.l10n.bankDescriptionItem2Text(accountNumber),
    if (bankInfo.bankCode case final bankCode)
      context.l10n.bankDescriptionItem3Text(bankCode),
    if (bankInfo.bankName.isNotEmpty) bankInfo.bankName,
  ].where((s) => s.isNotEmpty);

  return items.isEmpty ? null : items.join('\n');
}

String _formatDate(DateTime date) => DateFormat('MMMM d, yyyy').format(date);
