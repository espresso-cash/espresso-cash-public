import 'package:flutter/material.dart';

class PinDisplay extends StatelessWidget {
  const PinDisplay({
    super.key,
    required this.maxDigits,
    required this.currentDigits,
  });

  final int maxDigits;
  final int currentDigits;

  static final Widget _filled = Container(
    margin: const EdgeInsets.all(7),
    width: 19,
    height: 19,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(width: 0, style: BorderStyle.none),
    ),
  );

  static final Widget _empty = Container(
    margin: const EdgeInsets.all(7),
    width: 19,
    height: 19,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.transparent,
      border: Border.all(width: 4, color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) => Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          maxDigits,
          (index) => index < currentDigits ? _filled : _empty,
        ),
      );
}
