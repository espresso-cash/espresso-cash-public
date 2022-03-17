import 'package:cryptoplease/bl/app_lock/app_lock_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/app_lock/app_lock_setup_flow_screen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLockSettingsScreen extends StatelessWidget {
  const AppLockSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.appLock),
            leading: BackButton(
              onPressed: context.read<AppLockSetupRouter>().closeFlow,
            ),
          ),
          body: BlocBuilder<AppLockBloc, AppLockState>(
            builder: (context, state) => CpSwitch(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: context.l10n.enableSecurity,
              value: state is AppLockStateEnabled,
              onChanged: (value) {
                if (value) {
                  context.read<AppLockSetupRouter>().onEnable();
                } else {
                  context.read<AppLockSetupRouter>().onDisable();
                }
              },
            ),
          ),
        ),
      );
}
