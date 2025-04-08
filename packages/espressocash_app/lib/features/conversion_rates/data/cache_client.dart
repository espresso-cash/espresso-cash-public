import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@singleton
class DioCacheClient {
  const DioCacheClient._(this.dio, this.options);

  final Dio dio;
  final CacheOptions options;

  @factoryMethod
  @preResolve
  static Future<DioCacheClient> init() async {
    final directory = await getTemporaryDirectory();

    final options = CacheOptions(
      store: DbCacheStore(databasePath: directory.path),
      policy: CachePolicy.refreshForceCache,
    );

    final dio =
        Dio()
          ..interceptors.addAll([
            CacheInterceptor(options: options),
            DioCacheInterceptor(options: options),
          ])
          ..options.listFormat = ListFormat.csv;

    return DioCacheClient._(dio, options);
  }
}

class CacheInterceptor extends Interceptor {
  const CacheInterceptor({required this.options});

  final CacheOptions options;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // ignore: avoid-non-null-assertion, we know its not null
    final store = this.options.store!;

    final maxAge = options.extra[maxAgeOption] as Duration? ?? Duration.zero;

    final key = this.options.keyBuilder(options);

    final cache = await store.get(key);

    cache != null && DateTime.now().difference(cache.responseDate) < maxAge
        ? handler.resolve(cache.toResponse(options, fromNetwork: false))
        : handler.next(options);
  }
}

const maxAgeOption = 'maxAge';
