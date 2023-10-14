// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:solana/solana.dart';

import '../config.dart';
import '../l10n/gen/app_localizations.dart';
import 'core/request_helpers.dart';
import 'features/request/request_screen.dart';
import 'features/send/data/repository.dart';
import 'features/send/send_screen.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const DemoPageApp());
}

class DemoPageApp extends StatelessWidget {
  const DemoPageApp({super.key});

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => SolanaClient(
              rpcUrl: Uri.parse(solanaRpcUrl),
              websocketUrl: Uri.parse(solanaWebSocketUrl),
            ),
          ),
          RepositoryProvider(
            create: (context) => UniversalPayRepository(Dio()),
          ),
        ],
        child: MaterialApp(
          title: 'Universal Pay',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(fontFamily: 'RobotoApp'),
          color: Colors.black,
          onGenerateRoute: (settings) {
            final uri = Uri.parse(html.window.location.toString());
            final solanaPay = tryParseUniversalPayRequest(uri);

            return solanaPay != null
                ? MaterialPageRoute(
                    builder: (context) => SenderInitialScreen(solanaPay),
                  )
                : MaterialPageRoute(builder: (_) => const RequestScreen());
          },
        ),
      );
}
