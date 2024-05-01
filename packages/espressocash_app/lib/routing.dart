

// class AppRoute extends ShellRouteData {
//   const AppRoute();

//   @override
//   Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
//       navigator;
// }

// final goRouter = GoRouter(
//   initialLocation: const HomeRoute().location,
//   refreshListenable: sl<AccountService>(),
//   redirect: (context, state) {
//     // final isLoggedIn = sl<AccountService>().value != null;

//     // if (isLoggedIn) {
//     //   final hasFinishedOnboarding =
//     //       sl<OnboardingRepository>().hasFinishedOnboarding;

//     //   final onboardingLocations = [
//     //     // const OnboardingRoute().location,
//     //     // const OnboardingProfileRoute().location,
//     //   ];

//     //   if (!hasFinishedOnboarding &&
//     //       !onboardingLocations.contains(state.uri.path)) {
//     //     // return const OnboardingRoute().location;
//     //   }
//     // }

//     // if (isLoggedIn && state.uri.path.startsWith(const SignInRoute().location)) {
//     //   return const HomeRoute().location;
//     // }

//     // final urlsSafeForLogIn = [
//     // const SignInRoute().location,
//     // const RestoreAccountRoute().location,
//     // const TermsRoute().location,
//     // const PrivacyRoute().location,
//     // ];
//     // if (!isLoggedIn && !urlsSafeForLogIn.contains(state.uri.path)) {
//     //   return const SignInRoute().location;
//     // }
//   },
//   observers: [
//     sl<AnalyticsManager>().analyticsObserver,
//   ],
//   routes: $appRoutes,
// );
