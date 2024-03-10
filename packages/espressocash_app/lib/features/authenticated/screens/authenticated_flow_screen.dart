import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/splash_screen.dart';
import '../../accounts/models/account.dart';
import '../../accounts/services/account_service.dart';
import '../../activities/module.dart';
import '../../backup_phrase/widgets/backup_phrase_module.dart';
import '../../conversion_rates/module.dart';
import '../../favorite_tokens/module.dart';
import '../../incoming_link_payments/module.dart';
import '../../investments/module.dart';
import '../../mobile_wallet/module.dart';
import '../../outgoing_direct_payments/module.dart';
import '../../outgoing_link_payments/module.dart';
import '../../payment_request/module.dart';
import '../../popular_tokens/module.dart';
import '../../swap/module.dart';
import '../authenticated_navigator_key.dart';

class AuthenticatedFlowScreen extends StatefulWidget {
  const AuthenticatedFlowScreen({super.key, required this.child});

  final Widget child;

  @override
  State<AuthenticatedFlowScreen> createState() =>
      _AuthenticatedFlowScreenState();
}

class _AuthenticatedFlowScreenState extends State<AuthenticatedFlowScreen> {
  @override
  void didChangeDependencies() {
    precacheImage(Assets.images.formPageOrangeBg.provider(), context);
    precacheImage(Assets.images.formPageGoldBg.provider(), context);
    precacheImage(Assets.images.sendManualBg.provider(), context);
    precacheImage(Assets.images.sendMoneyGraphic.provider(), context);
    precacheImage(Assets.images.quizIntroBg.provider(), context);
    precacheImage(Assets.images.quizQuestionBg.provider(), context);

    precacheImage(Assets.images.sendMoneyGraphic.provider(), context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext _) => MultiProvider(
        providers: const [
          ConversionRatesModule(),
        ],
        child: ValueListenableBuilder(
          valueListenable: sl<AccountService>(),
          builder: (context, account, child) {
            if (account == null) return const SplashScreen();

            return MultiProvider(
              providers: [
                Provider<MyAccount>.value(value: account),
                const BackupPhraseModule(),
                const PaymentRequestModule(),
                const ODPModule(),
                const OLPModule(),
                const InvestmentModule(),
                const ActivitiesModule(),
                const FavoriteTokensModule(),
                const SwapModule(),
                const PopularTokensModule(),
                const MobileWalletModule(),
              ],
              child: MultiProvider(
                providers: const [
                  ILPModule(),
                ],
                child: widget.child,
              ),
            );
          },
        ),
      );
}

class AuthenticatedRoute extends ShellRouteData {
  const AuthenticatedRoute();

  static final GlobalKey<NavigatorState> $navigatorKey =
      authenticatedNavigatorKey;

  @override
  Page<void> pageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) =>
      NoTransitionPage(child: AuthenticatedFlowScreen(child: navigator));
}
