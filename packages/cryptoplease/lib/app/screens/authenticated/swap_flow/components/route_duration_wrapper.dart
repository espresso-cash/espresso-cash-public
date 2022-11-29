import 'dart:async';

import 'package:flutter/material.dart';

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
  late Stream<Duration?> _stream;

  @override
  void initState() {
    super.initState();
    _stream = const Stream.empty();
    if (widget.start != null) _initTimer();
  }

  void _initTimer() {
    _stream = Stream.periodic(_interval, _onTick).take(_routeDuration + 1);
  }

  void _onTimeout() => widget.onTimeout();

  Duration? _onTick(int ticks) {
    if (ticks == _routeDuration) {
      _onTimeout();

      return null;
    } else {
      return Duration(seconds: _routeDuration - ticks);
    }
  }

  @override
  void didUpdateWidget(covariant RouteDurationWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.start != null && widget.start != oldWidget.start) _initTimer();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Duration?>(
        stream: _stream,
        builder: (context, snapshot) => widget.builder(context, snapshot.data),
      );
}

const _interval = Duration(seconds: 1);
final _routeDuration = const Duration(seconds: 15).inSeconds;
