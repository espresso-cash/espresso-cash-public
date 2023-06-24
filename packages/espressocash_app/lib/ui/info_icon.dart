import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import 'colors.dart';

class CpInfoIcon extends StatelessWidget {
  const CpInfoIcon({
    super.key,
    this.iconColor = CpColors.backgroundAccentColor,
    this.height = 20,
  });
  final Color iconColor;
  final double height;

  @override
  Widget build(BuildContext context) => Assets.icons.info.svg(
        color: iconColor,
        height: height,
      );
}
