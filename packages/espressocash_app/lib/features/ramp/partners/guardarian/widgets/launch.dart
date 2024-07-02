import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../config.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../models/profile_data.dart';

extension BuildContextExt on BuildContext {
  void launchGuardarianOnRamp({
    required String address,
    required ProfileData profile,
  }) {
    final uri = Uri.parse(guardarianBaseUrl).replace(
      queryParameters: {
        'partner_api_token': guardarianApiKey,
        'crypto_currencies_list': jsonEncode([
          {'ticker': 'USDC', 'network': 'SOL'},
        ]),
        'theme': 'orange',
        'type': 'narrow',
        'payout_address': address,
        'skip_choose_payout_address': 'true',
        'default_side': 'buy_crypto',
        'side_toggle_disabled': 'true',
        'is_frame_checkout': 'false',
        'email': profile.email,
      },
    );

    WebViewScreen.push(
      this,
      url: uri,
      onLoaded: null,
      title: l10n.ramp_titleCashIn.toUpperCase(),
      theme: null,
    );
  }
}
