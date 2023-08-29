import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../ui/web_view_screen.dart';

extension BuildContextExt on BuildContext {
  void launchGuardarianOnRamp({required String address}) {
    final uri = Uri.parse(guardarianBaseUrl).replace(
      queryParameters: {
        'partner_api_token': guardarianApiKey,
        'crypto_currencies_list': jsonEncode([
          {'ticker': 'USDC', 'network': 'SOL'}
        ]),
        'theme': 'orange',
        'type': 'narrow',
        'payout_address': address,
        'skip_choose_payout_address': 'true',
        'default_side': 'buy_crypto',
        'side_toggle_disabled': 'true',
        'is_frame_checkout': 'false',
      },
    );
    router.push(WebViewScreen.route(url: uri, title: 'Guardarian'));
  }
}
