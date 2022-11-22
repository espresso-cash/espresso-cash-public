import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../core/accounts/bl/accounts_bloc.dart';
import '../../di.dart';
import '../../gen/assets.gen.dart';
import '../../l10n/l10n.dart';
import '../../routes.gr.dart';
import 'src/bl/app_lock_bloc.dart';
import 'src/presentation/app_lock_screen.dart';
import 'src/presentation/components/switch.dart';

class AppLockModule extends SingleChildStatelessWidget {
  const AppLockModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (_) => sl<AppLockBloc>()
          ..add(const AppLockEvent.init())
          ..add(const AppLockEvent.lock()),
        child: _Content(child: child),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content>
    with
        // ignore: prefer_mixin, Flutter way
        WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      context.read<AppLockBloc>().add(const AppLockEvent.lock());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLocked =
        context.select<AppLockBloc, bool>((b) => b.state is AppLockStateLocked);

    return BlocListener<AccountsBloc, AccountsState>(
      listenWhen: (s1, s2) => s1.account != s2.account,
      listener: (context, state) {
        if (state.account == null) {
          context.read<AppLockBloc>().add(const AppLockEvent.logout());
        }
      },
      child: Stack(
        children: [
          widget.child ?? const SizedBox.shrink(),
          if (isLocked) const AppLockScreen(),
        ],
      ),
    );
  }
}

class AppLockMenuItem extends StatelessWidget {
  const AppLockMenuItem({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AppLockBloc, AppLockState>(
        builder: (context, state) => MenuSwitch(
          title: context.l10n.appLock,
          description: context.l10n.appLockDescription,
          icon: Assets.icons.lock,
          value: state is AppLockStateEnabled,
          onChanged: (value) {
            if (value) {
              context.router.push(
                const AppLockSetupFlowRoute(
                  children: [AppLockEnableRoute()],
                ),
              );
            } else {
              context.router.push(
                const AppLockSetupFlowRoute(
                  children: [AppLockDisableRoute()],
                ),
              );
            }
          },
        ),
      );
}
