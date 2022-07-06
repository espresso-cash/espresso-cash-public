import 'package:cryptoplease/analytics/analytics_manager.dart';
import 'package:cryptoplease/app/app.dart';
import 'package:cryptoplease/app/screens/dynamic_links/dynamic_links_controller.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/module.dart';
import 'package:cryptoplease/core/balances/module.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/module.dart';
import 'package:cryptoplease/features/outgoing_transfer/module.dart';
import 'package:cryptoplease/features/pending_request/module.dart';
import 'package:cryptoplease/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
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
  }

  await Firebase.initializeApp();

  await BlocOverrides.runZoned(
    () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      setUpLogging();

      final solanaClient = SolanaClient(
        rpcUrl: Uri.parse(solanaRpcUrl),
        websocketUrl: Uri.parse(solanaWebSocketUrl),
      );

      final hasPassedFirstRun =
          sharedPreferences.getBool(_firstRunKey) ?? false;
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
          const OutgoingTransferModule(),
          const BalancesModule(),
          const AccountsModule(),
          const IncomingSplitKeyPaymentModule(),
          const PendingRequestModule(),
        ],
        child: const DynamicLinksController(child: CryptopleaseApp()),
      );

      runApp(app);
    },
    blocObserver: Observer(),
  );
}

const _firstRunKey = 'hasPassedFirstRun';
