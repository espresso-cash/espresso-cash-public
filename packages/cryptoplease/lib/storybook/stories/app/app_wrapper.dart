import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: Builder(
          builder: (context) => MaterialApp(
            useInheritedMediaQuery: true,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Crypto Please',
            theme: context.watch<CpThemeData>().toMaterialTheme(),
            home: child,
          ),
        ),
      );
}
