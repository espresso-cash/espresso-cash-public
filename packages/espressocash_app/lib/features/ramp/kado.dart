import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../ui/web_view_screen.dart';

extension BuildContextExt on BuildContext {
  void launchKadoOnRamp({required String address}) {
    final uri = Uri.parse(kadoBaseUrl).replace(
      queryParameters: {
        'apiKey': kadoApiKey,
        'cryptoList': ['USDC'],
        'networkList': ['SOLANA'],
        'network': 'SOLANA',
        'onRevCurrency': 'USDC',
        'theme': 'light',
        'productList': ['BUY'],
        'mode': 'full',
        'onToAddress': address,
      },
    );
    router.push(WebViewScreen.route(url: uri));
  }
}
