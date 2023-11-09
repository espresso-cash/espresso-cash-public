import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../di.config.dart';

final sl = GetIt.instance;

void configureDependencies() => sl.initLandingScope();

@module
abstract class LandingModule {
  const LandingModule();

  @LazySingleton(scope: 'landing')
  Dio get dio => Dio();
}
