import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes.gr.dart';
import '../../../../core/router_wrapper.dart';
import '../../../../l10n/l10n.dart';
import '../../../onboarding/onboarding.dart';
import 'view_warning_screen.dart';

@RoutePage<bool>()
class ViewPhraseFlowScreen extends StatefulWidget {
  const ViewPhraseFlowScreen({super.key});

  static const route = ViewPhraseFlowRoute.new;

  @override
  State<ViewPhraseFlowScreen> createState() => _ViewPhraseFlowScreenState();
}

class _ViewPhraseFlowScreenState extends State<ViewPhraseFlowScreen>
    with RouterWrapper {
  void _handleWarningConfirmed() => router?.replace(
        ViewRecoveryPhraseScreen.route(
          onConfirmed: (_) => _handleCompleted(),
          buttonLabel: context.l10n.ok,
        ),
      );

  void _handleCompleted() => context.router.pop();

  @override
  PageRouteInfo get initialRoute => ViewPhraseWarningScreen.route(
        onConfirmed: _handleWarningConfirmed,
      );

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}
