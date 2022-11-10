import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../ui/app_bar.dart';
import '../../../../../ui/switch.dart';
import '../../../../../ui/theme.dart';
import '../bl/bloc/investment_settings_bloc.dart';

class InvestmentSettingsScreen extends StatelessWidget {
  const InvestmentSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: Scaffold(
          appBar: CpAppBar(
            title: const Text('Settings'),
            leading: BackButton(
              onPressed: () => context.router.pop(),
            ),
          ),
          body: BlocBuilder<InvestmentSettingsBloc, InvestmentSettingsState>(
            builder: (context, state) => CpSwitch(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: 'Hide Zero balances tokens',
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
