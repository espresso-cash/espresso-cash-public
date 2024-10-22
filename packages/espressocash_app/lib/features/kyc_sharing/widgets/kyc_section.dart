import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../feature_flags/services/feature_flags_manager.dart';
import '../../profile/widgets/profile_section.dart';
import '../screens/bank_account_screen.dart';
import '../screens/manage_data_access_screen.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';
import 'kyc_button.dart';
import 'kyc_flow.dart';

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
  Widget build(BuildContext context) =>
      !sl<FeatureFlagsManager>().isXflowEnabled()
          ? const SizedBox.shrink()
          : FutureBuilder<KycSharingService>(
              future: _future,
              builder: (context, snapshot) {
                final user = snapshot.data?.value;

                return snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError ||
                        user == null
                    ? const SizedBox.shrink()
                    : _KycInfo(user: user);
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
        title: 'Account profile'.toUpperCase(),
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          KycButton(
            label: 'Edit Profile',
            description: _getUserDescription(user),
            onPressed: context.openBasicInfoFlow,
            status: user.kycStatus,
          ),
          if (user.hasBankInfo)
            KycButton(
              label: 'Bank Account',
              description: _getBankDescription(user),
              onPressed: () => BankAccountScreen.push(context),
            ),
          if (user.getEmail.isNotEmpty)
            KycButton(
              label: 'Email Address',
              description: user.getEmail,
              onPressed: context.openEmailFlow,
              status: user.emailStatus,
            ),
          if (user.getPhone.isNotEmpty)
            KycButton(
              label: 'Phone Number',
              description: user.getPhone,
              onPressed: context.openPhoneFlow,
              status: user.phoneStatus,
            ),
          KycButton(
            label: 'Manage Data Access',
            onPressed: () => ManageDataAccessScreen.push(context),
          ),
        ],
      );
}

String _getUserDescription(UserData user) => '''
${user.firstName.isNotEmpty ? user.firstName : ''} ${user.lastName.isNotEmpty ? user.lastName : ''}
DOB: ${user.dob}
ID Type: ${user.documentType}
ID Number: ${user.documentNumber.isNotEmpty ? user.documentNumber: ''}
''';

String _getBankDescription(UserData user) => '''
${user.countryCode.isNotEmpty ? user.countryCode : ''}
${user.bankCode.isNotEmpty ? user.bankCode : ''}
${user.accountNumber.isNotEmpty ? user.accountNumber : ''}
''';
