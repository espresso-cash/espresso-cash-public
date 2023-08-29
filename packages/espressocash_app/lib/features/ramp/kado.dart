import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config.dart';

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
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
