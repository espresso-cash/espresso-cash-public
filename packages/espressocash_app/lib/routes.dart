import 'package:auto_route/auto_route.dart';

import 'routes.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
  deferredLoading: false,
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(
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
        AutoRoute(page: ODPDetailsRoute.page),
        AutoRoute(page: ODPConfirmationRoute.page),
        AutoRoute(page: OSKPRoute.page),
        AutoRoute(page: OSKPConfirmationRoute.page),
        AutoRoute(page: ShareLinksRoute.page),
        AutoRoute(page: FirstPartReadyRoute.page),
        AutoRoute(page: FirstPartQrRoute.page),
        AutoRoute(page: IncomingSplitKeyPaymentRoute.page),
        AutoRoute(page: QrScannerRoute.page),
        AutoRoute(
          page: LinkDetailsFlowRoute.page,
          children: [
            AutoRoute(page: SharePaymentRequestRoute.page, initial: true),
          ],
        ),
        AutoRoute(page: LinkRequestFlowRoute.page),
        AutoRoute(page: SwapFlowRoute.page),
        AutoRoute(page: ProcessSwapRoute.page),
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
        AutoRoute(page: TokenSearchRoute.page),
        AutoRoute(
          page: OnboardingFlowRoute.page,
          children: [
            AutoRoute(page: NoEmailAndPasswordRoute.page),
            AutoRoute(page: ViewRecoveryPhraseRoute.page),
            AutoRoute(page: CreateProfileRoute.page),
          ],
        ),
        AutoRoute(page: RemoteRequestRoute.page),
        AutoRoute(page: WebViewRoute.page),
      ],
    ),
    AutoRoute(
      page: SignInFlowRoute.page,
      children: [
        AutoRoute(path: '', page: GetStartedRoute.page),
        AutoRoute(page: CreateWalletLoadingRoute.page),
        AutoRoute(page: RestoreAccountRoute.page),
        AutoRoute(page: SignInProfileRoute.page),
        AutoRoute(page: WebViewRoute.page),
      ],
    ),
  ];
}
