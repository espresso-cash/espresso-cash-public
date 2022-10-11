import 'package:cryptoplease/app/app.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/module.dart';
import 'package:cryptoplease/core/analytics/analytics_manager.dart';
import 'package:cryptoplease/core/balances/module.dart';
import 'package:cryptoplease/core/dynamic_links_notifier.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/logging.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart';

Future<void> main() => sentryDsn.isNotEmpty
    ? SentryFlutter.init(
        (options) {
          options.dsn = sentryDsn;
        },
        appRunner: _start,
      )
    : _start();

Future<void> _start() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  await Firebase.initializeApp();

  Bloc.observer = Observer();

  final sharedPreferences = await SharedPreferences.getInstance();
  setUpLogging();

  final solanaClient = SolanaClient(
    rpcUrl: Uri.parse(solanaRpcUrl),
    websocketUrl: Uri.parse(solanaWebSocketUrl),
  );

  final hasPassedFirstRun = sharedPreferences.getBool(_firstRunKey) ?? false;
  if (!hasPassedFirstRun) {
    await const FlutterSecureStorage().deleteAll();
  }
  await sharedPreferences.setBool(_firstRunKey, true);

  final app = MultiProvider(
    providers: [
      Provider<MyDatabase>(create: (_) => MyDatabase()),
      Provider<JupiterAggregatorClient>(
        create: (_) => JupiterAggregatorClient(),
      ),
      Provider<SharedPreferences>.value(value: sharedPreferences),
      Provider<AnalyticsManager>(create: (_) => AnalyticsManager()),
      Provider<RpcClient>.value(value: solanaClient.rpcClient),
      Provider<SolanaClient>.value(value: solanaClient),
      Provider<TokenList>(create: (_) => TokenList()),
      Provider<CryptopleaseClient>(create: (_) => CryptopleaseClient()),
      const BalancesModule(),
      const AccountsModule(),
      ChangeNotifierProvider(
        create: (_) => DynamicLinksNotifier(FirebaseDynamicLinks.instance),
      ),
    ],
    child: const CryptopleaseApp(),
  );

  runApp(app);
}

const _firstRunKey = 'hasPassedFirstRun';
