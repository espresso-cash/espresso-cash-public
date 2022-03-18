import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/screens/authenticated/routes.dart';
import 'package:cryptoplease/presentation/screens/sign_up/routes.dart';
import 'package:cryptoplease/presentation/screens/splash_screen/splash_screen.dart';
import 'package:cryptoplease/presentation/screens/split_key_payments/incoming/split_key_incoming_payment_screen.dart';

export 'package:cryptoplease/presentation/routes.gr.dart';

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
