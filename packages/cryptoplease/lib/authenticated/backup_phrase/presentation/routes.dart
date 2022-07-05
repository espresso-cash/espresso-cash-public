import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/authenticated/backup_phrase/presentation/backup_phrase_flow/backup_confirm_phrase_screen.dart';
import 'package:cryptoplease/authenticated/backup_phrase/presentation/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease/authenticated/backup_phrase/presentation/backup_phrase_flow/backup_phrase_screen.dart';
import 'package:cryptoplease/authenticated/backup_phrase/presentation/backup_phrase_flow/backup_phrase_success_screen.dart';
import 'package:cryptoplease/authenticated/backup_phrase/presentation/puzzle_reminder/puzzle_reminder_dialog_message_screen.dart';
import 'package:cryptoplease/authenticated/backup_phrase/presentation/puzzle_reminder/puzzle_reminder_dialog_setup_screen.dart';
import 'package:cryptoplease/presentation/dialog_modal_route.dart';

const List<AutoRoute<dynamic>> backupPhraseRoutes = [
  DialogModalRoute<void>(
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
  ),
  AutoRoute<bool>(
    page: BackupPhraseFlowScreen,
    children: [
      AutoRoute<void>(path: '', page: BackupPhraseScreen),
      AutoRoute<void>(page: BackupConfirmPhraseScreen),
      AutoRoute<void>(page: BackupPhraseSuccessScreen),
    ],
  ),
];
