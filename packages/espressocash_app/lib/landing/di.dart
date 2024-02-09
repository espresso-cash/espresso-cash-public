import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../di.config.dart';

const landingScope = 'landing';

final sl = GetIt.instance;

void configureDependencies() => sl.initLandingScope();

@module
abstract class LandingModule {
  const LandingModule();

  @LazySingleton(scope: landingScope)
  CryptopleaseClient cryptopleaseClient() => CryptopleaseClient(
        baseUrl: 'http://localhost:8080/api/v1',
        sign: (data) async => null,
      );
}
