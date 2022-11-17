part of 'profile_section.dart';

class EditProfileSection extends StatelessWidget {
  const EditProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.profileSectionTitle,
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
          Consumer<InvestmentSettingsRepository>(
            builder: (context, state, child) => ProfileSwitch(
              label: context.l10n.displayEmptyBalanceTitle,
              subtitle: context.l10n.displayEmptyBalanceSubtitle,
              value: state.displayEmptyBalances,
              onChanged: (val) => state.toggleDisplayEmptyBalances(val),
            ),
          ),
        ],
      );
}
