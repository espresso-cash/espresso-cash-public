// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:espressocash_api/espressocash_api.dart';

// import 'package:espressocash_backend/src/constants.dart';

// class ScalexInterceptor extends Interceptor {
//   ScalexInterceptor();

//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     if (!options.path.contains('webpay')) {
//       options.headers['Authorization'] = 'Bearer $scalexApiKey';

//       return handler.next(options);
//     }

//     // options.headers['SC-Timestamp'] = headers.timestamp;
//     // options.headers['Authorization'] =
//     //     'Bearer $scalexApiKey:${headers.signature}';

//     // return handler.next(options);
//   }
// }
