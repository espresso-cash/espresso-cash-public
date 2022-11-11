import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/switch.dart';
import '../../../../ui/theme.dart';
import 'bl/bloc/investment_settings_bloc.dart';

class InvestmentSettingsScreen extends StatelessWidget {
  const InvestmentSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.settings),
            leading: BackButton(
              onPressed: () => context.router.pop(),
            ),
          ),
          body: BlocBuilder<InvestmentSettingsBloc, InvestmentSettingsState>(
            builder: (context, state) => CpSwitch(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: context.l10n.hideZeroBalanceToggle,
              value: state.hideZeroBalances,
              onChanged: (value) {
                context
                    .read<InvestmentSettingsBloc>()
                    .add(const SettingsToggleBalance());
              },
            ),
          ),
        ),
      );
}
