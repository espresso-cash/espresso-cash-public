part of 'profile_section.dart';

class DangerSection extends StatelessWidget {
  const DangerSection({super.key});

  void _handleLogoutPressed(BuildContext context) => showConfirmationDialog(
    context,
    title: context.l10n.signOut.toUpperCase(),
    message: context.l10n.signOutConfirmation,
    onConfirm: () => runWithLoader(context, () => sl<AccountService>().logOut()),
    cancelLabel: context.l10n.core_btnCancel,
  );

  @override
  Widget build(BuildContext context) => CpBottomButton(
    horizontalPadding: 16,
    text: context.l10n.signOut,
    onPressed: () => _handleLogoutPressed(context),
    variant: CpButtonVariant.danger,
  );
}
