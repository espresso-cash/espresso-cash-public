import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/dialog_modal_route.dart';
import 'package:cryptoplease/presentation/screens/authenticated/puzzle_reminder/puzzle_reminder_dialog_message_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/puzzle_reminder/puzzle_reminder_dialog_setup_screen.dart';

const puzzleReminderFlowRoutes = DialogModalRoute<void>(
  name: 'PuzzleReminderRoute',
  page: EmptyRouterPage,
  children: [
    DialogModalRoute<void>(
      path: '',
      hasBarrier: false,
      page: PuzzleReminderDialogMessageScreen,
    ),
    DialogModalRoute<void>(
      hasBarrier: false,
      page: PuzzleReminderDialogSetupScreen,
    ),
  ],
);
