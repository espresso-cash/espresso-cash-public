part of 'profile_section.dart';

class DangerSection extends StatelessWidget {
  const DangerSection({Key? key}) : super(key: key);

  void _onLogOutPressed(BuildContext context) => showConfirmationDialog(
        context,
        title: context.l10n.signOut,
        message: context.l10n.signOutConfirmation,
        onConfirm: () {
          context.read<AccountsBloc>().add(const AccountsEvent.loggedOut());
          context
              .read<PuzzleReminderBloc>()
              .add(const PuzzleReminderEvent.loggedOut());
          context.read<SplitKeyIncomingRepository>().clear();
          context.read<AppLockBloc>().add(const AppLockEvent.logout());
          context.read<OutgoingTransferRepository>().clear();
          context.read<PaymentRequestRepository>().clear();
        },
      );

  @override
  Widget build(BuildContext context) => ProfileSection(
        title: context.l10n.dangerZoneSectionTitle,
        actions: [
          ProfileButton(
            label: context.l10n.signOut,
            onPressed: () => _onLogOutPressed(context),
          ),
        ],
        color: CpColors.primaryColor,
      );
}
