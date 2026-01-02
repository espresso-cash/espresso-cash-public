import 'package:flutter/material.dart';
import 'package:sealed_countries/sealed_countries.dart' as country;

import '../../../../../config.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/theme.dart';
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
        'wallet-addresses': 'SOLANA:$address',
        // Theme customization
        'theme-mode': 'light',
        'content-bg': 'FFFFFF',
        'page-bg': 'F5F5F5',
        'input-field-bg': 'F5F5F5',
        'text': '231f20',
        'footer-text': '909090',
        'primary-brand': 'FCC829',
        'primary-cta-bg-active': 'FCC829',
        'primary-cta-bg-inactive': 'C2C2C2',
        'primary-cta-text-active': '231f20',
        'primary-cta-text-inactive': '909090',
        'secondary-cta-bg': 'F5F5F5',
        'secondary-cta-text': '231f20',
        'menu-button': '231f20',
        'logo-url': 'https://www.espressocash.com/images/Espresso-Logo-Large_1.png',
      },
    );

    WebViewScreen.push(
      this,
      url: uri,
      onLoaded: null,
      title: title.toUpperCase(),
      theme: const CpThemeData.light(),
    );
  }
}

String _getCountryCode3Letter(String code2Letter) {
  final worldCountry = country.WorldCountry.fromCodeShort(code2Letter);

  return worldCountry.code;
}
