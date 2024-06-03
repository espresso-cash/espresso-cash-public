part of 'profile_section.dart';

class DangerSection extends StatelessWidget {
  const DangerSection({super.key});

  void _handleLogoutPressed(BuildContext context) => showConfirmationDialog(
        context,
        title: context.l10n.signOut.toUpperCase(),
        message: context.l10n.signOutConfirmation,
        onConfirm: () => runWithLoader(
          context,
          () => sl<AccountService>().logOut(),
        ),
        cancelLabel: context.l10n.core_btnCancel,
      );

  @override
  Widget build(BuildContext context) => ProfileSection(
        padding: const EdgeInsets.only(left: 4, bottom: 4),
        actions: [
          ProfileButton(
            label: context.l10n.signOut,
            onPressed: () => _handleLogoutPressed(context),
            textColor: CpColors.dangerButtonTextColor,
            backgroundColor: CpColors.darkOrangeButtonBackground,
            iconColor: CpColors.dangerButtonChevronColor,
          ),
        ],
        color: CpColors.darkOrangeButtonBackground,
      );
}
