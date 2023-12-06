import 'dart:convert';
import 'dart:core';

import 'package:crypto/crypto.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/onramp_money/client/client.dart';
import 'package:espressocash_backend/src/onramp_money/constants.dart';
import 'package:espressocash_backend/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addOnRampMoneyHandler() => (shelf_router.Router()
      ..post('/onrampmoney/generate', _generateTokenHandler))
    .call;

Future<Response> _generateTokenHandler(Request request) => processRequest<
        GenerateOnRampTokenRequestDto, GenerateOnRampTokenResponseDto>(
      request,
      GenerateOnRampTokenRequestDto.fromJson,
      (data) async {
        final client = OnRampMoneyApiClient();

        final body = GenerateTokenRequestDto(
          messageToSign: data.message,
          signedMessage: data.signedMessage,
          walletAddress: data.walletAddress,
          quantity: data.quantity,
          appId: data.appId,
          chainId: '4',
          coinId: '116',
        );

        print(
          jsonEncode({
            'timestamp': data.timestamp.millisecondsSinceEpoch,
            'body': body,
          }),
        );

        final String payload = base64Encode(
          utf8.encode(
            jsonEncode({
              'timestamp': data.timestamp.millisecondsSinceEpoch,
              'body': body,
            }),
          ),
        );

        final hmac = Hmac(sha512, utf8.encode(onRampMoneySecretKey));
        final bytes = hmac.convert(utf8.encode(payload)).bytes;
        final signature =
            bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

        try {
          final url = await client.generateToken(
            body: body,
            apiKey: onRampMoneyApiKey,
            payload: payload,
            signature: signature,
          );

          print(url);
        } catch (ex) {
          print(ex);
        }

        // final url = await client.generateToken( //TODO
        //   body: body,
        //   apiKey: onRampMoneyApiKey,
        //   payload: payload,
        //   signature: signature,
        // );

        return const GenerateOnRampTokenResponseDto(
          token: 'url.data.token',
          depositAddress: 'url.data.depositAddress',
        );
      },
    );
