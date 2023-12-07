import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:espressocash_backend/src/onramp_money/constants.dart';

class OnRampMoneyInterceptor extends Interceptor {
  OnRampMoneyInterceptor();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //TODO test interceptor
    final date = DateTime.now(); //confirm if acceptable
    final String payload = base64Encode(
      utf8.encode(
        jsonEncode({
          'timestamp': date.millisecondsSinceEpoch,
          'body': options.data,
        }),
      ),
    );

    final hmac = Hmac(sha512, utf8.encode(onRampMoneySecretKey));
    final bytes = hmac.convert(utf8.encode(payload)).bytes;
    final signature =
        bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

    options.headers['X-ONRAMP-APIKEY'] = onRampMoneyApiKey;
    options.headers['X-ONRAMP-SIGNATURE'] = signature;
    options.headers['X-ONRAMP-PAYLOAD'] = payload;

    return handler.next(options);
  }
}
