import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramp_flutter/configuration.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

import '../../../config.dart';
import '../../../l10n/device_locale.dart';
import '../../accounts/models/account.dart';
import '../../balances/widgets/context_ext.dart';

extension BuildContextExt on BuildContext {
  void showRampNetworkOnRamp() {
    final configuration = _defaultConfiguration
      ..selectedCountryCode = DeviceLocale.localeOf(this).countryCode
      ..defaultFlow = 'ONRAMP'
      ..userAddress = read<MyAccount>().wallet.publicKey.toBase58();

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
