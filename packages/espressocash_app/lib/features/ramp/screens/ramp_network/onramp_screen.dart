import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramp_flutter/configuration.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

import '../../../../config.dart';
import '../../../../l10n/device_locale.dart';
import '../../../accounts/models/account.dart';
import '../../../balances/widgets/context_ext.dart';

@RoutePage()
class RampNetworkRampScreen extends StatefulWidget {
  const RampNetworkRampScreen({super.key});

  @override
  State<RampNetworkRampScreen> createState() => _RampNetworkRampScreenState();
}

class _RampNetworkRampScreenState extends State<RampNetworkRampScreen> {
  void onRampOnRamp() {
    final configuration = _defaultConfiguration
      ..selectedCountryCode = DeviceLocale.localeOf(context).countryCode
      ..defaultFlow = 'ONRAMP'
      ..userAddress = context.read<MyAccount>().wallet.publicKey.toBase58();

    RampFlutter()
      ..onRampClosed = () {
        context.notifyBalanceAffected();
      }
      ..showRamp(configuration);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.router.pop();
      onRampOnRamp();
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox();
}

final _defaultConfiguration = Configuration()
  ..hostAppName = 'Espresso Cash'
  ..hostLogoUrl =
      'https://www.espressocash.com/landing/img/asset-2-2x-copy@2x.png'
  ..hostApiKey = rampApiKey
  ..swapAsset = 'SOLANA_USDC'
  ..defaultAsset = 'SOLANA_USDC';
