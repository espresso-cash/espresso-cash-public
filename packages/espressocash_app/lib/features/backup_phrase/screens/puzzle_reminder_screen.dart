import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/message_info_widget.dart';
import '../widgets/puzzle_screen.dart';
import 'puzzle_flow.dart';
import 'puzzle_postpone_screen.dart';

class PuzzleReminderScreen extends StatelessWidget {
  const PuzzleReminderScreen({super.key});

  static void push(BuildContext context) => Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const PuzzleReminderScreen(),
        ),
      );

  void _handleRemindPressed(BuildContext context) =>
      PuzzlePostponeScreen.push(context);

  @override
  Widget build(BuildContext context) => PuzzleScreen(
        title: context.l10n.protectWalletTitle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              CpMessageInfoWidget(
                backgroundColor: Colors.black,
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
                onPressed: () => context.launchPuzzleFlow(),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _handleRemindPressed(context),
                child: Text(
                  context.l10n.remindMeLater,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
