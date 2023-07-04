import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../models/ramp_type.dart';

class AddCashButton extends StatelessWidget {
  const AddCashButton({
    super.key,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Flexible(
        child: CpButton(
          size: size,
          minWidth: 250,
          text: context.l10n.ramp_btnAddCash,
          onPressed: () =>
              context.router.push(RampFlowRoute(type: RampType.onRamp)),
        ),
      );
}

class CashOutButton extends StatelessWidget {
  const CashOutButton({
    super.key,
    this.size = CpButtonSize.normal,
  });

  final CpButtonSize size;

  @override
  Widget build(BuildContext context) => Flexible(
        child: CpButton(
          size: size,
          minWidth: 250,
          text: context.l10n.ramp_btnCashOut,
          onPressed: () =>
              context.router.push(RampFlowRoute(type: RampType.offRamp)),
        ),
      );
}
