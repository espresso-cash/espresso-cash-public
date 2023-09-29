import 'dart:math';

import 'package:flutter/material.dart';

class QrScannerBackground extends StatelessWidget {
  const QrScannerBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => CustomPaint(
        foregroundPainter: const _Painter(dimension: 350),
        child: child,
      );
}

class _Painter extends CustomPainter {
  const _Painter({
    required this.dimension,
  });

  final double dimension;

  @override
  void paint(Canvas canvas, Size size) {
    final frameSize = Size.square(dimension);

    final topDisplacement = min(
      220.0,
      (size.height / 2) - (frameSize.height / 2),
    );

    final center = Offset(
      (size.width / 2) - (frameSize.width / 2),
      topDisplacement,
    );

    final rect = center & frameSize;
    final rrect = RRect.fromRectXY(rect.deflate(8), 61.5, 61.5);

    canvas
      ..drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()..addRRect(rrect),
        ),
        Paint()..color = Colors.black.withOpacity(0.5),
      )
      ..translate(center.dx, center.dy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
