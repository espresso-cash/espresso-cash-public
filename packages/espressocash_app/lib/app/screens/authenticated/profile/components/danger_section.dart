part of 'profile_section.dart';

class DangerSection extends StatelessWidget {
  const DangerSection({super.key});

  void _onLogOutPressed(BuildContext context) => showConfirmationDialog(
        context,
        title: context.l10n.signOut,
        message: context.l10n.signOutConfirmation,
        onConfirm: () {
          context.read<AccountsBloc>().add(const AccountsEvent.loggedOut());
        },
        confirmLabel: context.l10n.yesDeleteMyWallet,
      );

  @override
  Widget build(BuildContext context) => ProfileSection(
        padding: const EdgeInsets.only(left: 4, bottom: 4),
        actions: [
          ProfileButton(
            label: context.l10n.signOut,
            onPressed: () => _onLogOutPressed(context),
            color: CpColors.primaryColor,
          ),
        ],
        color: CpColors.primaryAccentColor,
      );
}
