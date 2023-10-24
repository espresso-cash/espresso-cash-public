import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../config.dart';
import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../models/profile_data.dart';
import '../../models/ramp_type.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchScalexRamp({
    required String address,
    required ProfileData profile,
    required RampType type,
  }) async {
    final link = await _generateRampLink(
      address: address,
      profile: profile,
      type: type,
    );

    if (link == null) {
      showCpErrorSnackbar(
        this,
        message: l10n.tryAgainLater,
      );

      return;
    }

    await router.push(
      WebViewScreen.route(url: Uri.parse(link), title: 'Scalex'),
    );
  }

  Future<String?> _generateRampLink({
    required String address,
    required ProfileData profile,
    required RampType type,
  }) {
    final uri = Uri.parse(scalexBaseUrl).replace(path: 'webpay/tx/initiate');

    final body = {
      'type': type == RampType.onRamp ? 'onramp' : 'offramp',
      'address': address,
      'email': profile.email,
      'token': 'USDC',
      'network': 'SOLANA',
    };

    return runWithLoader<String?>(this, () async {
      final dio = sl<Dio>();

      try {
        final result = await dio.post<Map<String, dynamic>>(
          uri.toString(),
          data: body,
          options: Options(
            headers: _createAuthHeader(
              path: uri.path,
              method: 'POST',
              body: body,
            ),
          ),
        );

        if (result.data?['code'] == 200) {
          return result.data?['data']['link'] as String?;
        }
      } on Exception {
        return null;
      }
    });
  }
}

Map<String, String> _createAuthHeader({
  required String path,
  required String method,
  required Map<String, dynamic> body,
}) {
  final date = DateTime.now().toUtc().toIso8601String();
  final hmac = Hmac(sha256, utf8.encode(scalexSecretKey));

  final encodedBody =
      base64Encode(sha256.convert(utf8.encode(json.encode(body))).bytes);

  final output = AccumulatorSink<Digest>();
  hmac.startChunkedConversion(output)
    ..add(utf8.encode(date))
    ..add(utf8.encode(path))
    ..add(utf8.encode(method))
    ..add(utf8.encode(encodedBody))
    ..close();

  final digest = output.events.single;
  final signature = base64Encode(digest.bytes);

  return {
    'SC-Timestamp': date,
    'Authorization': 'Bearer $scalexApiKey:$signature',
  };
}
