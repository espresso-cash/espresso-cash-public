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
        ],
      );
}
