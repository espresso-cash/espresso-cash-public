import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class LinkRequestFlowRouter {
  void onNameSubmitted(String name);

  void onAmountSubmitted();
}

class LinkRequestFlowScreen extends StatefulWidget {
  const LinkRequestFlowScreen({Key? key}) : super(key: key);

  @override
  State<LinkRequestFlowScreen> createState() => _LinkRequestFlowScreenState();
}

class _LinkRequestFlowScreenState extends State<LinkRequestFlowScreen>
    implements LinkRequestFlowRouter {
  @override
  void onNameSubmitted(String name) =>
      context.navigateTo(const RequestAmountRoute());

  @override
  void onAmountSubmitted() {
    // TODO(KB): submit, then navigate to details
    context.router.parent()?.pop();
  }

  @override
  Widget build(BuildContext context) => Provider<LinkRequestFlowRouter>.value(
        value: this,
        child: const AutoRouter(),
      );
}
