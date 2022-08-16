import 'dart:convert';
import 'dart:core';

import 'package:crypto/crypto.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Future<Handler> moonpayHandler() async {
  final router = shelf_router.Router()..post('/sign', _handler);

  return (Request request) async {
    if (request.requestedUri.host != moonpayHost) {
      return Response.notFound(null);
    }

    return router(request);
  };
}

Future<Response> _handler(Request request) async {
  final body =
      await request.readAsString().then(json.decode) as Map<String, dynamic>;
  final value = body['value'] as String?;
  final tokenSymbol = body['tokenSymbol'] as String?;
  final receiverAddress = body['receiverAddress'] as String?;

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
    'signedUrl': signedUrl.toString(),
  };

  return Response.ok(
    jsonEncode(responseBody),
    headers: {
      'content-type': 'application/json',
    },
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
