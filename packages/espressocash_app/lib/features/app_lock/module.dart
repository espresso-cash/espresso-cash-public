import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/accounts_bloc.dart';
import '../../di.dart';
import 'src/bl/app_lock_bloc.dart';
import 'src/bl/local_auth_repository.dart';
import 'src/widgets/app_lock_screen.dart';

class AppLockModule extends SingleChildStatelessWidget {
  const AppLockModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<AppLockBloc>()
              ..add(const AppLockEvent.init())
              ..add(const AppLockEvent.lock()),
          ),
          ChangeNotifierProvider<LocalAuthRepository>(
            create: (context) => sl<LocalAuthRepository>(),
          ),
        ],
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
          context.read<LocalAuthRepository>().clear();
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
