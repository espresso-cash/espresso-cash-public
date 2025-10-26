import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../di.dart';
import '../data/repository.dart';
import '../models/notification.dart';
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
      (notification) => switch (notification) {
        Initialized() => null,
        SessionTerminated() || Deauthorized() => SystemNavigator.pop(),
        RemoteRequsest(:final request) => RemoteRequestScreen.push(context, request: request),
      },
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
