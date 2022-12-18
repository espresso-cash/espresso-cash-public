import 'dart:async';

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
  DateTime? expiresAt;

  @override
  void initState() {
    super.initState();
    stream = Stream.periodic(const Duration(seconds: 1), _onTick);
    if (widget.end != null) expiresAt = widget.end;
  }

  void _onTimeout() {
    expiresAt = null;
    widget.onTimeout();
  }

  Duration? _onTick(_) {
    final expiresAt = this.expiresAt;
    if (expiresAt == null) return null;

    final remaining = expiresAt.difference(DateTime.now());
    if (remaining.isNegative) {
      _onTimeout();

      return null;
    }

    return remaining;
  }

  @override
  void didUpdateWidget(covariant RouteDurationWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    final end = widget.end;
    if (end == null || end.isBefore(DateTime.now())) {
      expiresAt = null;
    } else if (end != oldWidget.end) {
      expiresAt = end;
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Duration?>(
        stream: stream,
        builder: (context, snapshot) => widget.builder(
          context,
          expiresAt == null ? null : snapshot.data,
        ),
      );
}
