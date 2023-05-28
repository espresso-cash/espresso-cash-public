import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../gen/assets.gen.dart';

class QrScannerBackground extends StatelessWidget {
  const QrScannerBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  Future<DrawableRoot> _readFrame() async {
    final byteData = await rootBundle.load(Assets.images.qrFrame.path);

    return svg.fromSvgBytes(Uint8List.view(byteData.buffer), 'qrFrame');
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<DrawableRoot>(
        future: _readFrame(),
        builder: (context, frame) => CustomPaint(
          foregroundPainter: _Painter(
            frame: frame.data,
            dimension: 350,
          ),
          child: child,
        ),
      );
}

class _Painter extends CustomPainter {
  const _Painter({
    required this.frame,
    required this.dimension,
  });

  final DrawableRoot? frame;
  final double dimension;

  @override
  void paint(Canvas canvas, Size size) {
    final frame = this.frame;
    if (frame == null) return;

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
    final rrect = RRect.fromRectXY(rect.deflate(5), 35, 35);

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

    frame
      ..scaleCanvasToViewBox(canvas, frameSize)
      ..draw(canvas, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
