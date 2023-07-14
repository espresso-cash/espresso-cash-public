import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../routes.gr.dart';
import '../services/app_lock_bloc.dart';
import 'app_lock_disable_screen.dart';
import 'app_lock_enable_screen.dart';

@RoutePage()
class AppLockSetupFlowScreen extends StatefulWidget {
  const AppLockSetupFlowScreen({super.key});

  static const route = AppLockSetupFlowRoute.new;

  @override
  State<AppLockSetupFlowScreen> createState() => _AppLockSetupFlowScreenState();
}

class _AppLockSetupFlowScreenState extends State<AppLockSetupFlowScreen>
    implements AppLockSetupRouter {
  @override
  void onEnableFinished(String pin) {
    context.read<AppLockBloc>().add(AppLockEvent.enable(pin));
    context.router.pop();
  }

  @override
  void onEnable() {
    context.router.push(AppLockEnableScreen.route());
  }

  @override
  Future<void> onDisable() async {
    await context.router.push<bool>(AppLockDisableScreen.route());
  }

  @override
  void onDisableFinished() {
    context.router.pop();
  }

  @override
  void closeFlow() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => Provider<AppLockSetupRouter>.value(
        value: this,
        child: const AutoRouter(),
      );
}

abstract class AppLockSetupRouter {
  const AppLockSetupRouter();

  void onEnableFinished(String pin);

  void onEnable();

  void onDisable();

  void onDisableFinished();

  void closeFlow();
}
