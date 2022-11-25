import 'package:flutter/material.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
import 'src/intercom_service.dart';

class IntercomModule extends SingleChildStatefulWidget {
  const IntercomModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  State<StatefulWidget> createState() => _IntercomModuleState();
}

class _IntercomModuleState extends SingleChildState<IntercomModule> {
  @override
  void initState() {
    super.initState();
    sl<IntercomService>().login();
  }

  @override
  void dispose() {
    sl<IntercomService>().logout();
    super.dispose();
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      child ?? const SizedBox.shrink();
}

Future<void> displayIntercomMessenger() =>
    sl<IntercomService>().displayMessenger();
