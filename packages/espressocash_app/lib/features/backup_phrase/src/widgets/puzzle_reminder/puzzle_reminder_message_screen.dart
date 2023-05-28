import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/message_info_widget.dart';
import 'components/puzzle_screen.dart';

class PuzzleReminderMessageScreen extends StatelessWidget {
  const PuzzleReminderMessageScreen({super.key});

  void _remindMeLater(BuildContext context) {
    context.router.push(const PuzzleReminderSetupRoute());
  }

  @override
  Widget build(BuildContext context) => PuzzleScreen(
        title: context.l10n.protectWalletTitle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              CpMessageInfoWidget(
                padding: const EdgeInsets.all(32),
                content: Wrap(
                  runSpacing: 20,
                  children: [
                    Text(context.l10n.protectYourWalletParagraph1),
                    Text(context.l10n.protectYourWalletParagraph2),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CpButton(
                text: context.l10n.protectWallet,
                size: CpButtonSize.big,
                minWidth: 300,
                onPressed: () async {
                  final result = await context.router
                      .push<bool>(const BackupPhraseFlowRoute());
                  if (result == true && context.mounted) {
                    await context.router.pop();
                  }
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _remindMeLater(context),
                child: Text(
                  context.l10n.remindMeLater,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
