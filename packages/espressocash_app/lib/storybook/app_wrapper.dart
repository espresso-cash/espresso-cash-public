// ignore_for_file: prefer_function_declarations_over_variables, avoid-non-null-assertion

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/gen/app_localizations.dart';
import '../ui/theme.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: Builder(
          builder: (context) => MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Espresso Cash',
            theme: context.watch<CpThemeData>().toMaterialTheme(),
            home: child,
          ),
        ),
      );
}

final TransitionBuilder appWrapper = (context, child) => AppWrapper(
      child: child!,
    );
