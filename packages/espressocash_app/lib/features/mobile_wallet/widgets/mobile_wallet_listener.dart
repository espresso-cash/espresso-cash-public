import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../di.dart';
import '../data/repository.dart';
import '../screens/remote_request_screen.dart';

class MobileWalletListener extends StatefulWidget {
  const MobileWalletListener({super.key, required this.child});

  final Widget child;

  @override
  State<MobileWalletListener> createState() => _MobileWalletListenerState();
}

class _MobileWalletListenerState extends State<MobileWalletListener> {
  @override
  void initState() {
    super.initState();
    sl<MobileWalletRepository>().addListener(_handleUpdate);
  }

  void _handleUpdate() {
    sl<MobileWalletRepository>().processNotification(
      (notification) => notification.when(
        initialized: ignore,
        sessionTerminated: SystemNavigator.pop,
        deauthorized: SystemNavigator.pop,
        request: (r) => RemoteRequestScreen.push(context, request: r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
