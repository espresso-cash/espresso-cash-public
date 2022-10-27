import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_confirm_phrase_screen.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_phrase_screen.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_phrase_success_screen.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_warning_screen.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/puzzle_reminder/puzzle_reminder_message_screen.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/puzzle_reminder/puzzle_reminder_setup_screen.dart';

const List<AutoRoute<dynamic>> backupPhraseRoutes = [
  AutoRoute<void>(
    name: 'PuzzleReminderRoute',
    page: EmptyRouterPage,
    fullscreenDialog: true,
    children: [
      AutoRoute<void>(path: '', page: PuzzleReminderMessageScreen),
      AutoRoute<void>(page: PuzzleReminderSetupScreen),
    ],
  ),
  AutoRoute<bool>(
    page: BackupPhraseFlowScreen,
    children: [
      AutoRoute<void>(path: '', page: BackupWarningScreen),
      AutoRoute<void>(page: BackupPhraseScreen),
      AutoRoute<void>(page: BackupConfirmPhraseScreen),
      AutoRoute<void>(page: BackupPhraseSuccessScreen),
    ],
  ),
];
