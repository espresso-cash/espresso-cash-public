import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ramp_flutter/ramp_flutter.dart';

import '../../../../../l10n/l10n.dart';
import '../../../config.dart';
import '../../../core/accounts/bl/account.dart';
import '../../../ui/button.dart';
import '../src/widgets/off_ramp_bottom_sheet.dart';

class RampButtons extends StatelessWidget {
  const RampButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: CpButton(
                text: context.l10n.addCash,
                width: double.infinity,
                onPressed: () {
                  final configuration = _defaultConfiguration
                    ..userAddress =
                        context.read<MyAccount>().wallet.publicKey.toBase58();

                  RampFlutter.showRamp(
                    configuration,
                    (_, __, ___) {},
                    () {},
                    () {},
                  );
                },
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              child: CpButton(
                text: context.l10n.cashOut,
                width: double.infinity,
                onPressed: () => OffRampBottomSheet.show(context),
              ),
            ),
          ],
        ),
      );
}

final _defaultConfiguration = Configuration()
  ..hostAppName = 'Espresso Cash'
  ..hostLogoUrl =
      'https://www.espressocash.com/landing/img/asset-2-2x-copy@2x.png'
  ..hostApiKey = rampApiKey
  ..defaultAsset = 'SOLANA_USDC';
