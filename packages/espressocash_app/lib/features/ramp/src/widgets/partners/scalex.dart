import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../config.dart';
import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../data/on_ramp_order_service.dart';
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

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      print('LOADED');
      controller.addJavaScriptHandler(
        handlerName: 'scalex',
        callback: (args) {
          print('CALLED');
          print(args);

          if (orderWasCreated) return;

          if (args.firstOrNull
              case <String, dynamic>{
                'type': 'RAMP_ORDER_ID',
                'payload': {'orderId': final String orderId}
              }) {
            // sl<OnRampOrderService>()
            //     .create(orderId: orderId, amount: submittedAmount);
            orderWasCreated = true;
          }
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('scalex', event.data);
}, false);
''',
      );
    }

    await router.push(
      WebViewScreen.route(
        url: Uri.parse(link),
        onLoaded: handleLoaded,
      ),
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
          final data = result.data?['data'] as Map<String, dynamic>?;

          return data?['link'] as String?;
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
