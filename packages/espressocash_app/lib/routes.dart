import 'package:auto_route/auto_route.dart';

import 'di.dart';
import 'features/accounts/services/account_service.dart';
import 'features/sign_in/screens/sign_in_flow_screen.dart';
import 'routes.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
  deferredLoading: false,
)
class AppRouter extends $AppRouter implements AutoRouteGuard {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (sl<AccountService>().value != null ||
        resolver.route.name == SignInFlowRoute.name ||
        resolver.route.name == GetStartedRoute.name ||
        resolver.route.name == RestoreAccountRoute.name ||
        resolver.route.name == WebViewRoute.name) {
      resolver.next();
    } else {
      resolver.redirect(
        SignInFlowScreen.route(onSignedIn: () => resolver.next(true)),
        replace: true,
      );
    }
  }

  @override
  final List<AutoRoute> routes = [
    CustomRoute(
      initial: true,
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
        AutoRoute(page: RampMoreOptionsPartnerRoute.page),
        AutoRoute(page: RampOnboardingRoute.page),
        AutoRoute(page: RampAmountRoute.page),
        AutoRoute(page: NetworkPickerRoute.page),
        AutoRoute(page: OffRampOrderRoute.page),
        AutoRoute(page: OnRampOrderRoute.page),
        AutoRoute(page: OutgoingDlnPaymentConfirmationRoute.page),
        AutoRoute(page: OutgoingDlnPaymentDetailsRoute.page),
      ],
    ),
    AutoRoute(
      page: SignInFlowRoute.page,
      children: [
        CustomRoute(
          page: GetStartedRoute.page,
          durationInMilliseconds: 1000,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          initial: true,
        ),
        AutoRoute(page: RestoreAccountRoute.page),
        AutoRoute(page: WebViewRoute.page),
      ],
    ),
  ];
}
