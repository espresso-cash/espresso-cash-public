import 'package:espressocash_app/features/kyc_sharing/screens/personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../feature_flags/data/feature_flags_manager.dart';
import '../../kyc_sharing/screens/bank_account_list_screen.dart';
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
  @override
  void initState() {
    super.initState();
    sl<KycSharingService>().initialized;
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
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.identityVerification.toUpperCase() +
            (sl<FeatureFlagsManager>().isBrijDemoEnabled() ? ' (Demo)' : ''),
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          if (!hasPersonalDetails(user))
            KycButton(
              label: 'Personal Details',
              onPressed: () =>
                  PersonalInformationScreen.push(context, readOnly: true),
            ),
          KycButton(
            label: context.l10n.bankAccount,
            onPressed: () => BankAccountListScreen.push(context),
          ),
          KycButton(
            label: context.l10n.emailAddress,
            description: user.getEmail,
            onPressed: context.openEmailFlow,
            status: user.emailStatus,
          ),
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

bool hasPersonalDetails(UserData user) =>
    user.firstName != null &&
    user.lastName != null &&
    user.dob != null &&
    user.citizenship != null;
