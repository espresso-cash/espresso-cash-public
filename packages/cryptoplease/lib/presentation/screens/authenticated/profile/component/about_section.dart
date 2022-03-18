part of 'profile_section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.aboutSectionTitle,
        actions: [
          ProfileButton(
            label: context.l10n.help,
            onPressed: () => context.router.navigate(const HelpRoute()),
          ),
          ProfileButton(
            label: context.l10n.followUsOnTwitter,
            onPressed: () => context.openLink(twitterUrl),
          ),
          ProfileButton(
            label: context.l10n.termsOfUse,
            onPressed: () => context.router.navigate(
              const TermsOfServiceRoute(),
            ),
          ),
          ProfileButton(
            label: context.l10n.privacyPolicy,
            onPressed: () => context.router.navigate(
              const PrivacyPolicyRoute(),
            ),
          )
        ],
      );
}
