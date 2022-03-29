part of 'profile_section.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.securitySectionTitle,
        actions: [
          ProfileButton(
            label: context.l10n.viewRecoveryPhrase,
            onPressed: () =>
                context.router.navigate(const BackupPhraseFlowRoute()),
          ),
          ProfileButton(
            label: context.l10n.appLock,
            onPressed: () =>
                context.router.navigate(const AppLockSetupFlowRoute()),
          )
        ],
      );
}
