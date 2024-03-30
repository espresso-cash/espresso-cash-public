import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../utils/callback.dart';
import 'models/account.dart';
import 'widgets/account_listener.dart';

class LogoutListener extends SingleChildStatefulWidget {
  const LogoutListener({
    super.key,
    super.child,
    required this.onLogout,
  });

  final Callback1<BuildContext> onLogout;

  @override
  State<StatefulWidget> createState() => _LogoutListenerState();
}

class _LogoutListenerState extends SingleChildState<LogoutListener>
    with AccountListener {
  @override
  void handleAccountChanged(MyAccount? account) {
    if (account == null) {
      widget.onLogout(context);
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      child ?? const SizedBox.shrink();
}
