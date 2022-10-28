import 'package:auto_route/auto_route.dart';

import '../../../features/add_funds/presentation/add_funds_screen.dart';
import '../../../features/app_lock/presentation/routes.dart';
import '../../../features/backup_phrase/presentation/routes.dart';
import '../../../features/incoming_split_key_payments/presentation/routes.dart';
import '../../../features/outgoing_direct_payments/presentation/routes.dart';
import '../../../features/outgoing_split_key_payments/presentation/routes.dart';
import '../../../features/qr_scanner/qr_scanner_request.dart';
import '../../../features/qr_scanner/qr_scanner_screen.dart';
import 'activities/activities_screen.dart';
import 'authenticated_flow_screen.dart';
import 'cash_out/cash_out_screen.dart';
import 'home_screen.dart';
import 'investments/investments_screen.dart';
import 'profile/edit_profile_screen.dart';
import 'profile/help_screen.dart';
import 'profile/menu_screen.dart';
import 'profile/profile_screen.dart';
import 'receive_flow/routes.dart';
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
    AutoRoute<QrScannerRequest>(page: QrScannerScreen),
    ...receiveFlowRoutes,
    AutoRoute<void>(page: AddFundsScreen, fullscreenDialog: true),
    AutoRoute<void>(page: CashOutScreen, fullscreenDialog: true),
    appLockSetupFlowRoutes,
    AutoRoute<void>(page: ProfileScreen, fullscreenDialog: true),
    AutoRoute<void>(page: EditProfileScreen),
    AutoRoute<void>(page: HelpScreen),
  ],
);
