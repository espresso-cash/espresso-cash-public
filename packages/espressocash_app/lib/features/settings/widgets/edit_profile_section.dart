part of 'settings_section.dart';

class EditProfileSection extends StatelessWidget {
  const EditProfileSection({super.key});

  @override
  Widget build(BuildContext context) => SettingsSection(
        padding: const EdgeInsets.fromLTRB(8, 16, 2, 16),
        actions: [
          SettingsButton(
            label: context.l10n.editProfile,
            onPressed: () => ManageProfileScreen.push(context),
          ),
        ],
      );
}
