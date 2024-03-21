import 'package:flutter/material.dart';

import '../core/extensions.dart';

class StepCircle extends StatelessWidget {
  const StepCircle(this.number, {super.key});

  final int number;

  @override
  Widget build(BuildContext context) => Container(
        width: isMobile ? 36 : 46,
        height: isMobile ? 36 : 46,
        decoration: const ShapeDecoration(
          color: Colors.black,
          shape: OvalBorder(),
        ),
        child: Center(
          child: Text(
            '$number',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
