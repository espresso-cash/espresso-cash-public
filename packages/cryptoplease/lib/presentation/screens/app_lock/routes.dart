import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/screens/app_lock/app_lock_disable_screen.dart';
import 'package:cryptoplease/presentation/screens/app_lock/app_lock_enable_screen.dart';
import 'package:cryptoplease/presentation/screens/app_lock/app_lock_settings.dart';
import 'package:cryptoplease/presentation/screens/app_lock/app_lock_setup_flow_screen.dart';

const appLockSetupFlowRoutes = AutoRoute<void>(
  page: AppLockSetupFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: AppLockSettingsScreen),
    AutoRoute<void>(page: AppLockEnableScreen),
    AutoRoute<bool>(page: AppLockDisableScreen),
  ],
);
