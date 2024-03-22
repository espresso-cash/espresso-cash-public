// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../core/link_payments.dart';
import '../core/solana_helpers.dart';
import '../l10n/gen/app_localizations.dart';
import 'di.dart';
import 'features/link_payment/link_payment_screen.dart';
import 'features/payment_request_old/payment_request_screen.dart';
import 'ui/colors.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

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
        color: EcLandingColors.primaryColor,
        onGenerateRoute: (settings) {
          final uri = Uri.parse(html.window.location.toString());
          final linkPayment = LinkPayments.tryParse(uri);
          final solanaPay = tryParseSolanaPayRequest(uri);

          if (linkPayment != null) {
            return MaterialPageRoute(
              builder: (context) => LinkPaymentScreen(linkPayment),
            );
          } else if (solanaPay != null) {
            return MaterialPageRoute(
              builder: (context) => RequestPaymentScreen(solanaPay),
            );
          }

          return MaterialPageRoute(builder: (_) => const SizedBox.shrink());
        },
      );
}
