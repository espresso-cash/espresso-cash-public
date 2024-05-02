import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/profile_switch.dart';
import '../screens/app_lock_disable_screen.dart';
import '../screens/app_lock_enable_screen.dart';
import '../services/app_lock_bloc.dart';

class AppLockMenuItem extends StatelessWidget {
  const AppLockMenuItem({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AppLockBloc, AppLockState>(
        builder: (context, state) => ProfileSwitch(
          label: context.l10n.appLock_lblAutoLock,
          subtitle: context.l10n.appLock_lblAutoLockDescription,
          value: state is AppLockStateEnabled,
          onChanged: (value) => value
              ? AppLockEnableScreen.push(context)
              : AppLockDisableScreen.push(context),
        ),
      );
}
