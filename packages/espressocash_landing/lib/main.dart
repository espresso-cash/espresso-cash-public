import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../l10n/gen/app_localizations.dart';
import 'di.dart';
import 'routing.dart';
import 'ui/colors.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const EspressoCashLandingApp());
}

class EspressoCashLandingApp extends StatelessWidget {
  const EspressoCashLandingApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Espresso Cash',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(fontFamily: 'RobotoApp'),
        color: EcLandingColors.primaryColor,
        routerConfig: goRouter,
      );
}
