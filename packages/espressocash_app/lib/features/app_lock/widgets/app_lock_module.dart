import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di.dart';
import '../../accounts/models/account.dart';
import '../../accounts/widgets/account_listener.dart';
import '../screens/app_lock_screen.dart';
import '../services/app_lock_bloc.dart';

class AppLockModule extends StatelessWidget {
  const AppLockModule({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => sl<AppLockBloc>()
          ..add(const AppLockEvent.init())
          ..add(const AppLockEvent.lock()),
        child: _Content(child: child),
      );
}

class _Content extends StatefulWidget {
  const _Content({this.child});

  final Widget? child;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content>
    with
        // ignore: prefer_mixin, Flutter way
        WidgetsBindingObserver,
        AccountListener {
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
  void handleAccountChanged(MyAccount? account) {
    if (account == null) {
      context.read<AppLockBloc>().add(const AppLockEvent.logout());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLocked =
        context.select<AppLockBloc, bool>((b) => b.state is AppLockStateLocked);

    return Stack(
      children: [
        widget.child ?? const SizedBox.shrink(),
        if (isLocked) const AppLockScreen(),
      ],
    );
  }
}
