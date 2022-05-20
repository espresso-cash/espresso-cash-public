import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/bl/app_lock/app_lock_bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/app_lock/app_lock_screen.dart';
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

class _CryptopleaseAppState extends State<CryptopleaseApp>
    with
        // ignore: prefer_mixin, Flutter way
        WidgetsBindingObserver {
  final _router = AppRouter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      context.read<AppLockBloc>().add(const AppLockEvent.lock());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select<AccountsBloc, bool>((b) => b.state.isProcessing);
    final isAuthenticated =
        context.select<AccountsBloc, bool>((b) => b.state.account != null);
    final skState = context.watch<SplitKeyIncomingPaymentBloc>().state;
    final shouldLoginForSk =
        !isAuthenticated && skState is PaymentSecondPartReady;
    final isLocked =
        context.select<AppLockBloc, bool>((b) => b.state is AppLockStateLocked);

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
          builder: (context, child) => Stack(
            children: [
              // ignore: avoid-non-null-assertion, cannot be null here
              child!,
              if (isLocked) const AppLockScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
