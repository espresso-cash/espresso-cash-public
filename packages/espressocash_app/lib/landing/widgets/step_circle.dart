import 'package:flutter/material.dart';

class StepCircle extends StatelessWidget {
  const StepCircle(this.number, {super.key});

  final int number;

  @override
  Widget build(BuildContext context) => Container(
        width: 46,
        height: 46,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: OvalBorder(),
        ),
        child: Center(
          child: Text(
            number.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2D2B2C),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
