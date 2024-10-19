import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../feature_flags/services/feature_flags_manager.dart';
import '../../profile/widgets/profile_button.dart';
import '../../profile/widgets/profile_section.dart';
import '../models/kyc_user_info.dart';
import '../screens/bank_account_screen.dart';
import '../screens/manage_data_access_screen.dart';
import '../services/kyc_service.dart';
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
                final user = snapshot.data?.value.user;

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

  final KycUserInfo user;

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: 'Account profile'.toUpperCase(),
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          ProfileButton(
            label: 'Edit Profile',
            description: _getUserDescription(user),
            onPressed: context.openBasicInfoFlow,
          ),
          if (user.hasBankInfo)
            ProfileButton(
              label: 'Bank Account',
              description: _getBankDescription(user),
              onPressed: () => BankAccountScreen.push(context),
            ),
          if (user.email.isNotEmpty)
            ProfileButton(
              label: 'Email Address',
              description: user.email,
              onPressed: context.openEmailFlow,
            ),
          if (user.phone.isNotEmpty)
            ProfileButton(
              label: 'Phone Number',
              description: user.phone,
              onPressed: context.openPhoneFlow,
            ),
          ProfileButton(
            label: 'Manage Data Access',
            onPressed: () => ManageDataAccessScreen.push(context),
          ),
        ],
      );
}

String _getUserDescription(KycUserInfo user) => '''
${user.firstName.isNotEmpty ? user.firstName : ''} ${user.lastName.isNotEmpty ? user.lastName : ''}
DOB: ${user.dob}
ID Type: ${user.idType}
ID Number: ${user.idNumber.isNotEmpty ? user.idNumber : ''}
''';

String _getBankDescription(KycUserInfo user) => '''
${user.countryCode.isNotEmpty ? user.countryCode : ''}
${user.bankCode.isNotEmpty ? user.bankCode : ''}
${user.bankAccountNumber.isNotEmpty ? user.bankAccountNumber : ''}
''';
