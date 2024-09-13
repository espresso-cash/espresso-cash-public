import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'di.dart';
import 'features/accounts/services/account_service.dart';
import 'features/app_lock/widgets/app_lock_module.dart';
import 'features/authenticated/screens/authenticated_flow_screen.dart';
import 'features/onboarding/data/onboarding_repository.dart';
import 'features/onboarding/screens/onboarding_flow_screen.dart';
import 'features/sign_in/screens/sign_in_flow_screen.dart';
import 'l10n/gen/app_localizations.dart';
import 'ui/splash_screen.dart';
import 'ui/theme.dart';

class EspressoCashApp extends StatefulWidget {
  const EspressoCashApp({super.key});

  @override
  State<EspressoCashApp> createState() => _EspressoCashAppState();
}

class _EspressoCashAppState extends State<EspressoCashApp> {
  final _navigator = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    sl<AccountService>().addListener(_handleAccountChanged);
    _handleAccountChanged();
  }

  void _handleAccountChanged() {
    Future.microtask(() {
      if (sl<AccountService>().value == null) {
        SignInFlowScreen.open(context, navigator: _navigator.currentState);
      } else if (sl<OnboardingRepository>().hasFinishedOnboarding) {
        AuthenticatedFlowScreen.open(
          context,
          navigator: _navigator.currentState,
        );
      } else {
        OnboardingFlowScreen.open(
          context,
          navigator: _navigator.currentState,
          onConfirmed: () {
            AuthenticatedFlowScreen.open(
              context,
              navigator: _navigator.currentState,
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    sl<AccountService>().removeListener(_handleAccountChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTheme(
        theme: const CpThemeData.dark(),
        child: Builder(
          builder: (context) => MaterialApp(
            home: const SplashScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Espresso Cash',
            theme: context.watch<CpThemeData>().toMaterialTheme(),
            builder: (context, child) => AppLockModule(
              // ignore: avoid-non-null-assertion, should not be null
              child: child!,
            ),
            navigatorKey: _navigator,
          ),
        ),
      );
}
