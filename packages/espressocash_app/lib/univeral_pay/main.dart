// ignore_for_file: avoid_web_libraries_in_flutter

// import 'dart:html' as html;

import 'package:flutter/material.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../l10n/gen/app_localizations.dart';
import 'features/request/link_screen.dart';
import 'features/request/request_screen.dart';
import 'features/send/send_screen.dart';

void main() {
  // setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const DemoPageApp());
}

class DemoPageApp extends StatelessWidget {
  const DemoPageApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Universal Pay',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(fontFamily: 'RobotoApp'),
        color: const Color(0xD9FF8617),
        onGenerateRoute: (settings) {
          // final uri = Uri.parse(html.window.location.toString());
          // final solanaPay = tryParseSolanaPayRequest(uri);

          // if (solanaPay != null) {
          //   return MaterialPageRoute(
          //     builder: (context) => const SizedBox.shrink(),
          //   );
          // }

          // return MaterialPageRoute(builder: (_) => const SizedBox.shrink());

          return MaterialPageRoute(builder: (_) => const SenderInitialScreen());
        },
      );
}
