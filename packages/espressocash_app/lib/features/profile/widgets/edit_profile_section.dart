part of 'profile_section.dart';

class EditProfileSection extends StatelessWidget {
  const EditProfileSection({super.key});

  @override
  Widget build(BuildContext context) => ProfileSection(
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 24),
        actions: [
          ProfileButton(
            label: context.l10n.editProfile,
            onPressed: () => context.router.push(const EditProfileRoute()),
          ),
          const InvestmentsZeroBalanceSwitch(),
        ],
      );
}
