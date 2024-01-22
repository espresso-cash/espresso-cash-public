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
    CustomRoute(
      page: SplashRoute.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
      initial: true,
    ),
    CustomRoute(
      page: AuthenticatedFlowRoute.page,
      transitionsBuilder: TransitionsBuilders.noTransition,
      children: [
        AutoRoute(
          path: '',
          page: HomeRoute.page,
          children: [
            CustomRoute(
              page: InvestmentsFlowRoute.page,
              path: '',
              children: [
                AutoRoute(page: MainRoute.page, path: ''),
                AutoRoute(page: InvestmentsRoute.page),
                AutoRoute(page: TokenSearchRoute.page),
                AutoRoute(page: TokenDetailsRoute.page),
              ],
            ),
            CustomRoute(page: WalletFlowRoute.page, maintainState: false),
            CustomRoute(page: ActivitiesRoute.page, maintainState: false),
          ],
        ),
        CustomRoute(page: PayFlowRoute.page, maintainState: false),
        AutoRoute(
          page: PuzzleReminderRoute.page,
          fullscreenDialog: true,
          children: [
            AutoRoute(path: '', page: PuzzleReminderMessageRoute.page),
            AutoRoute(page: PuzzleReminderSetupRoute.page),
          ],
        ),
        AutoRoute(
          page: ViewPhraseFlowRoute.page,
          children: [
            AutoRoute(page: QuizIntroRoute.page),
            AutoRoute(page: QuizQuestionRoute.page),
            AutoRoute(page: QuizAnswerRoute.page),
            AutoRoute(page: QuizRecoveryRoute.page),
          ],
        ),
        AutoRoute(page: ODPInputRoute.page),
        AutoRoute(page: ODPDetailsRoute.page),
        AutoRoute(page: ODPConfirmationRoute.page),
        AutoRoute(page: OLPRoute.page),
        AutoRoute(page: OLPConfirmationRoute.page),
        AutoRoute(page: ShareLinkRoute.page),
        AutoRoute(page: IncomingLinkPaymentRoute.page),
        AutoRoute(page: QrScannerRoute.page),
        AutoRoute(
          page: LinkDetailsFlowRoute.page,
          children: [
            AutoRoute(page: SharePaymentRequestRoute.page, initial: true),
          ],
        ),
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
        AutoRoute(page: ManageProfileRoute.page),
        AutoRoute(page: CountryPickerRoute.page),
        AutoRoute(page: HelpRoute.page),
        AutoRoute(
          page: OnboardingFlowRoute.page,
          children: [
            AutoRoute(page: NoEmailAndPasswordRoute.page),
            AutoRoute(page: ViewRecoveryPhraseRoute.page),
            AutoRoute(page: ConfirmRecoveryPhraseRoute.page),
            AutoRoute(page: ManageProfileRoute.page),
            AutoRoute(page: CountryPickerRoute.page),
            AutoRoute(page: OnboardingSuccessRoute.page),
          ],
        ),
        AutoRoute(page: RemoteRequestRoute.page),
        AutoRoute(page: WebViewRoute.page),
        AutoRoute(page: RampPartnerSelectRoute.page),
        AutoRoute(page: RampOnboardingRoute.page),
        AutoRoute(page: RampAmountRoute.page),
        AutoRoute(page: NetworkPickerRoute.page),
        AutoRoute(page: OffRampOrderRoute.page),
        AutoRoute(page: OnRampOrderRoute.page),
      ],
    ),
    AutoRoute(
      page: SignInFlowRoute.page,
      children: [
        CustomRoute(
          page: SplashRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: GetStartedRoute.page,
          durationInMilliseconds: 1500,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        AutoRoute(page: CreateWalletLoadingRoute.page),
        AutoRoute(page: RestoreAccountRoute.page),
        AutoRoute(page: WebViewRoute.page),
        AutoRoute(page: CountryPickerRoute.page),
      ],
    ),
  ];
}
