import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/app_lock/app_lock_bloc.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppLockSetupFlowScreen extends StatefulWidget {
  const AppLockSetupFlowScreen({Key? key}) : super(key: key);

  @override
  _AppLockSetupFlowScreenState createState() => _AppLockSetupFlowScreenState();
}

class _AppLockSetupFlowScreenState extends State<AppLockSetupFlowScreen>
    implements AppLockSetupRouter {
  @override
  void onEnableFinished(String pin) {
    context.read<AppLockBloc>().add(AppLockEvent.enable(pin));
    context.router.replaceAll([const AppLockSettingsRoute()]);
  }

  @override
  void onEnable() {
    context.router.push(const AppLockEnableRoute());
  }

  @override
  Future<void> onDisable() async {
    await context.router.push<bool>(const AppLockDisableRoute());
  }

  @override
  void onDisableFinished() {
    context.router.replaceAll([const AppLockSettingsRoute()]);
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
  void onEnableFinished(String pin);

  void onEnable();

  void onDisable();

  void onDisableFinished();

  void closeFlow();
}
