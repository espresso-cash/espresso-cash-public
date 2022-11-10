import 'package:auto_route/auto_route.dart';

import '../../../features/app_lock/routes.dart';
import '../../../features/backup_phrase/routes.dart';
import '../../../features/incoming_split_key_payments/routes.dart';
import '../../../features/outgoing_direct_payments/routes.dart';
import '../../../features/outgoing_split_key_payments/routes.dart';
import '../../../features/payment_request/routes.dart';
import '../../../features/qr_scanner/routes.dart';
import '../../../features/ramp/routes.dart';
import 'activities/activities_screen.dart';
import 'authenticated_flow_screen.dart';
import 'home_screen.dart';
import 'investments/components/investment_settings.dart';
import 'investments/investments_screen.dart';
import 'profile/edit_profile_screen.dart';
import 'profile/help_screen.dart';
import 'profile/menu_screen.dart';
import 'profile/profile_screen.dart';
import 'wallet_flow/wallet_flow_screen.dart';

const authenticatedFlowRoutes = AutoRoute<dynamic>(
  page: AuthenticatedFlowScreen,
  children: [
    AutoRoute<void>(
      path: '',
      page: HomeScreen,
      children: [
        CustomRoute<void>(path: '', page: MenuScreen, maintainState: false),
        CustomRoute<void>(page: WalletFlowScreen, maintainState: false),
        CustomRoute<void>(page: InvestmentsScreen, maintainState: false),
        CustomRoute<void>(page: ActivitiesScreen, maintainState: false),
      ],
    ),
    ...backupPhraseRoutes,
    ...odpRoutes,
    ...oskpRoutes,
    ...iskpRoutes,
    ...qrScannerRoutes,
    ...paymentRequestRoutes,
    ...rampRoutes,
    appLockSetupFlowRoutes,
    AutoRoute<void>(page: ProfileScreen, fullscreenDialog: true),
    AutoRoute<void>(page: EditProfileScreen),
    AutoRoute<void>(page: HelpScreen),
    AutoRoute<void>(page: InvestmentSettingsScreen, fullscreenDialog: true),
  ],
);
