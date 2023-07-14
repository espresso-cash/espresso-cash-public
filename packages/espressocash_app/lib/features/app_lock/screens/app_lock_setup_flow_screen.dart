import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/router_wrapper.dart';
import '../../../routes.gr.dart';
import '../services/app_lock_bloc.dart';
import 'app_lock_disable_screen.dart';
import 'app_lock_enable_screen.dart';

enum AppLockSetupFlow { enable, disable }

@RoutePage()
class AppLockSetupFlowScreen extends StatefulWidget {
  const AppLockSetupFlowScreen({super.key, required this.flow});

  final AppLockSetupFlow flow;

  static const route = AppLockSetupFlowRoute.new;

  @override
  State<AppLockSetupFlowScreen> createState() => _AppLockSetupFlowScreenState();
}

class _AppLockSetupFlowScreenState extends State<AppLockSetupFlowScreen>
    with RouterWrapper {
  void _handleEnableFinished(String pin) {
    context.read<AppLockBloc>().add(AppLockEvent.enable(pin));
    context.router.pop();
  }

  void _handleDisabledFinished() {
    context.router.pop();
  }

  void _handleCanceled() {
    Navigator.of(context).pop();
  }

  PageRouteInfo get _enableRoute => AppLockEnableScreen.route(
        onCanceled: _handleCanceled,
        onFinished: _handleEnableFinished,
      );

  PageRouteInfo get _disableRoute => AppLockDisableScreen.route(
        onCanceled: _handleCanceled,
        onFinished: _handleDisabledFinished,
      );

  @override
  PageRouteInfo get initialRoute => switch (widget.flow) {
        AppLockSetupFlow.enable => _enableRoute,
        AppLockSetupFlow.disable => _disableRoute,
      };

  @override
  Widget build(BuildContext context) => AutoRouter(key: router?.key);
}
