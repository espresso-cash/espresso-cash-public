import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

class Arrow extends StatelessWidget {
  const Arrow({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: 2,
        child: Assets.icons.arrow.svg(
          height: 14,
          color: color ?? const Color(0xFF2D2B2C),
        ),
      );
}
