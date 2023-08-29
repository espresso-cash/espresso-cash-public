import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'src/screens/backup_phrase_flow_screen.dart';

export 'src/widgets/backup_phrase_module.dart';

extension BuildContextExt on BuildContext {
  void launchBackupPhraseFlow() => router.push(BackupPhraseFlowScreen.route());
}
