// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:solana/solana.dart';

import '../config.dart';
import '../l10n/gen/app_localizations.dart';
import 'core/request_helpers.dart';
import 'features/send/data/repository.dart';
import 'routes.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const DemoPageApp());
}

class DemoPageApp extends StatefulWidget {
  const DemoPageApp({super.key});

  @override
  State<DemoPageApp> createState() => _DemoPageAppState();
}

class _DemoPageAppState extends State<DemoPageApp> {
  final _router = AppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

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
        child: MaterialApp.router(
          title: 'Universal Pay',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(fontFamily: 'RobotoApp'),
          color: Colors.black,
          routerConfig: _router.config(
            deepLinkBuilder: (deepLink) {
              if (deepLink.path.startsWith('/request')) {
                final uri = deepLink.uri;

                final isValid = () {
                  final queryParams = uri.queryParameters;

                  return queryParams.containsKey('amount') &&
                      queryParams.containsKey('receiver') &&
                      queryParams.containsKey('reference');
                }();

                if (!isValid) {
                  return DeepLink.defaultPath;
                }

                return deepLink;
              } else if (deepLink.path.startsWith('/send')) {
                final uri = Uri.parse(html.window.location.toString());
                final request = tryParseUniversalPayRequest(uri);

                if (request == null) {
                  return const DeepLink.path('/request');
                }

                return deepLink;
              }

              return DeepLink.defaultPath;
            },
          ),
        ),
      );
}
