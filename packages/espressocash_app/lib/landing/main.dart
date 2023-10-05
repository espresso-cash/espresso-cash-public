import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../l10n/gen/app_localizations.dart';
import 'screens/landing.dart';

void main() {
  setUrlStrategy(const PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const LandingPageApp());
}

class LandingPageApp extends StatelessWidget {
  const LandingPageApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Espresso Cash',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(fontFamily: 'RobotoApp'),
        color: const Color(0xffE36E0A),
        onGenerateRoute: (settings) {
          final uri = Uri.parse(settings.name ?? '');
          final key = uri.queryParameters['k'];

          return uri.path == '/' && key != null
              ? MaterialPageRoute(
                  builder: (_) => LandingScreen(encodedKey: key),
                )
              : MaterialPageRoute(builder: (_) => const SizedBox.shrink());
        },
      );
}
