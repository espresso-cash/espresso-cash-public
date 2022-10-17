import 'package:cryptoplease/app/app.dart';
import 'package:cryptoplease/app/screens/splash_screen.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/module.dart';
import 'package:cryptoplease/core/balances/module.dart';
import 'package:cryptoplease/core/dynamic_links_notifier.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/logging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );

  return sentryDsn.isNotEmpty
      ? SentryFlutter.init(
          (options) {
            options.dsn = sentryDsn;
          },
          appRunner: _start,
        )
      : _start();
}

Future<void> _start() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

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

  setUpLogging();

  final sharedPreferences = sl<SharedPreferences>();
  final hasPassedFirstRun = sharedPreferences.getBool(_firstRunKey) ?? false;
  if (!hasPassedFirstRun) {
    await const FlutterSecureStorage().deleteAll();
  }
  await sharedPreferences.setBool(_firstRunKey, true);

  final app = MultiProvider(
    providers: [
      const BalancesModule(),
      const AccountsModule(),
      ChangeNotifierProvider<DynamicLinksNotifier>(
        create: (_) => sl<DynamicLinksNotifier>(),
      ),
    ],
    child: const CryptopleaseApp(),
  );

  runApp(app);
}

const _firstRunKey = 'hasPassedFirstRun';
