import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/screens/authenticated/routes.dart';
import 'package:cryptoplease/core/presentation/splash_screen.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/presentation/split_key_incoming_payment_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/sign_up/routes.dart';

export 'package:cryptoplease/app/routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute<void>(page: SplashScreen, initial: true),
    authenticatedFlowRoutes,
    signUpFlowRoutes,
    AutoRoute<void>(
      page: SplitKeyIncomingPaymentScreen,
      fullscreenDialog: true,
    ),
  ],
)
class $AppRouter {}
