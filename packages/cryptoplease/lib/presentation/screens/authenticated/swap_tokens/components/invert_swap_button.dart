import 'dart:math' as math;

import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class InvertSwapButton extends StatelessWidget {
  const InvertSwapButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Center(
        child: Material(
          child: Ink(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CpColors.darkBackground,
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.rotate(
                  angle: math.pi / 2,
                  child: Assets.icons.swap.svg(
                    color: Colors.white,
                    width: 20,
                    height: 20,
                  ),
                ),
              ), // other widget
            ),
          ),
        ),
      );
}
