import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef WidgetTimerBuilder = Widget Function(
  BuildContext context,
  Duration? remaining,
);

class RouteDurationWrapper extends StatefulWidget {
  const RouteDurationWrapper({
    Key? key,
    required this.start,
    required this.onTimeout,
    required this.builder,
  }) : super(key: key);

  final DateTime? start;
  final VoidCallback onTimeout;
  final WidgetTimerBuilder builder;

  @override
  State<RouteDurationWrapper> createState() => _RouteDurationWrapperState();
}

class _RouteDurationWrapperState extends State<RouteDurationWrapper> {
  Stream<Duration?>? stream;

  @override
  void initState() {
    super.initState();
    if (widget.start != null) _initTimer();
  }

  void _initTimer() {
    stream = Stream.periodic(const Duration(seconds: 1), _onTick)
        .take(_routeDuration.inSeconds)
        .startWith(_routeDuration);
  }

  void _stopTimer() {
    stream = null;
  }

  void _onTimeout() {
    widget.onTimeout();
    _stopTimer();
  }

  Duration? _onTick(int ticks) {
    if (ticks == _totalTicks) {
      _onTimeout();

      return null;
    } else {
      return Duration(seconds: _totalTicks - ticks);
    }
  }

  @override
  void didUpdateWidget(covariant RouteDurationWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.start == null) {
      _stopTimer();
    } else if (widget.start != oldWidget.start) {
      _initTimer();
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Duration?>(
        stream: stream,
        builder: (context, snapshot) => widget.builder(
          context,
          stream == null ? null : snapshot.data,
        ),
      );
}

const _routeDuration = Duration(seconds: 15);
final _totalTicks = _routeDuration.inSeconds - 1;
