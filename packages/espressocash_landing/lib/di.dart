import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../di.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  preferRelativeImports: false,
  throwOnMissingDependencies: true,
)
void configureDependencies() => sl.init();

@module
abstract class LandingModule {
  const LandingModule();

  @lazySingleton
  EspressoCashClient ecClient() => EspressoCashClient(
        sign: (data) async => null,
      );
}
