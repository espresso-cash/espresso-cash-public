import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart';

import 'config.dart';
import 'core/tokens/token_list.dart';
import 'di.config.dart';

final sl = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies() async => $initGetIt(sl);

@module
abstract class AppModule {
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

  @lazySingleton
  FirebaseDynamicLinks get firebaseDynamicLinks =>
      FirebaseDynamicLinks.instance;

  @lazySingleton
  CryptopleaseClient get cryptopleaseClient => CryptopleaseClient();

  @lazySingleton
  JupiterAggregatorClient get jupiterClient => JupiterAggregatorClient();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
