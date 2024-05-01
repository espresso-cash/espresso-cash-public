import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/splash_screen.dart';
import '../../accounts/models/account.dart';
import '../../accounts/services/account_service.dart';
import '../../backup_phrase/widgets/backup_phrase_module.dart';
import '../../incoming_link_payments/module.dart';
import '../../mobile_wallet/module.dart';
import '../../outgoing_link_payments/module.dart';
import 'home_screen.dart';

class AuthenticatedFlowScreen extends StatefulWidget {
  const AuthenticatedFlowScreen({super.key});

  static void open(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil<void>(
        PageRouteBuilder(
          pageBuilder: (context, _, __) => const AuthenticatedFlowScreen(),
        ),
        F,
      );

  static void backToHome(BuildContext context) =>
      Navigator.of(context, rootNavigator: true)
          .popUntil((route) => route.isFirst);

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
  Widget build(BuildContext _) => ValueListenableBuilder(
        valueListenable: sl<AccountService>(),
        builder: (context, account, child) {
          if (account == null) return const SplashScreen();

          return MultiProvider(
            providers: [
              Provider<MyAccount>.value(value: account),
              const BackupPhraseModule(),
              const OLPModule(),
              const MobileWalletModule(),
            ],
            child: MultiProvider(
              providers: const [
                ILPModule(),
              ],
              child: Navigator(
                onGenerateInitialRoutes: (_, __) => [
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => const HomeScreen(),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
