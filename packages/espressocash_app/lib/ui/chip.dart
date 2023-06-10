import 'package:flutter/material.dart';

import 'colors.dart';

enum CpChipPadding { small, normal }

class CpChip extends StatelessWidget {
  const CpChip({
    super.key,
    required this.child,
    this.padding = CpChipPadding.normal,
    this.backgroundColor,
  });

  final Widget child;
  final CpChipPadding padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor ?? CpColors.darkBackground,
          shape: const StadiumBorder(),
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: padding.value,
            child: child,
          ),
        ),
      );
}

extension on CpChipPadding {
  EdgeInsets get value {
    switch (this) {
      case CpChipPadding.small:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 4);
      case CpChipPadding.normal:
        return const EdgeInsets.symmetric(horizontal: 44, vertical: 8);
    }
  }
}
