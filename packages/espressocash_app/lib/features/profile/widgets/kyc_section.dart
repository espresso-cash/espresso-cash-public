import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../kyc_sharing/screens/bank_account_screen.dart';
import '../../kyc_sharing/screens/manage_data_access_screen.dart';
import '../../kyc_sharing/services/kyc_service.dart';
import '../../kyc_sharing/utils/kyc_utils.dart';
import '../../kyc_sharing/widgets/kyc_button.dart';
import '../../kyc_sharing/widgets/kyc_flow.dart';
import 'profile_section.dart';

class KycSection extends StatefulWidget {
  const KycSection({super.key});

  @override
  State<KycSection> createState() => _KycSectionState();
}

class _KycSectionState extends State<KycSection> {
  late Future<KycSharingService> _future;

  @override
  void initState() {
    super.initState();

    _future = sl.getAsync<KycSharingService>();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<KycSharingService>(
        future: _future,
        builder: (context, snapshot) {
          final user = snapshot.data?.value;

          return snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.hasError ||
                  user == null
              ? const SizedBox.shrink()
              : ValueListenableBuilder<UserData?>(
                  valueListenable: sl<KycSharingService>(),
                  builder: (context, user, _) => user == null
                      ? const SizedBox.shrink()
                      : _KycInfo(user: user),
                );
        },
      );
}

class _KycInfo extends StatelessWidget {
  const _KycInfo({
    required this.user,
  });

  final UserData user;

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.accountProfile.toUpperCase(),
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          KycButton(
            label: context.l10n.editProfile,
            description: _getUserDescription(user),
            onPressed: context.openBasicInfoFlow,
            status: user.kycStatus,
          ),
          if (user.hasBankInfo)
            KycButton(
              label: context.l10n.bankAccount,
              description: _getBankDescription(user),
              onPressed: () => BankAccountScreen.push(context),
            ),
          if (user.getEmail.isNotEmpty)
            KycButton(
              label: context.l10n.emailAddress,
              description: user.getEmail,
              onPressed: context.openEmailFlow,
              status: user.emailStatus,
            ),
          if (user.getPhone.isNotEmpty)
            KycButton(
              label: context.l10n.phoneNumber,
              description: user.getPhone,
              onPressed: context.openPhoneFlow,
              status: user.phoneStatus,
            ),
          KycButton(
            label: context.l10n.manageDataAccess,
            onPressed: () => ManageDataAccessScreen.push(context),
          ),
        ],
      );
}

String _getUserDescription(UserData user) => '''
${user.firstName.isNotEmpty ? user.firstName : ''} ${user.lastName.isNotEmpty ? user.lastName : ''}
DOB: ${user.dob}
ID Type: ${user.documentType}
ID Number: ${user.documentNumber.isNotEmpty ? user.documentNumber : ''}
''';

String _getBankDescription(UserData user) => '''
${user.countryCode.isNotEmpty ? user.countryCode : ''}
${user.bankCode.isNotEmpty ? user.bankCode : ''}
${user.accountNumber.isNotEmpty ? user.accountNumber : ''}
''';
