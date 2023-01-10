import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/profile_switch.dart';
import '../src/bl/app_lock_bloc.dart';

class AppLockMenuItem extends StatelessWidget {
  const AppLockMenuItem({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AppLockBloc, AppLockState>(
        builder: (context, state) => ProfileSwitch(
          label: context.l10n.appLock,
          subtitle: context.l10n.appLockDescription,
          value: state is AppLockStateEnabled,
          onChanged: (value) {
            final screen = value
                ? const AppLockEnableRoute()
                : const AppLockDisableRoute();
            context.router.push(AppLockSetupFlowRoute(children: [screen]));
          },
        ),
      );
}
