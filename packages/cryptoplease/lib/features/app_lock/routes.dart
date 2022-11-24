import 'package:auto_route/auto_route.dart';

import 'src/presentation/app_lock_disable_screen.dart';
import 'src/presentation/app_lock_enable_screen.dart';
import 'src/presentation/app_lock_setup_flow_screen.dart';

const appLockSetupFlowRoutes = AutoRoute<void>(
  page: AppLockSetupFlowScreen,
  children: [
    AutoRoute<void>(page: AppLockEnableScreen),
    AutoRoute<bool>(page: AppLockDisableScreen),
  ],
);
