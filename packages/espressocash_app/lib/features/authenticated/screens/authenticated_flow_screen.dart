import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/splash_screen.dart';
import '../../accounts/services/account_service.dart';
import '../../backup_phrase/widgets/backup_phrase_module.dart';
import '../../mobile_wallet/widgets/mobile_wallet_listener.dart';
import 'home_screen.dart';

class AuthenticatedFlowScreen extends StatefulWidget {
  const AuthenticatedFlowScreen({super.key});

  static void open(BuildContext context, {NavigatorState? navigator}) =>
      (navigator ?? Navigator.of(context, rootNavigator: true))
          .pushAndRemoveUntil<void>(
        PageRouteBuilder(
          pageBuilder: (context, _, __) => const AuthenticatedFlowScreen(),
        ),
        F,
      );

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

          return const BackupPhraseModule(
            child: MobileWalletListener(
              child: HomeScreen(),
            ),
          );
        },
      );
}
