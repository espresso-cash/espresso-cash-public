import 'package:flutter/material.dart';

import '../pending_activity.dart';

class OSKPCancelScreen extends StatefulWidget {
  const OSKPCancelScreen({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final OSKPPendingActivity activity;

  @override
  State<OSKPCancelScreen> createState() => _OSKPCancelScreenState();
}

class _OSKPCancelScreenState extends State<OSKPCancelScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(),
      );
}

class _RevertSecondPart extends StatelessWidget {
  const _RevertSecondPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: const Text('Reverting second part'),
      );
}
