import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'config.dart';
import 'di.dart';
import 'features/accounts/services/account_service.dart';
import 'firebase_options.dart';
import 'logging.dart';
import 'ui/splash_screen.dart';

Future<void> main() {
  runApp(const SplashScreen());

  return sentryDsn.isNotEmpty
      ? SentryFlutter.init(
          (options) {
            options
              ..dsn = sentryDsn
              ..tracesSampleRate = 1.0
              ..profilesSampleRate = 1.0;
          },
          appRunner: () async {
            final spanAppStart = Sentry.startTransaction(
              'App Start',
              'Main',
              bindToScope: true,
            );
            await _start(spanAppStart);
            await spanAppStart.finish();
          },
        )
      : _start();
}

Future<void> _init([ISentrySpan? span]) async {
  final spanFirebase = span?.startChild('Initialize Firebase');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await spanFirebase?.finish();

  final spanDependencies = span?.startChild('Configure dependencies');
  await configureDependencies();
  await spanDependencies?.finish();

  Bloc.observer = Observer();

  setUpLogging();

  final sharedPreferences = sl<SharedPreferences>();
  final hasPassedFirstRun = sharedPreferences.getBool(_firstRunKey) ?? false;
  if (!hasPassedFirstRun) {
    await const FlutterSecureStorage().deleteAll();
    await sharedPreferences.setBool(_firstRunKey, true);
  }

  final spanAccountService = span?.startChild('Initialize AccountService');
  await sl<AccountService>().initialize(spanAccountService);
  await spanAccountService?.finish();
}

Future<void> _start([ISentrySpan? span]) async {
  final spanSystemChrome = span?.startChild('SystemChrome');
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
  await spanSystemChrome?.finish();

  await _init(span);

  final app = DevicePreview(
    enabled: const bool.fromEnvironment('DEVICE_PREVIEW', defaultValue: false),
    builder: (context) => ScreenUtilInit(
      designSize: const Size(428, 926),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      builder: (context, child) => const EspressoCashApp(),
    ),
  );

  runApp(app);
}

const _firstRunKey = 'hasPassedFirstRun';
