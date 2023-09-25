import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../config.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../models/profile_data.dart';

extension BuildContextExt on BuildContext {
  void launchKadoOnRamp({
    required String address,
    required ProfileData profile,
  }) {
    final uri = Uri.parse(kadoBaseUrl).replace(
      queryParameters: {
        'apiKey': kadoApiKey,
        'cryptoList': ['USDC'],
        'networkList': ['SOLANA'],
        'network': 'SOLANA',
        'onRevCurrency': 'USDC',
        'theme': 'light',
        'productList': ['BUY'],
        'mode': 'minimal',
        'onToAddress': address,
        'onPayCurrency': 'USD',
        'onPayAmount': '100',
        'email': profile.email,
      },
    );
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'kado',
        callback: (args) {
          print(args);
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('kado', event.data);
}, false);
''',
      );
    }

    router.push(
      WebViewScreen.route(
        url: uri,
        onLoaded: handleLoaded,
      ),
    );
  }
}
