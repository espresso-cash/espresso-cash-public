import 'package:flutter/material.dart';

class PinDisplay extends StatefulWidget {
  const PinDisplay({
    super.key,
    required this.maxDigits,
    required this.currentDigits,
  });

  final int maxDigits;
  final int currentDigits;

  @override
  State<PinDisplay> createState() => _PinDisplayState();
}

class _PinDisplayState extends State<PinDisplay> {
  static final Widget _filled = Container(
    margin: const EdgeInsets.all(4),
    width: 16,
    height: 16,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(width: 0, style: BorderStyle.none),
    ),
  );

  static final Widget _empty = Container(
    margin: const EdgeInsets.all(4),
    width: 16,
    height: 16,
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
          widget.maxDigits,
          (index) => index < widget.currentDigits ? _filled : _empty,
        ),
      );
}
