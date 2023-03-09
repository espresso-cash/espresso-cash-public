import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../../routes.gr.dart';
import 'src/repository.dart';

class MobileWalletModule extends SingleChildStatelessWidget {
  const MobileWalletModule({
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: sl<MobileWalletRepository>()),
        ],
        child: RemoteRequestListener(
          child: child ?? const SizedBox.shrink(),
        ),
      );
}

class RemoteRequestListener extends StatefulWidget {
  const RemoteRequestListener({super.key, required this.child});

  final Widget child;

  @override
  State<RemoteRequestListener> createState() => _RemoteRequestListenerState();
}

class _RemoteRequestListenerState extends State<RemoteRequestListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<MobileWalletRepository>().processNotification(
          (notification) => notification.maybeWhen(
            orElse: ignore,
            request: (r) => context.router.push(MobileWalletFlow(request: r)),
          ),
        );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
