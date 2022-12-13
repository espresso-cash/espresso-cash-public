import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

typedef WidgetTimerBuilder = Widget Function(
  BuildContext context,
  Duration? remaining,
);

class RouteDurationWrapper extends StatefulWidget {
  const RouteDurationWrapper({
    Key? key,
    required this.end,
    required this.onTimeout,
    required this.builder,
  }) : super(key: key);

  final DateTime? end;
  final VoidCallback onTimeout;
  final WidgetTimerBuilder builder;

  @override
  State<RouteDurationWrapper> createState() => _RouteDurationWrapperState();
}

class _RouteDurationWrapperState extends State<RouteDurationWrapper> {
  late final Stream<Duration?> stream;
  late bool enabled;

  @override
  void initState() {
    super.initState();
    enabled = false;
    stream = Stream.periodic(const Duration(seconds: 1), _onTick);
    if (widget.end != null) _initTimer();
  }

  void _initTimer() => enabled = true;

  void _stopTimer() => enabled = false;

  void _onTimeout() {
    widget.onTimeout();
    _stopTimer();
  }

  Duration? _onTick(_) {
    if (!enabled) return null;

    final remaining = widget.end?.let((d) => d.difference(DateTime.now()));
    if (remaining == null || remaining.isNegative) {
      _onTimeout();

      return null;
    }

    return remaining;
  }

  @override
  void didUpdateWidget(covariant RouteDurationWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.end == null) {
      _stopTimer();
    } else if (widget.end != oldWidget.end) {
      _initTimer();
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Duration?>(
        stream: stream,
        builder: (context, snapshot) => widget.builder(
          context,
          enabled ? snapshot.data : null,
        ),
      );
}
