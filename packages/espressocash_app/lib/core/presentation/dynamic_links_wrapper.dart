import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../dynamic_links_notifier.dart';

class DynamicLinksWrapper extends StatefulWidget {
  const DynamicLinksWrapper({
    Key? key,
    required this.onLink,
    required this.child,
  }) : super(key: key);

  final LinkCallback onLink;
  final Widget child;

  @override
  State<DynamicLinksWrapper> createState() => _State();
}

class _State extends State<DynamicLinksWrapper> {
  late final StreamSubscription<Uri?> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription =
        context.read<DynamicLinksNotifier>().processLink(widget.onLink);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
