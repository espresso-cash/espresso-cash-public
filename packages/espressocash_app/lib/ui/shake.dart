import 'dart:math';

import 'package:flutter/material.dart';

class Shake extends StatefulWidget {
  const Shake({super.key, required this.child});

  final Widget child;

  @override
  State<Shake> createState() => ShakeState();
}

class ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );

  // ignore: prefer-widget-private-members, used for controlling the animation
  void shake() => _controller
    ..reset()
    ..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) {
          final t = _controller.value;
          final offset = exp(-t) * cos(6 * pi * t + pi / 2);

          return Transform.translate(
            offset: Offset(offset * 10, 0),
            child: child,
          );
        },
      );
}
