import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/screens/authenticated/activities/activities_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/authenticated_flow_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/home_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/profile/edit_profile_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/profile/help_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/profile/menu_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/profile/profile_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/receive_flow/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/wallet_flow/wallet_flow_screen.dart';
import 'package:cryptoplease/features/add_funds/presentation/routes.dart';
import 'package:cryptoplease/features/app_lock/presentation/routes.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/routes.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/presentation/routes.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/routes.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/presentation/routes.dart';
import 'package:cryptoplease/features/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/features/qr_scanner/qr_scanner_screen.dart';

const authenticatedFlowRoutes = AutoRoute<dynamic>(
  page: AuthenticatedFlowScreen,
  children: [
    AutoRoute<void>(
      path: '',
      page: HomeScreen,
      children: [
        CustomRoute<void>(path: '', page: MenuScreen, maintainState: false),
        CustomRoute<void>(page: WalletFlowScreen, maintainState: false),
        CustomRoute<void>(
          name: 'InvestmentsRouter',
          page: EmptyRouterScreen,
          maintainState: false,
          children: investmentRoutes,
        ),
        CustomRoute<void>(page: ActivitiesScreen, maintainState: false),
      ],
    ),
    ...backupPhraseRoutes,
    ...odpRoutes,
    ...oskpRoutes,
    ...iskpRoutes,
    AutoRoute<QrScannerRequest>(page: QrScannerScreen),
    ...receiveFlowRoutes,
    ...addFundsRoutes,
    appLockSetupFlowRoutes,
    AutoRoute<void>(page: ProfileScreen, fullscreenDialog: true),
    AutoRoute<void>(page: EditProfileScreen),
    AutoRoute<void>(page: HelpScreen),
  ],
);
