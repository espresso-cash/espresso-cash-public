import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'di.dart';
import 'features/accounts/services/account_service.dart';
import 'features/app_lock/widgets/app_lock_module.dart';
import 'features/authenticated/screens/authenticated_flow_screen.dart';
import 'features/sign_in/screens/sign_in_flow_screen.dart';
import 'l10n/gen/app_localizations.dart';
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
  }

  void _handleAccountChanged() {
    Future.microtask(() {
      if (sl<AccountService>().value == null) {
        SignInFlowScreen.open(context, navigator: _navigator.currentState);
      } else {
        AuthenticatedFlowScreen.open(
          context,
          navigator: _navigator.currentState,
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
        theme: const CpThemeData.light(),
        child: Builder(
          builder: (context) => MaterialApp(
            home: sl<AccountService>().value == null
                ? const SignInFlowScreen()
                : const AuthenticatedFlowScreen(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Espresso Cash',
            theme: context.watch<CpThemeData>().toMaterialTheme(),
            builder: (context, child) => AppLockModule(child: child),
            navigatorKey: _navigator,
          ),
        ),
      );
}
