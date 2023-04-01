import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../ui/snackbar.dart';
import 'connectivity_notifier.dart';

class ConnectivityWrapper extends StatefulWidget {
  const ConnectivityWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<ConnectivityWrapper> createState() => _State();
}

class _State extends State<ConnectivityWrapper> {
  final _snackbarKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<ConnectivityNotifier>().onConnectivityChanged(
      (isOnline) {
        if (isOnline) return;

        showCpErrorSnackbar(
          context,
          message: context.l10n.cannotConnectToTheNetwork,
          scaffoldMessengerKey: _snackbarKey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => ScaffoldMessenger(
        key: _snackbarKey,
        child: Scaffold(body: widget.child),
      );
}
