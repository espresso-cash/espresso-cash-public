import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/di.config.dart';
import 'package:cryptoplease/features/swap/bl/repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart';

final sl = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies() async => $initGetIt(sl);

@module
abstract class AppModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

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

  @lazySingleton
  JupiterRepository get jupiterRepository => JupiterRepository(
        jupiterAggregatorClient: sl<JupiterAggregatorClient>(),
      );
}
