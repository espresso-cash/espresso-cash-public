import 'dart:convert';
import 'dart:core';

import 'package:crypto/crypto.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addFundsHandler() => shelf_router.Router()..post('/addFunds', _handler);

Future<Response> _handler(Request request) async =>
    processRequest<AddFundsRequestDto, AddFundsResponseDto>(
      request,
      AddFundsRequestDto.fromJson,
      (data) async {
        final url = Uri.parse(moonpayBaseUrl).addParams({
          'apiKey': moonpayApiKey,
          'baseCurrencyAmount': data.value,
          'walletAddress': Uri.encodeComponent(data.receiverAddress),
          'currencyCode': data.tokenSymbol.toLowerCase(),
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

        return AddFundsResponseDto(signedUrl: signedUrl.toString());
      },
    );

extension on Uri {
  Uri addParams(Map<String, dynamic> params) => replace(
        queryParameters: {
          ...queryParameters,
          ...params,
        },
      );
}
