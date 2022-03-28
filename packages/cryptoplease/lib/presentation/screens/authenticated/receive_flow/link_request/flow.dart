import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LinkRequestFlowScreen extends StatefulWidget {
  const LinkRequestFlowScreen({Key? key}) : super(key: key);

  @override
  State<LinkRequestFlowScreen> createState() => _LinkRequestFlowScreenState();
}

class _LinkRequestFlowScreenState extends State<LinkRequestFlowScreen> {
  @override
  Widget build(BuildContext context) => const AutoRouter();
}
