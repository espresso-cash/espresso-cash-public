import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../ui/web_view_screen.dart';
import 'models/profile_data.dart';

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
        'mode': 'full',
        'onToAddress': address,
        'email': profile.email,
      },
    );
    router.push(WebViewScreen.route(url: uri));
  }
}
