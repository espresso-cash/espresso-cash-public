part of 'profile_section.dart';

class EditProfileSection extends StatelessWidget {
  const EditProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.profileSectionTitle,
        padding: const EdgeInsets.only(left: 4, bottom: 4),
        actions: [
          ProfileButton(
            label: context.l10n.editProfile,
            onPressed: () => context.router.push(const EditProfileRoute()),
          ),
          ProfileButton(
            label: context.l10n.termsOfUse,
            onPressed: () => context.navigateToTermsOfUse(),
          ),
          ProfileButton(
            label: context.l10n.privacyPolicy,
            onPressed: () => context.navigateToPrivacyPolicy(),
          ),
          const InvestmentsZeroBalanceSwitch(),
        ],
      );
}
