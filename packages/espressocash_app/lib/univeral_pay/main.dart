import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:solana/solana.dart';

import '../config.dart';
import '../l10n/gen/app_localizations.dart';
import 'features/send/data/client.dart';
import 'features/send/data/repository.dart';
import 'routes.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const UniversalPayPageApp());
}

class UniversalPayPageApp extends StatefulWidget {
  const UniversalPayPageApp({super.key});

  @override
  State<UniversalPayPageApp> createState() => _UniversalPayPageAppState();
}

class _UniversalPayPageAppState extends State<UniversalPayPageApp> {
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
            create: (context) =>
                UniversalPayRepository(UniversalPayApiClient(Dio())),
          ),
        ],
        child: MaterialApp.router(
          title: 'Universal Pay',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(fontFamily: 'RobotoApp'),
          color: Colors.black,
          routerConfig: _router.config(),
        ),
      );
}
