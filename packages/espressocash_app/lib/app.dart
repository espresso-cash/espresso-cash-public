import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/app_lock/app_lock.dart';
import 'l10n/gen/app_localizations.dart';
import 'routes.dart';
import 'routing.dart';
import 'ui/theme.dart';

class EspressoCashApp extends StatefulWidget {
  const EspressoCashApp({super.key});

  @override
  State<EspressoCashApp> createState() => _EspressoCashAppState();
}

class _EspressoCashAppState extends State<EspressoCashApp> {
  final _router = AppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CpTheme(
        theme: const CpThemeData.light(),
        child: Builder(
          builder: (context) => MaterialApp.router(
            routerConfig: goRouter,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Espresso Cash',
            theme: context.watch<CpThemeData>().toMaterialTheme(),
            builder: (context, child) => AppLockModule(child: child),
          ),
        ),
      );
}
