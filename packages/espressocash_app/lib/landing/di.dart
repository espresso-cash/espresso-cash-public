import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../config.dart';
import '../di.config.dart';

const landingScope = 'landing';

final sl = GetIt.instance;

void configureDependencies() => sl.initLandingScope();

@module
abstract class LandingModule {
  const LandingModule();

  @LazySingleton(scope: landingScope)
  SolanaClient get solanaClient => SolanaClient(
        rpcUrl: Uri.parse(solanaRpcUrl),
        websocketUrl: Uri.parse(solanaWebSocketUrl),
      );

  @LazySingleton(scope: landingScope)
  CryptopleaseClient cryptopleaseClient() => CryptopleaseClient(
        sign: (data) async => null,
      );
}
