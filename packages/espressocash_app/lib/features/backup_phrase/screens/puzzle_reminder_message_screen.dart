import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/button.dart';
import '../../../ui/message_info_widget.dart';
import '../../onboarding/screens/onboarding_screen.dart';
import '../widgets/puzzle_screen.dart';
import 'puzzle_reminder_setup_screen.dart';

class PuzzleReminderMessageScreen extends StatelessWidget {
  const PuzzleReminderMessageScreen({super.key});

  void _handleRemindPressed(BuildContext context) =>
      const PuzzleReminderSetupRoute().push<void>(context);

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
                onPressed: () =>
                    const OnboardingProfileRoute().push<void>(context),
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

class PuzzleReminderRoute extends GoRouteData {
  const PuzzleReminderRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PuzzleReminderMessageScreen();
}
