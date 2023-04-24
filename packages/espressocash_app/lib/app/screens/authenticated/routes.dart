import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../../../features/app_lock/routes.dart';
import '../../../features/backup_phrase/routes.dart';
import '../../../features/incoming_split_key_payments/routes.dart';
import '../../../features/mobile_wallet/routes.dart';
import '../../../features/onboarding/routes.dart';
import '../../../features/outgoing_direct_payments/routes.dart';
import '../../../features/outgoing_split_key_payments/routes.dart';
import '../../../features/payment_request/routes.dart';
import '../../../features/qr_scanner/routes.dart';
import '../../../features/swap/routes.dart';
import '../../../features/token_details/widgets/token_details_screen.dart';
import '../../../features/token_search/routes.dart';
import '../../../ui/webview_screen.dart';
import 'activities/activities_screen.dart';
import 'authenticated_flow_screen.dart';
import 'home_screen.dart';
import 'investments/investments_screen.dart';
import 'profile/edit_profile_screen.dart';
import 'profile/help_screen.dart';
import 'profile/profile_screen.dart';
import 'wallet_flow/wallet_flow_screen.dart';

const authenticatedFlowRoutes = AutoRoute<dynamic>(
  page: AuthenticatedFlowScreen,
  children: [
    AutoRoute<void>(
      path: '',
      page: HomeScreen,
      children: [
        CustomRoute<void>(
          name: 'InvestmentsRouter',
          page: EmptyRouterScreen,
          path: '',
          children: [
            CustomRoute<void>(initial: true, page: InvestmentsScreen),
            AutoRoute<void>(page: TokenDetailsScreen),
          ],
        ),
        CustomRoute<void>(page: WalletFlowScreen, maintainState: false),
        CustomRoute<void>(page: ActivitiesScreen, maintainState: false),
      ],
    ),
    ...backupPhraseRoutes,
    ...odpRoutes,
    ...oskpRoutes,
    ...iskpRoutes,
    ...qrScannerRoutes,
    ...paymentRequestRoutes,
    ...swapRoutes,
    appLockSetupFlowRoutes,
    AutoRoute<void>(page: ProfileScreen, fullscreenDialog: true),
    AutoRoute<void>(page: EditProfileScreen),
    AutoRoute<void>(page: HelpScreen),
    ...tokenSearchRoutes,
    onboardingFlowRoutes,
    mobileWalletRoutes,
    AutoRoute<void>(page: WebViewScreen),
  ],
);
