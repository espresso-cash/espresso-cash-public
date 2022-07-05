import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class PuzzleReminderDialogMessageScreen extends StatelessWidget {
  const PuzzleReminderDialogMessageScreen({Key? key}) : super(key: key);

  void _remindMeLater(BuildContext context) {
    context.router.replace(const PuzzleReminderDialogSetupRoute());
  }

  @override
  Widget build(BuildContext context) {
    final paragraphStyle = Theme.of(context)
        .textTheme
        .bodyText1
        ?.copyWith(color: CpColors.primaryTextColor);

    return AlertDialog(
      title: Text(
        context.l10n.protectYourWallet,
        style: Theme.of(context).textTheme.headline3,
      ),
      actions: [
        CpButton(
          text: context.l10n.protectWallet,
          width: double.infinity,
          onPressed: () async {
            final result =
                await context.router.push<bool>(const BackupPhraseFlowRoute());
            if (result == true) {
              await context.router.pop();
            }
          },
        ),
        const SizedBox(height: 12),
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 44),
            shape: const StadiumBorder(),
          ),
          onPressed: () => _remindMeLater(context),
          child: Text(context.l10n.remindMeLater),
        )
      ],
      content: Wrap(
        runSpacing: 20,
        children: [
          Text(context.l10n.protectYourWalletParagraph1, style: paragraphStyle),
          Text(context.l10n.protectYourWalletParagraph2, style: paragraphStyle),
          const SizedBox(height: 80),
        ],
      ),
      actionsPadding: const EdgeInsets.all(16),
    );
  }
}
