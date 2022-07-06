part of 'profile_section.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.securitySectionTitle,
        actions: const [
          RecoveryPhraseButton(),
          AppLockButton(),
        ],
      );
}
