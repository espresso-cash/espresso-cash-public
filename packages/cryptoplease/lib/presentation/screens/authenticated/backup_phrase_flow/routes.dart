import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/backup_confirm_phrase_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/backup_phrase_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/backup_phrase_success_screen.dart';

const backupPhraseFlowRoutes = AutoRoute<bool>(
  page: BackupPhraseFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: BackupPhraseScreen),
    AutoRoute<void>(page: BackupConfirmPhraseScreen),
    AutoRoute<void>(page: BackupPhraseSuccessScreen),
  ],
);
