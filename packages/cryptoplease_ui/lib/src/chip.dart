import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

enum CpChipPadding { small, normal }

class CpChip extends StatelessWidget {
  const CpChip({
    Key? key,
    required this.child,
    this.padding = CpChipPadding.normal,
  }) : super(key: key);

  final Widget child;
  final CpChipPadding padding;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          color: CpColors.darkBackground,
          shape: StadiumBorder(),
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
        return const EdgeInsets.symmetric(horizontal: 24);
      case CpChipPadding.normal:
        return const EdgeInsets.symmetric(horizontal: 44, vertical: 8);
    }
  }
}
