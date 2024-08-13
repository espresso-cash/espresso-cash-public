import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart';

import 'config.dart';
import 'di.config.dart';
import 'features/tokens/token_list.dart';

final sl = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
  throwOnMissingDependencies: true,
)
Future<void> configureDependencies() => sl.init();

@module
abstract class AppModule {
  const AppModule();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  TokenList get tokenList => TokenList();

  @lazySingleton
  SolanaClient get solanaClient => SolanaClient(
        rpcUrl: Uri.parse(solanaRpcUrl),
        websocketUrl: Uri.parse(solanaWebSocketUrl),
      );

  @lazySingleton
  RpcClient get rpcClient => solanaClient.rpcClient;

  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @singleton
  @preResolve
  Future<Mixpanel> mixpanel() async {
    final mixpanel = await Mixpanel.init(
      const String.fromEnvironment('MIXPANEL_TOKEN'),
      trackAutomaticEvents: true,
    );
    mixpanel.setServerURL('https://api-eu.mixpanel.com');

    return mixpanel;
  }
}
