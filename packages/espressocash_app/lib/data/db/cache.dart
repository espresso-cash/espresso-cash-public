import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
Future<DbCacheStore> initCacheStore() async {
  final directory = await getTemporaryDirectory();

  return DbCacheStore(databasePath: directory.path);
}
