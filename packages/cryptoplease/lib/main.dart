import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/bl/analytics/analytics_manager.dart';
import 'package:cryptoplease/bl/app_lock/app_lock_bloc.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/conversion_rates/repository.dart';
import 'package:cryptoplease/bl/nft/offchain_metadata_repository.dart';
import 'package:cryptoplease/bl/outgoing_transfers/repository.dart';
import 'package:cryptoplease/bl/puzzle_reminder/puzzle_reminder_bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/repository.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/data/analytics/analytics_manager.dart';
import 'package:cryptoplease/data/api/coingecko_client.dart';
import 'package:cryptoplease/data/conversion_rates_repository.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/data/offchain_metadata_repository.dart';
import 'package:cryptoplease/data/outgoing_transfer_repository.dart';
import 'package:cryptoplease/data/split_key_payments_repository.dart';
import 'package:cryptoplease/logging.dart';
import 'package:cryptoplease/presentation/app.dart';
import 'package:cryptoplease/presentation/screens/dynamic_links/dynamic_links_controller.dart';
import 'package:firebase_core/firebase_core.dart';
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
  }

  await Firebase.initializeApp();

  await BlocOverrides.runZoned(
    () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final db = MyDatabase();
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
          Provider<AnalyticsManager>(create: (_) => FirebaseAnalyticsManager()),
          Provider<OffchainMetadataRepository>(
            create: (_) => OffchainMetadataRepositoryImpl(),
          ),
          Provider<RpcClient>.value(value: solanaClient.rpcClient),
          Provider<SolanaClient>.value(value: solanaClient),
          ChangeNotifierProvider<ConversionRatesRepository>(
            create: (_) => CoingeckoConversionRatesRepository(
              coingeckoClient: CoingeckoClient(),
            ),
          ),
          Provider<SplitKeyIncomingRepository>(
            create: (_) =>
                SharedPrefsSplitKeyIncomingRepository(sharedPreferences),
          ),
          Provider<OutgoingTransferRepository>(
            create: (_) => DbOutgoingTransferRepository(db),
          ),
          Provider<TokenList>(create: (_) => TokenList()),
          BlocProvider<PuzzleReminderBloc>(
            create: (_) => PuzzleReminderBloc(sharedPreferences),
          ),
          BlocProvider(
            create: (context) => AppLockBloc(
              secureStorage: const FlutterSecureStorage(),
            )
              ..add(const AppLockEvent.init())
              ..add(const AppLockEvent.lock()),
          ),
          BlocProvider(
            create: (context) => BalancesBloc(
              solanaClient: context.read<SolanaClient>(),
              tokens: context.read<TokenList>(),
            ),
          ),
          BlocProvider(
            create: (context) => AccountsBloc(
              storage: const FlutterSecureStorage(),
            )..add(const AccountsEvent.initialize()),
          ),
          BlocProvider(
            create: (context) => SplitKeyIncomingPaymentBloc(
              solanaClient: context.read<SolanaClient>(),
              repository: context.read<SplitKeyIncomingRepository>(),
              balancesBloc: context.read<BalancesBloc>(),
            ),
          ),
        ],
        child: const DynamicLinksController(child: CryptopleaseApp()),
      );

      runApp(app);
    },
    blocObserver: Observer(),
  );
}

const _firstRunKey = 'hasPassedFirstRun';
