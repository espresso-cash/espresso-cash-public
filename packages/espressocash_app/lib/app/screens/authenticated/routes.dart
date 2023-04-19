import 'package:auto_route/auto_route.dart';

import '../../../routes.gr.dart';

final authenticatedFlowRoutes = AutoRoute(
  page: AuthenticatedFlowRoute.page,
  children: [
    AutoRoute(
      path: '',
      page: HomeRoute.page,
      children: [
        CustomRoute(
          page: InvestmentsRouter.page,
          path: '',
          children: [
            CustomRoute(initial: true, page: InvestmentsRoute.page),
            AutoRoute(page: TokenDetailsRoute.page),
          ],
        ),
        CustomRoute(page: WalletFlowRoute.page, maintainState: false),
        CustomRoute(page: ActivitiesRoute.page, maintainState: false),
      ],
    ),
    AutoRoute(
      page: PuzzleReminderRoute.page,
      fullscreenDialog: true,
      children: [
        AutoRoute(path: '', page: PuzzleReminderMessageRoute.page),
        AutoRoute(page: PuzzleReminderSetupRoute.page),
      ],
    ),
    AutoRoute(
      page: BackupPhraseFlowRoute.page,
      children: [
        AutoRoute(path: '', page: BackupWarningRoute.page),
        AutoRoute(page: BackupPhraseRoute.page),
        AutoRoute(page: BackupConfirmPhraseRoute.page),
        AutoRoute(page: BackupPhraseSuccessRoute.page),
      ],
    ),
    // odpRoutes,
    AutoRoute(page: ODPDetailsRoute.page),
    AutoRoute(page: ODPConfirmationRoute.page),
    // oskpRoutes,
    AutoRoute(page: OSKPRoute.page),
    AutoRoute(page: OSKPConfirmationRoute.page),
    AutoRoute(page: ShareLinksRoute.page),
    // iskpRoutes,
    AutoRoute(page: FirstPartReadyRoute.page),
    AutoRoute(page: IncomingSplitKeyPaymentRoute.page),
    // qrScannerRoutes
    AutoRoute(page: QrScannerRoute.page),
    // paymentRequestRoutes,
    AutoRoute(
      page: LinkDetailsFlowRoute.page,
      children: [
        AutoRoute(page: SharePaymentRequestRoute.page, initial: true),
      ],
    ),
    AutoRoute(page: LinkRequestFlowRoute.page),
    // islpRoutes,
    AutoRoute(page: IncomingSingleLinkRoute.page),
    // swapRoutes,
    AutoRoute(page: SwapFlowRoute.page),
    AutoRoute(page: ProcessSwapRoute.page),
    // appLockSetupFlowRoutes,
    AutoRoute(
      page: AppLockSetupFlowRoute.page,
      children: [
        AutoRoute(page: AppLockEnableRoute.page),
        AutoRoute(page: AppLockDisableRoute.page),
      ],
    ),
    AutoRoute(page: ProfileRoute.page, fullscreenDialog: true),
    AutoRoute(page: EditProfileRoute.page),
    AutoRoute(page: HelpRoute.page),
    // tokenSearchRoutes,
    AutoRoute(page: TokenSearchRoute.page),
    // onboardingFlowRoutes,
    AutoRoute(
      page: OnboardingFlowRoute.page,
      children: [
        AutoRoute(page: NoEmailAndPasswordRoute.page),
        AutoRoute(page: ViewRecoveryPhraseRoute.page),
        AutoRoute(page: CreateProfileOnboardingRoute.page),
      ],
    ),
    AutoRoute(page: RemoteRequestRoute.page),
    AutoRoute(page: WebViewRoute.page),
  ],
);

@RoutePage(name: 'InvestmentsRouter')
class InvestmentsRouterScreen extends AutoRouter {
  const InvestmentsRouterScreen({super.key});
}

@RoutePage(name: 'PuzzleReminderRoute')
class PuzzleReminderRouteScreen extends AutoRouter {
  const PuzzleReminderRouteScreen({super.key});
}
