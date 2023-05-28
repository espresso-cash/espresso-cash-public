import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../ui/theme.dart';

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
