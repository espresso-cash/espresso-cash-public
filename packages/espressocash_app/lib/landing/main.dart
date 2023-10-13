// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../core/link_payments.dart';
import '../core/solana_helpers.dart';
import '../l10n/gen/app_localizations.dart';
import '../l10n/l10n.dart';
import 'features/pay/landing.dart';
import 'features/request/landing.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
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
          final uri = Uri.parse(html.window.location.toString());
          final linkPayment = LinkPayments.tryParse(uri);
          final solanaPay = tryParseSolanaPayRequest(uri);

          if (linkPayment != null) {
            return MaterialPageRoute(
              builder: (context) => EspressoPayScreen(payment: linkPayment),
            );
          } else if (solanaPay != null) {
            return MaterialPageRoute(
              builder: (context) => PayRequestScreen(request: solanaPay),
            );
          }

          return MaterialPageRoute(builder: (_) => const SizedBox.shrink());
        },
      );
}
