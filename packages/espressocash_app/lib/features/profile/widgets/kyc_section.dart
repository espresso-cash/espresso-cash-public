part of 'profile_section.dart';

class KycSection extends StatelessWidget {
  const KycSection({super.key});

  @override
  Widget build(BuildContext context) =>
      !sl<FeatureFlagsManager>().isKycSharingEnabled()
          ? const SizedBox.shrink()
          : ProfileSection(
              title: 'KYC INFO',
              padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
              actions: [
                ProfileButton(
                  label: 'Email',
                  description: 'sdfasdf@test.com',
                  onPressed: () => KycFlow.open(context),
                ),
                ProfileButton(
                  label: 'Phone number',
                  description: '+336759678',
                  onPressed: () => KycFlow.open(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ProfileButton(
                    label: 'Basic infos',
                    description: 'Antoine Herzog\n26/10/1979\nPassword Id:1234',
                    onPressed: () => KycFlow.open(context),
                  ),
                ),
                ProfileButton(
                  label: 'Banking info',
                  description: 'Nigeria\nAccount number: 334343\nIBAN: 12345',
                  onPressed: () => KycFlow.open(context),
                ),
                ProfileButton(
                  label: 'Manage data access',
                  onPressed: () => KycFlow.open(context),
                ),
              ],
            );
}
