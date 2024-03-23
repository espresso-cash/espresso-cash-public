import 'package:flutter/material.dart';

import 'colors.dart';

class LandingArrow extends StatelessWidget {
  const LandingArrow({
    super.key,
    this.color = EcLandingColors.blackTextColor,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Icon(Icons.arrow_forward_ios, color: color, size: 18),
      );
}
