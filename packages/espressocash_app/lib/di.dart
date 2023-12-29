import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

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

  @lazySingleton
  JupiterAggregatorClient get jupiterClient => JupiterAggregatorClient();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  SeedVault get seedVault => SeedVault.instance;

  @preResolve
  @Named('isSaga')
  Future<bool> isSaga(SeedVault vault) =>
      vault.isAvailable(allowSimulated: !isProd);
}
