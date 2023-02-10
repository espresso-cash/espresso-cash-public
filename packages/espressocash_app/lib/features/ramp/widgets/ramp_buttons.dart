import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../l10n/l10n.dart';
import '../../../core/accounts/bl/account.dart';
import '../../../core/tokens/token.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../src/widgets/off_ramp_bottom_sheet.dart';

class AddCashButton extends StatelessWidget {
  const AddCashButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Flexible(
        child: CpButton(
          minWidth: 250,
          text: context.l10n.addCash,
          onPressed: () => context.router.navigate(
            OnRampRoute(
              wallet: context.read<MyAccount>().wallet,
              token: Token.usdc,
            ),
          ),
        ),
      );
}

class CashOutButton extends StatelessWidget {
  const CashOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Flexible(
        child: CpButton(
          minWidth: 250,
          text: context.l10n.cashOut,
          onPressed: () => OffRampBottomSheet.show(context),
        ),
      );
}
