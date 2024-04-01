import 'package:flutter/material.dart';
import 'package:ramp_flutter/configuration.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

import '../../../../../config.dart';
import '../../../../balances/widgets/context_ext.dart';
import '../../../models/profile_data.dart';

extension BuildContextExt on BuildContext {
  void launchRampNetworkOnRamp({
    required ProfileData profile,
    required String address,
  }) {
    final configuration = _defaultConfiguration
      ..selectedCountryCode = profile.country.code
      ..defaultFlow = 'ONRAMP'
      ..userAddress = address
      ..userEmailAddress = profile.email;

    RampFlutter()
      ..onRampClosed = notifyBalanceAffected
      ..showRamp(configuration);
  }
}

final _defaultConfiguration = Configuration()
  ..hostAppName = 'Espresso Cash'
  ..hostLogoUrl =
      'https://www.espressocash.com/landing/img/asset-2-2x-copy@2x.png'
  ..hostApiKey = rampApiKey
  ..swapAsset = 'SOLANA_USDC'
  ..defaultAsset = 'SOLANA_USDC';
