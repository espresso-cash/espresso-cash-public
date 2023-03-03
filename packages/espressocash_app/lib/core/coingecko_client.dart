import 'package:dio/dio.dart';

import '../config.dart';

class CoingeckoClient {
  CoingeckoClient() : dio = Dio(BaseOptions(baseUrl: coingeckoBaseUrl)) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (coingeckoApiKey.isNotEmpty) {
            options.headers['x-cg-pro-api-key'] = coingeckoApiKey;
          }

          return handler.next(options);
        },
      ),
    );
  }

  final Dio dio;
}
