import 'package:flutter/material.dart';

class LandingArrow extends StatelessWidget {
  const LandingArrow({super.key, this.color = const Color(0xFF2D2B2C)});

  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Icon(Icons.arrow_forward_ios, color: color, size: 18),
      );
}
