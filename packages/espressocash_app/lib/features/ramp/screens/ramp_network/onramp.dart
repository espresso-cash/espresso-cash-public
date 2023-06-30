import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramp_flutter/configuration.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

import '../../../../config.dart';
import '../../../../l10n/device_locale.dart';
import '../../../accounts/models/account.dart';
import '../../../balances/widgets/context_ext.dart';

void onRampOnRamp(BuildContext context) {
  final configuration = _defaultConfiguration
    ..selectedCountryCode = DeviceLocale.localeOf(context).countryCode
    ..defaultFlow = 'ONRAMP'
    ..userAddress = context.read<MyAccount>().wallet.publicKey.toBase58();

  RampFlutter()
    ..onRampClosed = () {
      context
        ..popRoute()
        ..notifyBalanceAffected();
    }
    ..showRamp(configuration);
}

final _defaultConfiguration = Configuration()
  ..hostAppName = 'Espresso Cash'
  ..hostLogoUrl =
      'https://www.espressocash.com/landing/img/asset-2-2x-copy@2x.png'
  ..hostApiKey = rampApiKey
  ..swapAsset = 'SOLANA_USDC'
  ..defaultAsset = 'SOLANA_USDC';
