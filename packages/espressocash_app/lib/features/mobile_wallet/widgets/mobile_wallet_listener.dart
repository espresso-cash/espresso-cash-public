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
  // ignore: dispose-fields, not owned by this class
  late final _repository = sl<MobileWalletRepository>();

  @override
  void initState() {
    super.initState();
    _repository.addListener(_handleUpdate);
  }

  @override
  void dispose() {
    _repository.removeListener(_handleUpdate);
    super.dispose();
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
