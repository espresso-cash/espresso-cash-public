import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../di.config.dart';

const landingScope = 'landing';

final sl = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
  throwOnMissingDependencies: true,
)
void configureDependencies() => sl.initLandingScope();

@module
abstract class LandingModule {
  const LandingModule();

  @LazySingleton(scope: landingScope)
  EspressoCashClient ecClient() => EspressoCashClient(
        sign: (data) async => null,
      );
}
