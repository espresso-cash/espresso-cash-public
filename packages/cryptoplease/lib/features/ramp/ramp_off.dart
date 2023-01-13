import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n.dart';
import '../../core/accounts/bl/account.dart';
import '../../core/tokens/token.dart';
import '../../routes.gr.dart';
import '../../ui/button.dart';
import 'src/widgets/off_ramp_bottom_sheet.dart';

extension RampOffExt on BuildContext {
  void toRampOff() => OffRampBottomSheet.show(this);
}

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
                onPressed: () => context.router.navigate(
                  OnRampRoute(
                    wallet: context.read<MyAccount>().wallet,
                    token: Token.usdc,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              child: CpButton(
                text: context.l10n.cashOut,
                width: double.infinity,
                onPressed: () => context.toRampOff(),
              ),
            ),
          ],
        ),
      );
}
