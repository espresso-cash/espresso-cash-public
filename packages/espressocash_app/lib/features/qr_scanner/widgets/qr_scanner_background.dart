import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../gen/assets.gen.dart';

class QrScannerBackground extends StatefulWidget {
  const QrScannerBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<QrScannerBackground> createState() => _QrScannerBackgroundState();
}

class _QrScannerBackgroundState extends State<QrScannerBackground> {
  late final Future<PictureInfo> _info;

  @override
  void initState() {
    super.initState();
    _info = _readFrame();
  }

  Future<PictureInfo> _readFrame() async {
    final byteData = await rootBundle.load(Assets.images.qrFrame.path);

    return vg.loadPicture(
      SvgBytesLoader(Uint8List.view(byteData.buffer)),
      null,
    );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<PictureInfo?>(
        future: _info,
        builder: (context, snapshot) => CustomPaint(
          foregroundPainter: _Painter(frame: snapshot.data, dimension: 350),
          child: widget.child,
        ),
      );
}

class _Painter extends CustomPainter {
  const _Painter({
    required this.frame,
    required this.dimension,
  });

  final PictureInfo? frame;
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
    final rrect = RRect.fromRectXY(rect.deflate(8), 61.5, 61.5);

    canvas
      ..save()
      ..drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()..addRRect(rrect),
        ),
        Paint()..color = Colors.black.withOpacity(0.5),
      )
      ..translate(center.dx, center.dy);

    final Size svgSize = frame.size;
    final matrix = Matrix4.identity()
      ..scale(
        frameSize.width / svgSize.width,
        frameSize.height / svgSize.height,
      );

    canvas
      ..transform(matrix.storage)
      ..drawPicture(frame.picture)
      ..restore();
  }

  @override
  bool shouldRepaint(covariant _Painter oldDelegate) =>
      oldDelegate.dimension != dimension ||
      oldDelegate.frame?.size != frame?.size;
}
