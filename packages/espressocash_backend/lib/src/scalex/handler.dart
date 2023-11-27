import 'dart:convert';
import 'dart:core';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addScalexHandler() =>
    (shelf_router.Router()..post('/scalex/sign', _handler)).call;

Future<Response> _handler(Request request) =>
    processRequest<ScalexSignRequestDto, ScalexSignResponseDto>(
      request,
      ScalexSignRequestDto.fromJson,
      (data) async {
        final date = DateTime.now().toUtc().toIso8601String();
        final hmac = Hmac(sha256, utf8.encode(scalexSecretKey));

        final encodedBody =
            base64Encode(sha256.convert(utf8.encode(data.data)).bytes);

        final output = AccumulatorSink<Digest>();
        hmac.startChunkedConversion(output)
          ..add(utf8.encode(date))
          ..add(utf8.encode(data.path))
          ..add(utf8.encode('POST'))
          ..add(utf8.encode(encodedBody))
          ..close();

        final digest = output.events.single;
        final signature = base64Encode(digest.bytes);

        return ScalexSignResponseDto(
          timestamp: date,
          signature: signature,
        );
      },
    );
