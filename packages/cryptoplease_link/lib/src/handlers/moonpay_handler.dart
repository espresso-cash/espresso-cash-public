import 'dart:convert';
import 'dart:core';

import 'package:crypto/crypto.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Future<Handler> moonpayHandler() async {
  final router = shelf_router.Router()
    ..get(
      '/sign',
      _handler,
    );

  return (Request request) async {
    if (request.requestedUri.host != moonpayHost) {
      return Response.notFound(null);
    }

    return router(request);
  };
}

Future<Response> _handler(Request request) async {
  final value = request.url.queryParameters['value'];
  final tokenSymbol = request.url.queryParameters['tokenSymbol'];
  final receiverAddress = request.url.queryParameters['receiverAddress'];

  if (value == null || receiverAddress == null || tokenSymbol == null) {
    return Response.badRequest();
  }

  final url = Uri.parse(moonpayBaseUrl).addParams({
    'apiKey': moonpayApiKey,
    'baseCurrencyAmount': value,
    'walletAddress': Uri.encodeComponent(receiverAddress),
    'currencyCode': tokenSymbol,
    'baseCurrencyCode': 'usd',
  });
  final parameters = '?${url.query}';

  final secret = utf8.encode(moonpaySecret);
  final bytes = utf8.encode(parameters);
  final digest = Hmac(sha256, secret).convert(bytes);
  final signature = base64Encode(digest.bytes);

  final signedUrl = url.addParams({
    'signature': signature,
  });

  final responseBody = {
    'signed_url': signedUrl.toString(),
  };

  return Response.ok(
    jsonEncode(responseBody),
  );
}

extension on Uri {
  Uri addParams(Map<String, dynamic> params) => replace(
        queryParameters: {
          ...queryParameters,
          ...params,
        },
      );
}
