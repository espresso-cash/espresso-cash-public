import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'config.dart';
import 'di.dart';
import 'features/accounts/services/account_service.dart';
import 'features/activities/screens/activities_screen.dart';
import 'features/analytics/analytics_manager.dart';
import 'features/authenticated/screens/authenticated_flow_screen.dart';
import 'features/authenticated/screens/home_screen.dart';
import 'features/investments/screens/investments_screen.dart';
import 'features/investments/screens/main_screen.dart';
import 'features/profile/screens/manage_profile_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/sign_in/screens/get_started_screen.dart';
import 'features/sign_in/screens/restore_account_screen.dart';
import 'features/sign_in/screens/sign_in_flow_screen.dart';
import 'features/token_details/screens/token_details_screen.dart';
import 'features/token_search/screens/token_search_screen.dart';
import 'features/tokens/token_list.dart';
import 'features/wallet_flow/screens/wallet_flow_screen.dart';
import 'ui/splash_screen.dart';
import 'ui/web_view_screen.dart';

abstract class Routes {
  const Routes._();

  static const signIn = 'signIn';
  static const getStartedTerms = 'getStartedTerms';
  static const getStartedPrivacy = 'getStartedPrivacy';
  static const getStartedRestore = 'getStartedRestore';
  static const home = 'home';
  static const wallet = 'wallet';
  static const activities = 'activities';
  static const profile = 'profile';
  static const manageProfile = 'manageProfile';
  static const investments = 'investments';
  static const searchToken = 'searchToken';
  static const tokenDetails = 'tokenDetails';
}

final goRouter = GoRouter(
  initialLocation: '/home',
  refreshListenable: sl<AccountService>(),
  redirect: (context, state) {
    final isLoggedIn = sl<AccountService>().value != null;

    if (isLoggedIn && state.uri.path.startsWith('/sign-in')) {
      return '/home';
    }

    if (!isLoggedIn && !state.uri.path.startsWith('/sign-in')) {
      return '/sign-in';
    }
  },
  observers: [
    sl<AnalyticsManager>().analyticsObserver,
  ],
  routes: [
    ShellRoute(
      builder: (context, state, child) => SignInFlowScreen(child: child),
      routes: [
        GoRoute(
          name: Routes.signIn,
          path: '/sign-in',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 1000),
            child: const GetStartedScreen(),
            transitionsBuilder: _fadeTransitionBuilder,
          ),
          routes: [
            GoRoute(
              name: Routes.getStartedTerms,
              path: 'terms',
              builder: (context, state) => WebViewScreen(
                url: Uri.parse(termsUrl),
              ),
            ),
            GoRoute(
              name: Routes.getStartedPrivacy,
              path: 'privacy',
              builder: (context, state) => WebViewScreen(
                url: Uri.parse(privacyUrl),
              ),
            ),
            GoRoute(
              name: Routes.getStartedRestore,
              path: 'restore',
              builder: (context, state) => const RestoreAccountScreen(),
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _authenticatedNavigatorKey,
      pageBuilder: (context, state, child) => NoTransitionPage(
        child: AuthenticatedFlowScreen(child: child),
      ),
      routes: [
        ShellRoute(
          pageBuilder: (context, state, child) => NoTransitionPage(
            child: HomeScreen(child: child),
          ),
          routes: [
            GoRoute(
              name: Routes.home,
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MainScreen(),
              ),
              routes: [
                GoRoute(
                  name: Routes.investments,
                  path: 'investments',
                  builder: (context, state) => const InvestmentsScreen(),
                  routes: [
                    GoRoute(
                      name: Routes.searchToken,
                      path: 'search-token',
                      builder: (context, state) => const TokenSearchScreen(),
                    ),
                    GoRoute(
                      name: Routes.tokenDetails,
                      path: 'token/:id',
                      builder: (context, state) {
                        print(state.pathParameters);

                        return TokenDetailsScreen(
                          token: sl<TokenList>()
                              .requireTokenByMint(state.pathParameters['id']!),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  parentNavigatorKey: _authenticatedNavigatorKey,
                  name: Routes.profile,
                  path: 'profile',
                  pageBuilder: (context, state) => const MaterialPage(
                    fullscreenDialog: true,
                    child: ProfileScreen(),
                  ),
                  routes: [
                    GoRoute(
                      name: Routes.manageProfile,
                      path: 'manage',
                      builder: (context, state) => ManageProfileScreen(
                        onSubmitted: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: Routes.wallet,
          path: '/wallet',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(child: WalletFlowScreen()),
          ),
        ),
        GoRoute(
          name: Routes.activities,
          path: '/activities',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(child: ActivitiesScreen()),
          ),
        ),
      ],
    ),
  ],
);

final _authenticatedNavigatorKey = GlobalKey<NavigatorState>();

Widget _fadeTransitionBuilder(
  BuildContext _,
  Animation<double> animation,
  Animation<double> __,
  Widget child,
) =>
    FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      child: child,
    );
