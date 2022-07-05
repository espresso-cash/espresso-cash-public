import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/features/app_lock/module.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CryptopleaseApp extends StatefulWidget {
  const CryptopleaseApp({Key? key}) : super(key: key);

  @override
  State<CryptopleaseApp> createState() => _CryptopleaseAppState();
}

class _CryptopleaseAppState extends State<CryptopleaseApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select<AccountsBloc, bool>((b) => b.state.isProcessing);
    final isAuthenticated =
        context.select<AccountsBloc, bool>((b) => b.state.account != null);
    final skState = context.watch<SplitKeyIncomingPaymentBloc>().state;
    final shouldLoginForSk =
        !isAuthenticated && skState is PaymentSecondPartReady;

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
                const SignUpFlowRoute(),
              if (skState is! PaymentNone && !shouldLoginForSk)
                const SplitKeyIncomingPaymentRoute()
            ],
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          title: 'Crypto Please',
          theme: context.watch<CpThemeData>().toMaterialTheme(),
          builder: (context, child) => AppLockModule(child: child),
        ),
      ),
    );
  }
}
