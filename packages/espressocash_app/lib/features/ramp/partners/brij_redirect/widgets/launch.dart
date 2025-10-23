import 'package:flutter/material.dart';
import 'package:sealed_countries/sealed_countries.dart' as country;

import '../../../../../config.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../models/profile_data.dart';

extension BuildContextExt on BuildContext {
  void launchBrijRedirect({
    required RampType type,
    required String address,
    required ProfileData profile,
  }) {
    final mode = type == RampType.onRamp ? 'ONRAMP' : 'OFFRAMP';
    final title = type == RampType.onRamp ? l10n.ramp_titleCashIn : l10n.ramp_titleCashOut;

    final uri = Uri.parse(brijBaseUrl).replace(
      queryParameters: {
        'api-key': brijApiKey,
        'country': _getCountryCode3Letter(profile.country.code),
        'chains': 'SOLANA',
        'mode': mode,
        'wallet-addresses': 'SOL:$address',
      },
    );

    WebViewScreen.push(this, url: uri, onLoaded: null, title: title.toUpperCase(), theme: null);
  }
}

String _getCountryCode3Letter(String code2Letter) {
  final worldCountry = country.WorldCountry.fromCodeShort(code2Letter);

  return worldCountry.code;
}
