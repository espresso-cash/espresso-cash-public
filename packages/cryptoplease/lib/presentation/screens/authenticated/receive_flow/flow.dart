import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ReceiveFlowRouter {
  void onAddressSelected();

  void onLinkSelected();
}

class ReceiveFlowScreen extends StatefulWidget {
  const ReceiveFlowScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveFlowScreen> createState() => _ReceiveFlowScreenState();
}

class _ReceiveFlowScreenState extends State<ReceiveFlowScreen>
    implements ReceiveFlowRouter {
  final _router = GlobalKey<AutoRouterState>();

  @override
  void onAddressSelected() {
    _router.currentContext!.navigateTo(const ShareAddressRoute());
  }

  @override
  void onLinkSelected() {
    if (isProd) {
      showCpSnackbar(context, message: 'Coming soon!');
    } else {
      _router.currentContext!.navigateTo(const LinkRequestFlowRoute());
    }
  }

  @override
  Widget build(BuildContext context) => Provider<ReceiveFlowRouter>.value(
        value: this,
        child: AutoRouter(key: _router),
      );
}
