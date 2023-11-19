import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes.gr.dart';
import '../../../../core/router_wrapper.dart';
import '../../../../l10n/l10n.dart';
import '../../../onboarding/onboarding.dart';
import 'backup_warning_screen.dart';

@RoutePage<bool>()
class BackupPhraseFlowScreen extends StatefulWidget {
  const BackupPhraseFlowScreen({super.key});

  static const route = BackupPhraseFlowRoute.new;

  @override
  State<BackupPhraseFlowScreen> createState() => _BackupPhraseFlowScreenState();
}

class _BackupPhraseFlowScreenState extends State<BackupPhraseFlowScreen>
    with RouterWrapper {
  void _handleWarningConfirmed() => router?.replace(
        ViewRecoveryPhraseScreen.route(
          onConfirmed: (_) => _handleCompleted(),
          buttonLabel: context.l10n.ok,
        ),
      );

  void _handleCompleted() => context.router.pop();

  @override
  PageRouteInfo get initialRoute => BackupWarningScreen.route(
        onConfirmed: _handleWarningConfirmed,
      );

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}
