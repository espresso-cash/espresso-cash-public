import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config.dart';

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
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
