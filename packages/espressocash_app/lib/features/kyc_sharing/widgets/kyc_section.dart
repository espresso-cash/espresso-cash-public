import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../feature_flags/services/feature_flags_manager.dart';
import '../../profile/widgets/profile_button.dart';
import '../../profile/widgets/profile_section.dart';
import '../models/kyc_model.dart';
import '../screens/kyc_flow.dart';
import '../services/kyc_service.dart';

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
      !sl<FeatureFlagsManager>().isKycSharingEnabled()
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
        title: 'KYC INFO',
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          if (user.email.isNotEmpty)
            ProfileButton(
              label: 'Email',
              description: user.email,
              onPressed: () => KycFlow.open(context),
            ),
          if (user.phone.isNotEmpty)
            ProfileButton(
              label: 'Phone number',
              description: user.phone,
              onPressed: () => KycFlow.open(context),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ProfileButton(
              label: 'Basic info',
              description: _getUserDescription(user),
              onPressed: () => KycFlow.open(context),
            ),
          ),
          if (user.hasBankInfo)
            ProfileButton(
              label: 'Banking info',
              description: _getBankDescription(user),
              onPressed: () => KycFlow.open(context),
            ),
          ProfileButton(
            label: 'Manage data access',
            onPressed: () => KycFlow.open(context),
          ),
        ],
      );
}

String _getUserDescription(KycUserInfo user) => '''
${user.firstName.isNotEmpty ? user.firstName : ''} ${user.middleName.isNotEmpty ? user.middleName : ''} ${user.lastName.isNotEmpty ? user.lastName : ''}
${user.dob.isNotEmpty ? user.dob : ''}
${user.idNumber.isNotEmpty ? user.idNumber : ''}
''';

String _getBankDescription(KycUserInfo user) => '''
${user.countryCode.isNotEmpty ? user.countryCode : ''}
${user.bankCode.isNotEmpty ? user.bankCode : ''}
${user.bankAccountNumber.isNotEmpty ? user.bankAccountNumber : ''}
''';
