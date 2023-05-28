import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/localizely_localizations.dart';
import 'package:provider/provider.dart';

import '../core/accounts/bl/accounts_bloc.dart';
import '../core/analytics/analytics_manager.dart';
import '../di.dart';
import '../features/app_lock/module.dart';
import '../l10n/localizely_updater.dart';
import '../routes.gr.dart';
import '../ui/theme.dart';

class CryptopleaseApp extends StatefulWidget {
  const CryptopleaseApp({super.key});

  @override
  State<CryptopleaseApp> createState() => _CryptopleaseAppState();
}

class _CryptopleaseAppState extends State<CryptopleaseApp> {
  final _router = AppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select<AccountsBloc, bool>((b) => b.state.isProcessing);
    final isAuthenticated =
        context.select<AccountsBloc, bool>((b) => b.state.account != null);

    return CpTheme(
      theme: const CpThemeData.light(),
      child: Builder(
        builder: (context) => MaterialApp.router(
          routeInformationParser: _router.defaultRouteParser(),
          routerDelegate: AutoRouterDelegate.declarative(
            _router,
            routes: (_) => [
              if (isAuthenticated)
                const AuthenticatedFlowRoute()
              else if (isLoading)
                const SplashRoute()
              else
                const SignInFlowRoute(),
            ],
            navigatorObservers: () => [
              sl<AnalyticsManager>().analyticsObserver,
            ],
          ),
          localizationsDelegates:
              LocalizelyLocalizations.localizationsDelegates,
          supportedLocales: LocalizelyLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Espresso Cash',
          theme: context.watch<CpThemeData>().toMaterialTheme(),
          builder: (context, child) => LocalizelyUpdater(
            child: AppLockModule(child: child),
          ),
        ),
      ),
    );
  }
}
