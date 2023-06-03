import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/profile_switch.dart';
import '../src/data/repository.dart';

class InvestmentsZeroBalanceSwitch extends StatelessWidget {
  const InvestmentsZeroBalanceSwitch({super.key});

  @override
  Widget build(BuildContext context) => Consumer<InvestmentSettingsRepository>(
        builder: (context, state, child) => ProfileSwitch(
          label: context.l10n.displayEmptyBalanceTitle,
          subtitle: context.l10n.displayEmptyBalanceSubtitle,
          value: state.displayEmptyBalances,
          onChanged: (value) =>
              state.toggleDisplayEmptyBalances(isEnabled: value),
        ),
      );
}
