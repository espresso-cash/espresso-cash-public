import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../../../../../config.dart';

class ScalexInterceptor extends Interceptor {
  ScalexInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.contains('webpay')) {
      options.headers['Authorization'] = 'Bearer $scalexApiKey';

      return handler.next(options);
    }

    final date = DateTime.now().toUtc().toIso8601String();
    final hmac = Hmac(sha256, utf8.encode(scalexSecretKey));

    final encodedBody = base64Encode(
      sha256.convert(utf8.encode(json.encode(options.data))).bytes,
    );

    final output = AccumulatorSink<Digest>();
    hmac.startChunkedConversion(output)
      ..add(utf8.encode(date))
      ..add(utf8.encode(options.path))
      ..add(utf8.encode(options.method))
      ..add(utf8.encode(encodedBody))
      ..close();

    final digest = output.events.single;
    final signature = base64Encode(digest.bytes);

    options.headers['SC-Timestamp'] = date;
    options.headers['Authorization'] = 'Bearer $scalexApiKey:$signature';

    return handler.next(options);
  }
}
