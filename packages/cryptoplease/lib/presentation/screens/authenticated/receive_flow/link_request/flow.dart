import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class LinkRequestFlowRouter {
  void onNameSubmitted(String name);
}

class LinkRequestFlowScreen extends StatefulWidget {
  const LinkRequestFlowScreen({Key? key}) : super(key: key);

  @override
  State<LinkRequestFlowScreen> createState() => _LinkRequestFlowScreenState();
}

class _LinkRequestFlowScreenState extends State<LinkRequestFlowScreen>
    implements LinkRequestFlowRouter {
  final _router = GlobalKey<AutoRouterState>();

  @override
  void onNameSubmitted(String name) {}

  @override
  Widget build(BuildContext context) => Provider<LinkRequestFlowRouter>.value(
        value: this,
        child: AutoRouter(key: _router),
      );
}
