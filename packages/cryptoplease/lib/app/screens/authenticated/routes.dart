import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/screens/authenticated/authenticated_flow_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/home_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/investments_screen.dart';
import 'package:cryptoplease/app/screens/authenticated/receive_flow/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/wallet_flow/wallet_flow_screen.dart';
import 'package:cryptoplease/core/presentation/token_selector_screen.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/activities/presentation/activities_screen.dart';
import 'package:cryptoplease/features/add_funds/presentation/routes.dart';
import 'package:cryptoplease/features/app_lock/presentation/routes.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/routes.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/presentation/routes.dart';
import 'package:cryptoplease/features/legal/legal_document_view.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/routes.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/presentation/routes.dart';
import 'package:cryptoplease/features/profile/edit_profile_screen.dart';
import 'package:cryptoplease/features/profile/help_screen.dart';
import 'package:cryptoplease/features/profile/menu_screen.dart';
import 'package:cryptoplease/features/profile/profile_screen.dart';
import 'package:cryptoplease/features/qr_scanner/qr_scanner_request.dart';
import 'package:cryptoplease/features/qr_scanner/qr_scanner_screen.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/routes.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/swap_token_flow.dart';

const authenticatedFlowRoutes = AutoRoute<dynamic>(
  page: AuthenticatedFlowScreen,
  children: [
    AutoRoute<void>(
      path: '',
      page: HomeScreen,
      children: [
        CustomRoute<void>(path: '', page: MenuScreen),
        CustomRoute<void>(page: WalletFlowScreen),
        CustomRoute<void>(page: InvestmentsScreen),
        CustomRoute<void>(page: ActivitiesScreen),
      ],
    ),
    ...backupPhraseRoutes,
    ...odpRoutes,
    ...oskpRoutes,
    ...iskpRoutes,
    AutoRoute<QrScannerRequest>(page: QrScannerScreen),
    AutoRoute<void>(page: SwapTokenFlowScreen, children: swapTokenRoutes),
    AutoRoute<Token>(page: TokenSelectorScreen),
    ...receiveFlowRoutes,
    ...addFundsRoutes,
    appLockSetupFlowRoutes,
    AutoRoute<void>(page: ProfileScreen, fullscreenDialog: true),
    AutoRoute<void>(page: EditProfileScreen),
    AutoRoute<void>(page: TermsOfServiceScreen),
    AutoRoute<void>(page: PrivacyPolicyScreen),
    AutoRoute<void>(page: HelpScreen),
  ],
);
